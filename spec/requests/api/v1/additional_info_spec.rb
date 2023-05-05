# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/additional_info', swagger_doc: 'v1/swagger.yaml', type: :request do

  path '/api/v1/patient-account/additional-data' do
    get('list additional_infos') do
      tags 'Additional Information'

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
  end

  path '/api/v1/patient-account/additional-data' do
    post('create additional_info') do
      tags 'Additional Information'

      security [{ ApiKeyAuth: [] }]

      consumes "application/json"
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          type: { type: :string, default: "Must be 'address' or 'work'" },
          address_type: { type: :string, default: 'Основна' },
          settlement: { type: :string, default: 'Черкаси' },
          house: { type: :string, default: '1' },
          apartments: { type: :string, default: '1' },
          work_type: { type: :string, default: 'Основна' },
          place: { type: :string, default: 'GeekHub' },
          position: { type: :string, default: 'Студент' }
        }
      }

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
  end

  path '/api/v1/patient-account/additional-data' do
    put('update additional_info') do
      tags 'Additional Information'

      security [{ ApiKeyAuth: [] }]

      consumes "application/json"
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          type: { type: :string, default: "Must be 'address' or 'work'" },
          address_type: { type: :string, default: 'Основна' },
          settlement: { type: :string, default: 'Черкаси' },
          house: { type: :string, default: '1' },
          apartments: { type: :string, default: '1' },
          work_type: { type: :string, default: 'Основна' },
          place: { type: :string, default: 'GeekHub' },
          position: { type: :string, default: 'Студент' }
        }
      }

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
  end

  path '/api/v1/patient-account/additional-data' do
    delete('delete additional_info') do
      tags 'Additional Information'

      security [{ ApiKeyAuth: [] }]

      consumes "application/json"
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          type: { type: :string, default: "Must be 'address' or 'work'" }
        }
      }

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
  end
end
