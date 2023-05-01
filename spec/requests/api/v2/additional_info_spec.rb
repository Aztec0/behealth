require 'swagger_helper'

RSpec.describe 'api/v2/additional_info', type: :request do

  path '/api/v2/patient/extra-info' do
    get('list additional_infos') do
      tags 'Additional Information'

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
