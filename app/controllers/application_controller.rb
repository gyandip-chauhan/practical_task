class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session
	respond_to :json
	before_action :authenticate_user
	skip_before_action :verify_authenticity_token

	def authenticate_user
    if request.headers['Authorization'].present?
      begin
        jwt_payload = JWT.decode(request.headers['Authorization'], Rails.application.secrets.secret_key_base).first

        @current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        render json: {errors: "Unauthorized"}, status: 401
      end
    else
    	render json: {errors: "Unauthorized"}, status: 401
    end
	end

	private

	def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end
end
