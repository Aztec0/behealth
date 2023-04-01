require 'swagger_helper'

RSpec.describe 'api/hospitals', type: :request do
  path '/api/v1/index' do
    get('hospital index') do
      tags 'Admin', 'Articles'
      consumes 'application/json'
      produces 'application/json'
      security [ApiKeyAuth: []]
      parameter name: :search, in: :query, type: :string

      response(200, 'successful') do
        run_test!
      end
    end
  end

end
