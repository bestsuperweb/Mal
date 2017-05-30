paypal_options = {
  login: SiteSetting.find_by(key: "paypal_login").try(:value) || "",
  password: SiteSetting.find_by(key: "paypal_password").try(:value) || "",
  signature: SiteSetting.find_by(key: "paypal_signature").try(:value) || ""
}
if paypal_options[:login].present? && paypal_options[:password].present? && paypal_options[:signature].present?
  ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  ::REDEEM_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
end
