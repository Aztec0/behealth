# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/registrations', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/api/v1/signup' do
    post 'Sends an email to register user' do
      tags 'Signup'
      consumes 'application/json'
      parameter name: :patient, in: :body, type: :string, description: 'The user\'s email and password', schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'OK' do
        run_test!
      end

      response '400', 'Bad Request' do
        run_test!
      end
    end
  end

  path '/api/v1/confirmation' do
    post 'Confirmation user\'s email and input other data' do
      tags 'Signup'
      consumes 'application/json'
      parameter name: :token, in: :query, type: :string, 
                description: 'The confirm reset token generated for the patient', required: true
      parameter name: :patient_data, in: :body, type: :string, description: 'Patient data', schema: {
        type: :object,
        properties: {
          birthday: {
            type: :string, format: :datetime
          },
          name: {
            type: :string
          },
          surname: {
            type: :string
          },
          last_name: {
            type: :string
          },
          phone: {
            type: :string, format: :bigint
          }
        },
        required: %w[birthday first_name second_name last_name phone]
      }

      response '400', 'Bad Request' do
        run_test!
      end
    end
  end
end
