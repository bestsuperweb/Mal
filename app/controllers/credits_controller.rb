class CreditsController < ApplicationController
	before_filter :authenticate_user!
	layout "application"

	def express_checkout
		@param = params[:plan].to_i
		if @param == 3
      @price = (site_setting("3_credit_pack_price").to_f * 100).round
      @plan = "3 Credit Pack (Basic)"
    elsif @param == 6
      @price = (site_setting("6_credit_pack_price").to_f * 100).round
      @plan = "6 Credit Pack (Advanced)"
    elsif @param == 12
      @price = (site_setting("12_credit_pack_price").to_f * 100).round
      @plan = "12 Credit Pack (Major)"
    else
      @price = (site_setting("credit_price").to_f * 100).round
      @plan = "1 Credit"
    end

    response = EXPRESS_GATEWAY.setup_purchase(@price,
    	ip: request.remote_ip,
    	return_url: confirm_url(@param, total: @price),
    	cancel_return_url: step3_url,
    	allow_guest_checkout: true,
    	items: [{ name: @plan, description: "MAL Credit purchase", quantity: 1, amount: @price }]
    )
    if response.success?
    	redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
    else
			redirect_to step3_path, alert: "Something went wrong, please try again"
    end
	end

	def express
		@quantity = params[:quantity]
		price = site_setting("credit_price").to_f
		@amount = ((@quantity.to_i) * price * 100).round

		response = EXPRESS_GATEWAY.setup_purchase(@amount,
			ip: request.remote_ip,
			return_url: confirm_url(@quantity, total: @amount),
			cancel_return_url: profile_url,
			allow_guest_checkout: true,
			items: [{ name: "MAL Credit purchase", quantity: 1, amount: @amount }]
		)
		if response.success?
			redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
		else
			redirect_to profile_path, notice: "Something went wrong, please try again"
		end
	end

	def confirm
		@user ||= current_user

		quantity = params[:param].to_i || 1
		@result = EXPRESS_GATEWAY.purchase(params[:total].to_i, express_purchase_options(request.remote_ip, params))
    if @result.success?
			quantity.times do
				c = @user.credits.create(express_token: params[:token], ip: request.remote_ip, price: params[:total].to_f / 100 / quantity.to_f)
			end
			redirect_to profile_path, notice: "Purchased successfully!"
		else
			redirect_to profile_path, notice: "Something went wrong, please try again"
		end
	end

	def transfer_to_teacher
		begin
			class_room = ClassRoom.find_by_id(params[:class])
			student = User.find_by_id(class_room.recipient.id)
			credit = student.credits.purchased_not_used.first
			credit.update(user_id: current_user.id, status: Credit::STATUSES.second)
			class_room.update_column('with_credit', false)
		rescue
			@error = "Something went wrong! Please try again later."
		end
		@completed = current_user.class_rooms.class_chats.completed.reload

		respond_to do |format|
			format.js
		end
	end

	def redeem
		quantity_credits = params[:quantity].to_i
		amount = (SiteSetting.find_by(key: 'credit_redeem_price').value.to_f * quantity_credits * 100).round
		email = params[:email]

		payout = REDEEM_GATEWAY.transfer(amount, email,
			subject: "Payment from Music Academy",
			note: "Thanks for your business"
		)
		if payout.success?
			credits = current_user.credits.userd_not_redeemed.first(quantity_credits)
			credits.map { |credit| credit.update(status: Credit::STATUSES.last) }
			redirect_to profile_path, notice: "Success! Credits were transferred to Your Paypal account"
		else
			redirect_to profile_path, notice: "Failure! Something went wrong! Please try again later."
		end
	end

	def create
		@user ||= current_user
		a = []
		quantity = params[:param].to_i
		quantity.times do
			a << @user.credits.build(credit_params)

		end

		if a.each(&:save)
			@credit = a.first
			if @credit.purchase
				redirect_to profile_path, notice: "Your Credit was purchased"
			else
				redirect_to confirm_path, notice: "Not purchased"
			end
		else
			redirect_to confirm_path, notice: "Not saved"
		end
	end

	private
		def express_purchase_options(ip, params)
	    {
	      ip: ip,
	      token: params[:token],
	      payer_id: params[:PayerID]
	    }
	  end
end
