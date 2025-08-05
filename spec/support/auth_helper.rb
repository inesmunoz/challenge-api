# spec/support/auth_helper.rb
module AuthHelper
  def generate_token(user)
    secret_key = ENV['SECRET_KEY_BASE'] || Rails.application.credentials.secret_key_base 

    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, secret_key)
  end
end
