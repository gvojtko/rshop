ActiveAdmin.register Rshop::Payment do
  permit_params :name
  config.filters = false
end
