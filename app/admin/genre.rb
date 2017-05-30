ActiveAdmin.register Genre do
  config.filters = false
  menu priority: 4
  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end
end
