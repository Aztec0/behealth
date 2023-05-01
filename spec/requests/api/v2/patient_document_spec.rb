require 'swagger_helper'

RSpec.describe 'api/v2/patient_document', swagger_doc: 'v2/swagger.yaml', type: :request do

  path '/api/v2/patient/document' do

    post('create patient_document') do
      response(200, 'successful') do
        tags 'Patient Document'

        security [{ ApiKeyAuth: [] }]

        consumes "application/json"
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            document_type: { type: :string, default: "Must be 'Passport' or 'IdCard'" },
            series: { type: :string, default: 'Dont use for IdCard' },
            number: { type: :string, default: '1111' },
            issued_by: { type: :string, default: '1111' },
            date: { type: :string, default: '12.04.2023' }
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

    put('update patient_document') do
      response(200, 'successful') do
        tags 'Patient Document'

        security [{ ApiKeyAuth: [] }]

        consumes "application/json"
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            document_type: { type: :string, default: "Must be 'Passport' or 'IdCard'" },
            series: { type: :string, default: 'Dont use for IdCard' },
            number: { type: :string, default: '1111' },
            issued_by: { type: :string, default: '1111' },
            date: { type: :string, default: '12.04.2023' }
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

    delete('delete patient_document') do
      response(200, 'successful') do
        tags 'Patient Document'

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
