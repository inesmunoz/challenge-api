require 'swagger_helper'

RSpec.describe 'Products API', type: :request do
  let!(:role) { Role.find_or_create_by!(name: "administrador") }
  let!(:user) do
    User.find_by(email: "test@example.com") ||
      User.create!(
        email: "test@example.com",
        password: "123456",
        role: role
      )
  end  
  path '/products' do
    get 'Lista todos los productos' do
      tags 'Products'
      security [ bearerAuth: [] ]
      produces 'application/json'

      response '200', 'listado exitoso' do
        let(:Authorization) { "Bearer #{generate_token(user)}" }
        before { create(:product) }
        run_test!
      end
    end

    post 'Crea un producto' do
      tags 'Products'
      security [ bearerAuth: [] ]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number },
          category_ids: {
            type: :array,
            items: { type: :integer }
          }
        },
        required: %w['name', 'price']
      }

      response '201', 'producto creado' do
        let(:Authorization) { "Bearer #{generate_token(user)}" }
        let(:category) { create(:category) }
        let(:product) do
          {
            name: 'New Product',
            price: 99.99,
            category_ids: [category.id]
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { "Bearer #{generate_token(user)}" }

        let(:product) do
          {
            name: nil
          }
        end

        run_test!
      end
    end
  end

  path '/products/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Muestra un producto' do
      tags 'Products'
      security [ bearerAuth: [] ]
      produces 'application/json'

      response '200', 'producto encontrado' do
        let(:Authorization) { "Bearer #{generate_token(user)}" }
        let(:id) { create(:product).id }
        run_test!
      end

      response '404', 'producto no encontrado' do
        let(:Authorization) { "Bearer #{generate_token(user)}" }
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
