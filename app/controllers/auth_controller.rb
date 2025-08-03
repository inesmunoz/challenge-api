class AuthController < ApplicationController
    skip_before_action :authorize_request, only: [:login]
    def login
          Rails.logger.info "PARAMS: #{params.inspect}"
        user = User.find_by(email: params[:email])
         Rails.logger.info "USER: #{user.inspect}"
        if user&.authenticate(params[:password])
             Rails.logger.info "AUTH OK"
            token = encode_jwt({ user_id: user.id })
            render json: { token: token}, status: :ok
        else
            Rails.logger.info "AUTH FAIL"
            render json: { error: "Invalid credentials" }, status: :unauthorized
        end
    end
end
