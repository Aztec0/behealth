require 'swagger_helper'

RSpec.describe 'api/v2/personal_info', swagger_doc: 'v2/swagger.yaml', type: :request do

  path '/api/v2/patient/main-info' do

    get('list personal_infos') do
      response(200, 'successful') do
        tags 'Personal Information'

        security [{ ApiKeyAuth: [] }]

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

    put('update personal_info') do
      response(200, 'successful') do
        tags 'Personal Information'

        security [{ ApiKeyAuth: [] }]

        consumes "application/json"
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            first_name: { type: :string, default: 'Юзер' },
            last_name: { type: :string, default: 'Юзеренко' },
            second_name: { type: :string, default: 'Юзеренкович' },
            email: { type: :string, default: 'user@test.rb' },
            phone: { type: :string, default: '+380000000000' },
            birthday: { type: :string, default: '05.11.2003' },
            tin: { type: :string, default: '1111111111' },
            sex: { type: :string, default: "'nothing', 'male' or 'female'" }
          }
        }

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
