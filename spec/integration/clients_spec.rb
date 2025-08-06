require 'swagger_helper'

RSpec.describe 'Clients API', type: :request do
  let!(:role) { Role.find_or_create_by!(name: "administrador") }
  let!(:user) do
    User.find_by(email: "test@example.com") ||
      User.create!(
        email: "test@example.com",
        password: "123456",
        role: role
      )
  end  
  path '/clients' do
    get 'List all clients' do
      tags 'Clients'
      security [ bearerAuth: [] ]
      produces 'application/json'

      response '200', 'clients listed' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        before { create(:client) }
        run_test!
      end
    end

    post 'Create a client' do
      tags 'Clients'
      security [ bearerAuth: [] ]
      consumes 'application/json'
      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string }
        },
        required: %w[name email]
      }

      response '201', 'client created' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:client) { { name: 'Test Client', email: 'client@example.com' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:client) { { name: '' } }
        run_test!
      end
    end
  end

  path '/clients/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Retrieve a client' do
      tags 'Clients'
      security [ bearerAuth: [] ]
      produces 'application/json'

      response '200', 'client found' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:id) { create(:client).id }
        run_test!
      end

      response '404', 'client not found' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Update a client' do
      tags 'Clients'
      security [ bearerAuth: [] ]
      consumes 'application/json'
      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        }
      }

      response '200', 'client updated' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:id) { create(:client).id }
        let(:client) { { name: 'Updated Name' } }
        run_test!
      end
    end

    delete 'Delete a client' do
      tags 'Clients'
      security [ bearerAuth: [] ]

      response '204', 'client deleted' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:id) { create(:client).id }
        run_test!
      end
    end
  end
end
