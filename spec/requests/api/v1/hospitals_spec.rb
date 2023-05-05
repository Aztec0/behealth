# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/index', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/api/v1/hospitals' do
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

  path '/api/v1/create_hospital' do
    post 'Creates a hospital' do
      tags 'Doctors'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      parameter name: :hospital, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, default: 'New Hospital' },
          address: { type: :string, default: '123 Main St' },
          city: { type: :string, default: 'Anytown' },
          region: { type: :string, default: 'NY' }
        },
        required: %w[name address city region]
      }

      response '201', 'returns the newly created hospital' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 address: { type: :string },
                 city: { type: :string },
                 region: { type: :string }
               },
               required: %w[id name address city region]

        let(:hospital) { { name: 'New Hospital', address: '123 Main St', city: 'Anytown', region: 'NY' } }
        run_test!
      end

      response '422', 'returns an error message if hospital cannot be created' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        let(:hospital) { { name: '', address: '', city: '', region: '' } }
        run_test!
      end
    end
  end
end
