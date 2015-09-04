module Rshop
  module AutoApplicationController
    def self.included(base)
      base.class_eval do
        include ClassMethods
        before_action :json_filters
      end
    end

    module ClassMethods
      def json_filters
        return unless defined?(Rshop::AutoMark)

        # @filters_json = Rails.cache.fetch("@filters_json<touch_filters_cache>v2", expires_in: 1.hour) do
        marks = Rshop::AutoMark.all.order('name asc').includes(models: :categories)
        @filters_json = marks.to_json(
            only: [:id, :name],
            include:{
                models: {
                    only: [:id, :name],
                    include: {
                        :categories => {
                            only: [:id, :name],
                            include: {
                                subcategories: {
                                    only: [:id, :name],
                                }
                            }
                        }
                    }
                },
            }
        )
        # end
      end

      def set_auto_filters options = {}
        # form = Hash [:mark, :model, :category, :subcategory].map{ |name| [options[name] ? options[name] : :null] }
        @auto_filters_json = options.to_json
      end
    end
  end
end