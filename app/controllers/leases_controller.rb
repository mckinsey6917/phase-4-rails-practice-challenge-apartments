class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index 
        leases = Lease.all
        render json: leases 

    end
    def show 
        lease = Lease.find(params[:id])
        render json: lease
    end
    
    def create 
        lease = lease.create!(create_params)
        render json: lease, status: :created
    end

    def destroy 
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

private 

    def create_params
        params.permit(:rent, :tenant_id, :apartment_id)
    end

    def record_not_found(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end

    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
