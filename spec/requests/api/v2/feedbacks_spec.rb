require 'swagger_helper'

RSpec.describe 'api/v2/feedbacks', swagger_doc: 'v2/swagger.yaml', type: :request do

  path '/api/v2/feedbacks/{type}/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'type', in: :path, type: :string, description: 'type'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('list feedbacks') do
      tags 'Feedbacks'

      response(200, 'successful') do
        let(:type) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create feedback') do
      tags 'Feedbacks'

      security [{ ApiKeyAuth: [] }]

      response(200, 'successful') do
        let(:type) { '123' }
        let(:id) { '123' }

        consumes "application/json"
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string, default: 'Test' },
            body: { type: :string, default: "It's just a test feedback" },
            rating: { type: :integer, default: 5 }
          }
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v2/feedbacks/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    put('update feedback') do
      tags 'Feedbacks'

      security [{ ApiKeyAuth: [] }]

      response(200, 'successful') do
        let(:id) { '123' }

        consumes "application/json"
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string, default: 'Test' },
            body: { type: :string, default: "It's just a test feedback" },
            rating: { type: :integer, default: 5 }
          }
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete feedback') do
      tags 'Feedbacks'

      security [{ ApiKeyAuth: [] }]

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
