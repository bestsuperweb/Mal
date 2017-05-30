ActiveAdmin.register Level do
  config.filters = false
  menu priority: 5
  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end
end
