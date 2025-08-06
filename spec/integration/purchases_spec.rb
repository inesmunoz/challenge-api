require 'swagger_helper'

RSpec.describe 'Purchases API', type: :request do
  let!(:role) { Role.find_or_create_by!(name: "administrador") }
  let!(:user) do
    User.find_by(email: "test@example.com") ||
      User.create!(
        email: "test@example.com",
        password: "123456",
        role: role
      )
  end  
  path '/purchases' do
    get 'List all purchases' do
      tags 'Purchases'
      security [ bearerAuth: [] ]
      produces 'application/json'

      response '200', 'purchases listed' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        before { create(:purchase) }

        run_test!
      end
    end

    post 'Create a purchase' do
      tags 'Purchases'
      security [ bearerAuth: [] ]
      consumes 'application/json'
      parameter name: :purchase, in: :body, schema: {
        type: :object,
        properties: {
          client_id: { type: :integer },
          product_id: { type: :integer },
          quantity: { type: :integer }
        },
        required: %w[client_id product_id quantity]
      }

      response '201', 'purchase created' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:client) { create(:client) }
        let(:product) { create(:product) }
        let(:purchase) { { client_id: client.id, product_id: product.id, quantity: 2 } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:purchase) { { quantity: nil } }

        run_test!
      end
    end
  end

  path '/purchases/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Get a purchase' do
      tags 'Purchases'
      security [ bearerAuth: [] ]
      produces 'application/json'

      response '200', 'purchase found' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:id) { create(:purchase).id }

        run_test!
      end

      response '404', 'purchase not found' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:id) { 'invalid' }

        run_test!
      end
    end

    put 'Update a purchase' do
      tags 'Purchases'
      security [ bearerAuth: [] ]
      consumes 'application/json'
      parameter name: :purchase, in: :body, schema: {
        type: :object,
        properties: {
          quantity: { type: :integer }
        }
      }

      response '200', 'purchase updated' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:id) { create(:purchase).id }
        let(:purchase) { { quantity: 10 } }

        run_test!
      end
    end

    delete 'Delete a purchase' do
      tags 'Purchases'
      security [ bearerAuth: [] ]
      response '204', 'purchase deleted' do
        let(:Authorization) { "Bearer #{generate_token(create(:user))}" }
        let(:id) { create(:purchase).id }

        run_test!
      end
    end
  end
end
