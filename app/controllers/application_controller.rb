require 'jwt'
class ApplicationController < ActionController::API
    include Pundit::Authorization
    before_action :authorize_request

    SECRET_KEY = ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base.to_s

    def encode_jwt(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end

    def decode_jwt(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
          puts "decoded: #{decoded.inspect}"
        HashWithIndifferentAccess.new(decoded)
    rescue
        nil
    end

    def current_user
        header = request.headers['Authorization']
        token = header.split(' ').last if header
        decoded = decode_jwt(token)
        if decoded
            @current_user ||= User.find_by(id: decoded[:user_id])
        end
    end

    def authorize_request
        render json: { error: "No autorizado" }, status: :unauthorized unless current_user
    end

    def authorize_admin
        render json: { error: "Solo admin" }, status: :forbidden unless current_user&.has_role?(:admin)
    end
end
