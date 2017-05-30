ActiveAdmin.register User do
  menu priority: 6, label: "Teachers/Students"
  actions :index, :show

  scope :teachers
  scope :students
  scope :inactive

  index do
    column :email
    column :name do |user|
      user.full_name
    end
    column :last_sign_in_at
    column :user_type
    column :address do |u|
      u.full_address
    end
    column :avatar do |u|
      image_tag(u.avatar, width: "100px;")
    end
    column "Verified?", :verified
    column "Email Notifications?", :notifications
    column :created_at
    actions do |user|
      html_str = ""
      if user.active?
        html_str += link_to("Deactivate", deactivate_admin_user_path(user), method: :post, "data-confirm" => "Are you sure you would like to deactivate #{user.full_name}")
      else
        html_str += link_to("Activate", activate_admin_user_path(user), method: :post, "data-confirm" => "Are you sure you would like to activate #{user.full_name}")
      end
      if user.teacher? && !user.verified?
        html_str += link_to("Verify", verify_admin_user_path(user), method: :post, "data-confirm" => "Are you sure you would like to mark #{user.full_name} as a \"Verified Teacher\"?")
      end
      html_str.html_safe
    end
  end

  action_item :deactivate, only: :show, if: proc{ user.active? } do
    link_to "Deactivate", deactivate_admin_user_path(user), method: :post, "data-confirm" => "Are you sure you would like to deactivate #{user.full_name}"
  end

  action_item :reactivate, only: :show, if: proc{ !user.active? } do
    link_to "Activate", activate_admin_user_path(user), method: :post, "data-confirm" => "Are you sure you would like to activate #{user.full_name}"
  end

  action_item :verify, only: :show, if: proc{ user.teacher? && !user.verified? } do
    link_to "Verify", verify_admin_user_path(user), method: :post, "data-confirm" => "Are you sure you would like to mark #{user.full_name} as a \"Verified Teacher\"?"
  end

  member_action :deactivate, method: :post do
    user = User.find(params[:id])
    user.update_attributes(active: false)
    redirect_to admin_users_path, notice: "#{user.full_name} has been deactivated."
  end

  member_action :activate, method: :post do
    user = User.unscoped.find(params[:id])
    user.update_attributes(active: true)
    redirect_to admin_users_path, notice: "#{user.full_name} has been activated."
  end

  member_action :verify, method: :post do
    user = User.find(params[:id])
    user.update_attributes(verified: true)
    redirect_to :back, notice: "#{user.full_name} has been marked as a \"Verified Teacher\"."
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :address
  filter :city
  filter :verified

  controller do
    def find_resource
      User.unscoped.where(id: params[:id]).first!
    end
  end

end
