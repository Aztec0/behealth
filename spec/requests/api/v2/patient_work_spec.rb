require 'swagger_helper'

RSpec.describe 'api/v2/patient_work', swagger_doc: 'v2/swagger.yaml', type: :request do

  path '/api/v2/patient/work' do

    post('create patient_work') do
      response(200, 'successful') do
        tags 'Patient Work'

        security [{ ApiKeyAuth: [] }]

        consumes "application/json"
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            work_type: { type: :string, default: 'Основна' },
            place: { type: :string, default: 'GeekHub' },
            position: { type: :string, default: 'Студент' }
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

    put('update patient_work') do
      response(200, 'successful') do
        tags 'Patient Work'

        security [{ ApiKeyAuth: [] }]

        consumes "application/json"
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            work_type: { type: :string, default: 'Основна' },
            place: { type: :string, default: 'GeekHub' },
            position: { type: :string, default: 'Студент' }
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

    delete('delete patient_work') do
      response(200, 'successful') do
        tags 'Patient Work'

        security [{ ApiKeyAuth: [] }]

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
