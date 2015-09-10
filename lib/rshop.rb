require "rshop/version"

module Rshop
  autoload :ApplicationController, 'rshop/application_controller'
  autoload :AutoApplicationController, 'rshop/auto_application_controller'

  class Engine < Rails::Engine
  end

  class Router
    def self.routes router
      router.instance_exec do
        namespace :ajax do
          namespace :rshop do
            get 'products/search' => 'products#search', as: :products_search
          end
        end

        scope :cart do
          post 'items' => 'rshop/cart#create_item', as: :cart_items
          delete 'items/:id' => 'rshop/cart#delete_item', as: :cart_item
          get '' => 'rshop/cart#show', as: :cart
          patch '' => 'rshop/cart#update'
          delete '' => 'rshop/cart#delete'
        end

        scope :checkout do
          patch 'save' => 'rshop/checkout#save', as: :checkout_save
          get 'form' => 'rshop/checkout#form', as: :checkout_form
          get 'ty' => 'rshop/checkout#ty', as: :checkout_ty
        end

        get 'products' => 'rshop/products#all', as: :products
        get 'p-:slug' => 'rshop/products#show', as: :product

        get 'brands' => 'rshop/brands#index', as: :brands
        get 'b-:slug' => 'rshop/brands#show', as: :brand
      end
    end
  end
end

ActiveSupport.on_load :action_controller do
  include Rshop::ApplicationController
end
