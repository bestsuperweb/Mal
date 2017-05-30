class User::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  layout "application"

  # GET /register
  def new
    super
  end

  def step1
    @user = User.new
    @user_type = "Student"
    @user_type = "Teacher" if params[:user_type] == "Teacher"
  end

  # POST /registration
  def create
    if params[:cancel]
      redirect_to root_url
    elsif params[:continue]
      @user = User.new(user_params)
      @user.verified = true if @user.teacher?
      if @user.save
        sign_in @user
        redirect_to step2_path
      else
        render :step1
      end
    else
      raise ApplicationController::RoutingError.new('Not Found')
    end
  end

  def step2
    @user ||= current_user
  end

  def step3
    @user ||= current_user
  end

  def update_info
    @user ||= current_user
    if params[:cancel]
      redirect_to root_url
    elsif params[:file]
      @user.assign_attributes(avatar: params[:file])

      if @user.save
        render json: { message: "success", fileID: @user.id }, status: 200
      else
        render json: { error: @user.errors.full_messages.join(',') }, status: 400
      end
    elsif params[:continue]
      if @user.teacher?
        redirect_to profile_path
      else
        redirect_to step3_path
      end
    end
  end

  def remove_avatar
    @user ||= current_user
    @user.avatar = nil
    if @user.save
      render json: { message: "File removed!" }
    else
      render json: { message: @user.errors.full_messages.join(',') }
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :user_type, :email, :password, :notifications,
        :first_name, :last_name, :address, :region, :city,
        :country, :zipcode, :phone, :description, :notifications
      )
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
