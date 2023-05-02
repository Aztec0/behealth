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
end
