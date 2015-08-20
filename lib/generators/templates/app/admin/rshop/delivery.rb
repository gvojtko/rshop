ActiveAdmin.register Rshop::Delivery do
  permit_params :name
  config.filters = false
end
