class DashboardHelper
  # fix error in migration
  def self.get_orders
    Rshop::Order.in_q.all
  rescue
    []
  end
end

ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  orders = DashboardHelper.get_orders

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        if orders.count > 0
          h2 "Заказы к обработке (#{orders.count}шт.)"
          ul do
            orders.each do |order|
              li do
                a href: admin_rshop_order_path(order) do
                  "##{order.id} на #{order.cost}грн"
                end
              end
            end
          end
        else
          h2 "В ожидании новых заказов"
        end
      end
    end
  end
end

