class ContactFormsController < ApplicationController
  def create
    @contact_form = ContactForm.new(params[:contact_form])
    @contact_form.request = request
    if @contact_form.deliver
      flash[:notice] = 'Thank you for your message. We will contact you soon!'
      redirect_to root_path
    else
      flash[:alert] = @contact_form.errors.full_messages.join("<br>")
      redirect_to contact_path
    end
  end
end
