ActiveAdmin.register Instrument do
  config.filters = false
  menu priority: 3
  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end
end
