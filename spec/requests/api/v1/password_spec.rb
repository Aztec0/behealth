# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/password', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/api/v1/forgot' do
    post 'Sends an email to reset the user\'s password' do
      tags 'Passwords'
      consumes 'application/json'
      parameter name: :email, in: :body, type: :string, description: 'The user\'s email address', schema: {
        type: :object,
        properties: {
          email: {
            type: :string
          },
          user_type: {
            type: :string
          }
        },
        required: %w[email user_type]
      }

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 email: { type: :string, description: 'The email address of the user' },
                 password_token: { type: :string, description: 'The password reset token generated for the user' }
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

    path '/api/v1/password-reset' do
    post 'Resets the user\'s password' do
      tags 'Passwords'
      consumes 'application/json'
      parameter name: :token, in: :query, type: :string,
                description: 'The password reset token generated for the user', required: true
      parameter name: :user_type, in: :query, type: :string, description: 'The user\'s type', required: true
      parameter name: :password, in: :body, type: :string, description: 'The new password for the user', schema: {
        type: :object,
        properties: {
          password: {
            type: :string
          }
        },
        required: %w[password]
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

      response '404', 'Not Found' do
        schema type: :object,
               properties: {
                 error: { type: :string, description: 'The error message' }
               }

        run_test!
      end
    end
  end
end
