require 'rails_helper'

RSpec.describe "api/registrations", type: :request do
  path '/api/v1/signup' do
    post 'Sends an email to register user'
    tags 'Signup'
    consumes 'application/json'
    parameter name: :patient, in: :body, type: :string, description: 'The user\'s email and password', schema: {
      type: :object,
      properties: {
        email: {
          type: :string
        },
        password: {
          type: :string
        }
      },
      required: %w[ email password ]
    }

    response '200', 'OK' do
      schema type: :object,
             properties: {
               status: { type: :string, description: 'The status message' }
             }

      run_test!
    end

      response '400', 'Bad Request' do
        schema type: :object,
               properties: {
                 error: { type: :string, description: 'The error message' }
               }

        run_test!
      end
  end

    path 'api/v1/confirmation' do

    post 'Confirmation user\'s email and input other data'
    tags 'Signupqq'
    consumes 'application/json'
    parameter name: :token, in: :query, type: :string, description: 'The confirm reset token generated for the patient', required: true
    parameter name: :patient_data, in: :body, type: :string, description: 'Patient data', schema: {
      type: :object,
      properties: {
        birthday: {
          type: :string
        },
        name: {
          type: :string
        },
        surname: {
          type: :string
        },
        phone: {
          type: :string
        }
      },
      required: %w[ birthday name surname phone ]
    }
    response '400', 'Bad Request' do
      schema type: :object,
             properties: {
               error: { type: :string, description: 'The error message' }
             }

      run_test!
    end

    response '400', 'Bad Request' do
      schema type: :object,
             properties: {
               error: { type: :string, description: 'The error message' }
             }

      run_test!
    end
  end
end
