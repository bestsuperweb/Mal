class Credit < ActiveRecord::Base
  STATUSES = %w(purchased transferred redeemed)

  belongs_to :user
  validates :user, :status, presence: true

  scope :purchased_not_used, -> { where(status: "purchased") }
  scope :userd_not_redeemed, -> { where(status: "transferred") }
  scope :redeemed, -> { where(status: "redeemed") }

  def purchase
  	response = process_purchase
  	response.success?
  end

  def price_in_cents
  	(self.price * 100).round
  end

  def express_token=(token)
  	self[:express_token] = token
  	if new_record? && !token.blank?
  		details = EXPRESS_GATEWAY.details_for(token)
  		self.express_payer_id = details.payer_id
  		self.payer_email = details.params['payer']
  		self.first_name = details.params['first_name']
  		self.last_name = details.params['last_name']
  		self.price = details.params['amount']
  	end
  end

  private
  	def process_purchase
  		unless express_token.blank?
  			EXPRESS_GATEWAY.purchase(price_in_cents, express_checkout_options)
  		end
  	end

	  def express_checkout_options
	  	{
	  		ip: ip,
	  		token: express_token,
	  		payer_id: express_payer_id
	  	}
  end
end
