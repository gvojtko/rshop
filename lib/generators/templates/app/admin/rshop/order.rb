ActiveAdmin.register Rshop::Order do
  actions :all, :except => [:new]
  permit_params :status
  # scope_to :current_user

  form do |f|
    f.inputs do
      f.input :status, as: :select, collection: Rshop::Order.status_options.invert
    end
    f.actions
  end

  show do |order|
    attributes_table do
      row :user
      row :status do
        order.status_title
      end
      row :payment
      row :delivery
      row :comments
      row :order_items do
        render 'rshop/admin/order/order_items', order_items: order.order_items
      end
      row :cost do
        number_to_currency (order.cost)
      end
      row :address do
        render 'rshop/admin/order/address', address: order.address
      end
    end
    active_admin_comments
  end

  filter :payment
  filter :delivery
  filter :id
end
