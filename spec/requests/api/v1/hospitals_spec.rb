# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/index', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/api/v1/index' do
    get('List all hospitals') do
      tags 'Doctors and Hospitals'
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

  path '/api/v1/hospital/update/:id' do
    patch 'Update hospital params' do
      tags 'Doctors'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :tag_list, in: :query, type: :string, description: 'List of tags for hospital'
      parameter name: :doctor_params, in: :body, type: :string, description: 'Hospital`s params to update', schema: {
        type: :object,
        properties: {
          address: { type: :string, default: 'Some addres' },
          city: { type: :string, default: 'Some city' },
          name: { type: :string, default: 'Some name' },
          region: { type: :string, default: 'Some region' }
        },
        required: %w[second_email second_phone description price]
      }

      response '200', 'OK' do
        run_test!
      end

      response '422', 'Unprocessable entity' do
        run_test!
      end
    end
  end
end
