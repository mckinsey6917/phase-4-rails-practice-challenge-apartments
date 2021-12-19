class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid


    def index 
        tenants = Tenant.all 
        render json: tenants
    end

    def show 
        tenant = find_params
        render json: tenant
    end

    def create 
        tenant = Tenant.create!(create_params)
        render json: tenant, status: :created
    end

    def update 
        tenant = find_params
        tenant.update!(create_params)
        render json: tenant, status: :ok
    end

    def destroy 
        tenant = find_params
        tenant.destroy 

        head :no_content
    end
   

private 

    def create_params
        params.permit(:name, :age)
    end

    def find_params
        Tenant.find(params[:id])
    end

    def record_not_found(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end

    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
