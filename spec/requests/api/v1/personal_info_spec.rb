# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/personal_info', swagger_doc: 'v1/swagger.yaml', type: :request do

  path '/api/v1/patient-account/personal-information' do

    get('list personal_infos') do
      tags 'Personal Information'

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

  path '/api/v1/patient-account/personal-information' do
    post('create personal_info') do
      tags 'Personal Information'

      security [{ ApiKeyAuth: [] }]

      consumes "application/json"
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          document_type: { type: :string, default: "Must be 'Passport' or 'IdCard'" },
          series: { type: :string, default: 'Dont use for IdCard' },
          number: { type: :string, default: '123456789' },
          issued_by: { type: :string, default: '1111' },
          date: { type: :string, default: '12.04.2023' }
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

  path '/api/v1/patient-account/personal-information' do
    put('update personal_info') do
      tags 'Personal Information'

      security [{ ApiKeyAuth: [] }]

      consumes "application/json"
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          type: { type: :string, default: "Must be 'patient_info' or 'document'" },
          name: { type: :string, default: 'Юзер' },
          surname: { type: :string, default: 'Юзеренко' },
          second_name: { type: :string, default: 'Юзеренкович' },
          email: { type: :string, default: 'user@test.rb' },
          phone: { type: :string, default: '+380000000000' },
          birthday: { type: :string, default: '05.11.2003' },
          tin: { type: :string, default: '1111111111' },
          sex: { type: :string, default: "'nothing', 'male' or 'female'" },
          series: { type: :string, default: 'Use for Passport' },
          number: { type: :string, default: '1111' },
          issued_by: { type: :string, default: '1111' },
          date: { type: :string, default: '12.04.2023' }
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

  path '/api/v1/patient-account/personal-information' do
    delete('delete personal_info') do
      tags 'Personal Information'

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
end
