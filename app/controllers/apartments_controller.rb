class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index 
        apartments = Apartment.all 
        render json: apartments
    end

    def show 
        apartment = find_params
        render json: apartment
    end

    def create 
        apartment = Apartment.create!(create_params)
        render json: apartment, status: :created
    end

    def update 
        apartment = find_params
        apartment.update!(create_params)
        render json: apartment, status: :ok
    end

    
    def destroy 
        apartment = find_params
        apartment.destroy 
        head :no_content
    end


private 

    def create_params 
        params.permit(:number)
    end

    def find_params 
        Apartment.find(params[:id])
    end

    def record_not_found(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end

    def record_invalid(invalid) 
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end


