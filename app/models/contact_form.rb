class ContactForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :subject,      :validate => true
  attribute :message, validate: true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :category, validate: true
  attribute :priority, validate: true
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Music Academy Live Contact Form",
      :to => SiteSetting.where(key: "contact_email").first.try(:value),
      :from => %("#{name}" <#{email}>)
    }
  end
end
