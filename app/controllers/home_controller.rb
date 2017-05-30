class HomeController < ApplicationController
	layout "application"
	def index
	end

	def about
	end

	def contact
		@contact_form = ContactForm.new
	end

	def terms
	end

	def privacy
	end
end
