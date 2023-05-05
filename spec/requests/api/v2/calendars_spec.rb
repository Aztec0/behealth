require 'swagger_helper'

RSpec.describe 'api/v2/calendar', swagger_doc: 'v2/swagger.yaml', type: :request do

  path '/api/v2/calendar' do
    get('List appointments') do
      tags 'Appointments'
      security [{ ApiKeyAuth: [] }]
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

    post('Create an appointment') do
      tags 'Appointments'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      parameter name: :appointment, in: :body, schema: {
        type: :object,
        properties: {
          appointment_datetime: { type: :string, format: 'date-time' },
          doctor_id: { type: :integer },
          patient_id: { type: :integer }
        },
        required: %w[appointment_datetime doctor_id patient_id]
      }

      response '201', 'returns the newly created appointment' do
        schema type: :object,
               properties: {
                 message: { type: :string },
                 id: { type: :integer }
               },
               required: %w[message id]

        let(:appointment) do
          {
            appointment_datetime: '2023-05-10T10:00:00Z',
            doctor_id: 1,
            patient_id: 2
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:appointment) { {} }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:appointment) do
          {
            appointment_datetime: '2023-05-10T10:00:00Z',
            doctor_id: 1,
            patient_id: 2
          }
        end

        let(:Authorization) { '' }

        run_test!
      end
    end
  end

  path '/api/v2/calendar/{id}' do
    parameter name: :id, in: :path, type: :integer

    get('Show an appointment') do
      tags 'Appointments'

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

      response(404, 'not found') do
        let(:id) { -1 }
        run_test!
      end
    end

    put('Update an appointment') do
      tags 'Appointments'
      parameter name: :id, in: :path, type: :integer, required: true

      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      parameter name: :appointment_params, in: :body, schema: {
        type: :object,
        properties: {
          appointment_datetime: { type: :string, format: 'date-time' },
          doctor_id: { type: :integer },
          patient_id: { type: :integer }
        }
      }

      response '200', 'appointment updated' do
        let(:id) { create(:appointment, user: user).id }
        let(:appointment_params) { { appointment: { appointment_datetime: Time.now + 1.hour } } }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:id) { create(:appointment, user: user).id }
        let(:appointment_params) { { appointment: { appointment_datetime: Time.now + 1.hour } } }
        let(:Authorization) { '' }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { create(:appointment, user: user).id }
        let(:appointment_params) { { appointment: { appointment_datetime: nil } } }
        run_test!
      end

      response '404', 'not found' do
        let(:id) { -1 }
        let(:appointment_params) { { appointment: { appointment_datetime: Time.now + 1.hour } } }
        run_test!
      end
    end
  end
end


