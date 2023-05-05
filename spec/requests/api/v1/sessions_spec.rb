# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/sessions', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/api/v1/login' do
    post('create session') do
      tags 'Login'
      consumes 'application/json'
      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          email: {
            type: :string
          },
          password: {
            type: :string
          },
          user_type: {
            type: :string
          }
        },
        required: %w[email password user_type]
      }
      response(200, 'successful') do
        run_test!
      end
    end
  end
end
