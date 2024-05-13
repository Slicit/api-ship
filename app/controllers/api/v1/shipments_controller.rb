module Api
  module V1
    class ShipmentsController < ApplicationController
      include ::CrudConcern

      def object_class
        Shipment
      end

      private

      # We want to ensure company_id is present in the params
      def filter(object_class, object_params)
        object_class = super(object_class, object_params)

        # We want to ensure company_id is present but only for index action
        raise 'company_id is required' if object_params[:company_id].blank? && action_name == 'index'

        object_class = object_class.with_relations.all
        object_class = object_class.where(company_id: object_params[:company_id])

        # We allow more params to be filtered
        if object_params[:international_transportation_mode].present?
          object_class = object_class.where(
            international_transportation_mode: object_params[:international_transportation_mode]
          )
        end

        object_class
      end
    end
  end
end
