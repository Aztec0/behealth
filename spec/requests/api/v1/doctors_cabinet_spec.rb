require 'swagger_helper'

RSpec.describe "api/doctors_cabinet", type: :request do
  path '/api/v1/edit_doctor' do
    patch 'Update doctors params' do
      tags 'Doctors cabinet'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :doctor_params, in: :body, type: :string, description: 'Doctors params to update', schema: {
        type: :object,
        properties: {
          second_email: { type: :string },
          second_phone: { type: :integer },
          description: { type: :string },
          price: { type: :integer }
        },
        required: %w[second_email second_phone description price]
      }

    response '200', 'OK' do
      run_test!
    end

    response '400', 'Bad Request' do
      run_test!
    end
    end
  end

  path '/api/v1/personal_info' do
    get 'Returns personal information about the doctor' do
      tags 'Doctors cabinet'
      security [{ ApiKeyAuth: [] }]
      produces 'application/json'
      response '200', 'returns personal information' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   full_name: { type: :string },
                   email: { type: :string },
                   second_email: { type: :string },
                   phone: { type: :integer },
                   second_phone: { type: :integer },
                   description: { type: :string }
                 },
                 required: %w[ full_name email second_email second_phone description ]
               }

        run_test!
      end

      response '422', 'Unprocessable_entity' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        run_test!
      end
    end
  end

  path '/api/v1/professional_info' do
    get 'Returns professional information about the doctor' do
      tags 'Doctors cabinet'
      security [{ ApiKeyAuth: [] }]
      produces 'application/json'
      response '200', 'returns professional information' do
        schema type: :array,
               items: {
                  type: :object,
                  properties: {
                    price: { type: :integer },
                    position: { type: :string },
                    hospital_city: { type: :string },
                    hospital_region: { type: :string },
                    hospital_address: { type: :string },
                    hospital_name: { type: :string }
                },
                  required: %w[ price position hospital_city hospital_region hospital_address hospital_name ]
               }
        run_test!
      end
    end
  end
end
