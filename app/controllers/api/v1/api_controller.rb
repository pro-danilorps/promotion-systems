class Api::V1::ApiController < ActionController::API
  respond_to :json
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :not_acceptable_error

  private

    def not_found_error
      head 404
    end
    
    def not_acceptable_error
      head 406
    end
end