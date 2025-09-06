module Api
  module V1
    class CustomersController < ApplicationController
      
      def upload
        file = params[:file]
        return render json: { error: 'file param is required' }, status: :bad_request unless file
        
        
        customers = Customers::Importer.new(file).call
        filtered = customers.select do |cust|
          Customers::DistanceCalculator.within_radius_km?(cust[:latitude].to_f, cust[:longitude].to_f, radius_km: 100)
        end
        sorted = filtered.sort_by { |c| c[:user_id].to_i }
        result = sorted.map { |c| { user_id: c[:user_id].to_i, name: c[:name] } }

        render json: result
      rescue Customers::Importer::ParseError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end
  end
end