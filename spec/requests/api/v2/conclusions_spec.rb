require 'swagger_helper'

RSpec.describe 'Api::V2::ConclusionsController', swagger_doc: 'v2/swagger.yaml', type: :request do
  path '/api/v2/conclusions' do
    get('List of all conclusions') do
      tags 'Conclusions'
      security [{ ApiKeyAuth: [] }]
      response(200, 'successful') do
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

    post('Create a conclusion') do
      tags 'Conclusions'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      parameter name: :conclusion_params, in: :body, schema: {
        type: :object,
        properties: {
          appointment_id: { type: :integer },
          content: { type: :string, default: 'The patient is doing well' }
        },
        required: %w[appointment_id content]
      }

      response(201, 'created') do
        let(:conclusion_params) { { appointment_id: appointment.id, content: 'The patient is doing well' } }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:conclusion_params) { { appointment_id: appointment.id, content: '' } }
        run_test!
      end
    end

    path '/api/v2/conclusions/{id}' do
      parameter name: 'id', in: :path, type: :integer

      get('Show a conclusion') do
        tags 'Conclusions'
        security [{ ApiKeyAuth: [] }]
        response(200, 'successful') do
          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
          let(:id) { conclusion.id }
          run_test!
        end

        response(404, 'not found') do
          let(:id) { -1 }
          run_test!
        end
      end

      put('Update a conclusion') do
        tags 'Conclusions'
        security [{ ApiKeyAuth: [] }]
        consumes 'application/json'
        parameter name: :conclusion_params, in: :body, schema: {
          type: :object,
          properties: {
            content: { type: :string, default: 'The patient is doing better' }
          },
          required: %w[content]
        }

        response(200, 'successful') do
          let(:id) { conclusion.id }
          let(:conclusion_params) { { content: 'The patient is doing better' } }
          run_test!
        end

        response(422, 'unprocessable entity') do
          let(:id) { conclusion.id }
          let(:conclusion_params) { { content: '' } }
          run_test!
        end

        response(404, 'not found') do
          let(:id) { -1 }
          let(:conclusion_params) { { content: 'The patient is doing better' }}
        end
      end
    end
  end
end

