ActiveAdmin.register Credit do
  menu priority: 7
  permit_params :user_id, :status
  actions :show, :index, :new, :create

  scope :purchased_not_used
  scope :userd_not_redeemed
  scope :redeemed

  index do
    column :user do |c|
      c.user.full_name
    end
    column :status
    actions
  end

  form do |f|
    f.inputs "Credit Details" do
      f.input :user, as: :select2
      f.input :status, as: :select2, collection: Credit::STATUSES, include_blank: false
    end
    f.actions
  end
end
