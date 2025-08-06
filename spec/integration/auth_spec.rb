require 'swagger_helper'

RSpec.describe 'Auth API', type: :request do
  path '/login' do
    post 'Login user and returns JWT token' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w['email', 'password']
      }

      response '200', 'valid credentials' do
        let!(:role) { Role.find_or_create_by!(name: 'administrador') }
        let!(:user) { User.create!(email: 'test@example.com', password: '123456', role: role) }
        let(:credentials) { { email: user.email, password: '123456' } }

        run_test!
      end

      response '401', 'invalid credentials' do
        let(:credentials) { { email: 'wrong@example.com', password: 'wrong' } }

        run_test!
      end
    end
  end
end
