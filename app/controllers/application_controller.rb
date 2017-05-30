class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_search

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_dashboard_path
    else
      profile_path
    end
	end

  def site_setting(key)
    SiteSetting.where(key: key).first.try(:value) || "N/A"
  end
  helper_method :site_setting

  private

  def set_search
    @q ||= User.ransack
  end
end
