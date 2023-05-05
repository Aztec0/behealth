require 'swagger_helper'

RSpec.describe 'api/v2/patient_address', swagger_doc: 'v2/swagger.yaml', type: :request do

  path '/api/v2/patient/address' do

    post('create patient_address') do
      response(200, 'successful') do
        tags 'Patient Address'

        security [{ ApiKeyAuth: [] }]

        consumes "application/json"
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            address_type: { type: :string, default: 'Основна' },
            settlement: { type: :string, default: 'Черкаси' },
            house: { type: :string, default: '1' },
            apartments: { type: :string, default: '1' }
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

    put('update patient_address') do
      response(200, 'successful') do
        tags 'Patient Address'

        security [{ ApiKeyAuth: [] }]

        consumes "application/json"
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            address_type: { type: :string, default: 'Основна' },
            settlement: { type: :string, default: 'Черкаси' },
            house: { type: :string, default: '1' },
            apartments: { type: :string, default: '1' }
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

    delete('delete patient_address') do
      response(200, 'successful') do
        tags 'Patient Address'

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
