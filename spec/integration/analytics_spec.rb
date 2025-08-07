require 'swagger_helper'

RSpec.describe 'Analytics API', type: :request do
  let!(:role) { Role.find_or_create_by!(name: "administrador") }
  let!(:user) do
    User.find_by(email: "test@example.com") ||
      User.create!(
        email: "test@example.com",
        password: "123456",
        role: role
      )
  end

  before do
    PaperTrail.request.whodunnit = user.id.to_s
  end
  let!(:category) { create(:category) }
  let!(:product1) { create(:product) }
  let!(:product2) { create(:product) }
  let!(:client) { create(:client) }
  let!(:purchase1) { create(:purchase, product: product1, client: client, created_at: 2.days.ago) }
  let!(:purchase2) { create(:purchase, product: product1, client: client, created_at: 1.day.ago) }
  let!(:purchase3) { create(:purchase, product: product2, client: client, created_at: 1.hour.ago) }
  let(:from) { 3.days.ago.iso8601 }
  let(:to) { Time.now.iso8601 }
  let(:category_id) { category.id }
  let(:client_id) { client.id }
  let(:admin_id) { user.id }

  path '/top_earning_products' do
    get 'Get most purchased products per category' do
      tags 'Analytics'
      security [ Bearer: [] ]
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'
      response '200', 'products returned' do
        let(:Authorization) { "Bearer #{generate_token(user)}" }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }
        run_test!
      end
    end
  end

  path '/top_revenue_products_by_category' do
    get 'Get top 3 products by revenue per category' do
      tags 'Analytics'
      security [ Bearer: [] ]
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'
      response '200', 'top products returned' do
        let(:Authorization) { "Bearer #{generate_token(user)}" }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }
        run_test!
      end
    end
  end

  path '/purchases' do
    get 'Get purchases filtered by parameters' do
      tags 'Analytics'
      security [ Bearer: [] ]
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'
      parameter name: :from, in: :query, type: :string, format: :date_time
      parameter name: :to, in: :query, type: :string, format: :date_time
      parameter name: :category_id, in: :query, type: :integer
      parameter name: :client_id, in: :query, type: :integer
      parameter name: :admin_id, in: :query, type: :integer

      response '200', 'purchases returned' do
        let(:Authorization) { "Bearer #{generate_token(user)}" }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }
        run_test!
      end
    end
  end

  path '/purchases_by_granularity' do
    get 'Get purchase count by granularity' do
      tags 'Analytics'
      security [ Bearer: [] ]
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'
      parameter name: :granularity, in: :query, type: :string, enum: %w[hour day week year], required: true
      parameter name: :from, in: :query, type: :string, format: :date_time
      parameter name: :to, in: :query, type: :string, format: :date_time
      parameter name: :category_id, in: :query, type: :integer
      parameter name: :client_id, in: :query, type: :integer
      parameter name: :admin_id, in: :query, type: :integer

      response '200', 'data returned' do
        let(:Authorization) { "Bearer #{generate_token(user)}" }
        let(:granularity) { 'day' }
        run_test!
      end

      response '400', 'invalid granularity' do
        let(:Authorization) { "Bearer #{generate_token(user)}" }
        let(:granularity) { 'minute' }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }
        let(:granularity) { 'day' }
        run_test!
      end
    end
  end
end
