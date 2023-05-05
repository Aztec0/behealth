require 'swagger_helper'

RSpec.describe 'Appointments API', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/api/v1/appointments' do
    get('List all appointments') do
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
      parameter name: :appointment_params, in: :body, schema: {
        type: :object,
        properties: {
          doctor_id: { type: :integer },
          patient_id: { type: :integer },
          appointment_datetime: { type: :datetime },
          status: { type: integer }
        },
        required: %w[doctor_id patient_id appointment_datetime status]
      }

      response '201', 'creates a new appointment' do
        let(:appointment_params) do
          {
            doctor_id: doctor.id,
            patient_id: patient.id,
            appointment_datetime: '2023-05-10 15:00:00',
            status: 'unconfirmed'
          }
        end
        run_test!
      end

      response '422', 'when invalid params are provided' do
        let(:appointment_params) { { doctor_id: doctor.id } }
        run_test!
      end
    end
  end

  path '/api/v1/appointments/{id}' do
    parameter name: :id, in: :path, type: :integer

    get('Get an appointment') do
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
        let(:id) { appointment.id }
        run_test!
      end

      response '404', 'when appointment does not exist' do
        let(:id) { -1 }
        run_test!
      end
    end

    patch('Update an appointment') do
      tags 'Appointments'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      parameter name: :appointment_params, in: :body, schema: {
        type: :object,
        properties: {
          status: { type: :integer }
        }
      }

      response '200', 'updates an existing appointment' do
        let(:id) { appointment.id }
        let(:appointment_params) { { status: 'confirmed' } }
        run_test!
      end

      response '404', 'when appointment does not exist' do
        let(:id) { -1 }
        let(:appointment_params) { { status: 'confirmed' } }
        run_test!
      end
    end

    path '/api/v1/appointments/{id}/accept' do
      parameter name: :id, in: :path, type: :integer

      patch('Accept an appointment') do
        tags 'Appointments'
        security [{ ApiKeyAuth: [] }]
        consumes 'application/json'
        parameter name: :appointment_params, in: :body, schema: {
          type: :object,
          properties: {
            status: { type: :integer }
          }
        }

        response '200', 'accepts an appointment' do
          let(:id) { appointment.id }
          let(:appointment_params) { { status: 'accepted' } }
          run_test!
        end

        response '404', 'when appointment does not exist' do
          let(:id) { -1 }
          let(:appointment_params) { { status: 'accepted' } }
          run_test!
        end
      end
    end

    path '/api/v1/appointments/past' do
      get('List past appointments') do
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
    end

    path '/api/v1/appointments/upcoming' do
      get('List upcoming appointments') do
        tags 'Appointments'
        security [{ ApiKeyAuth: [] }]
        parameter name: :doctor_id, in: :query, type: :integer, required: true
        parameter name: :appointment_datetime, in: :query, type: :string, required: true

        response(200, 'successful') do
          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end

          let(:doctor_id) { doctor.id }
          let(:appointment_datetime) { Date.today.to_s }

          run_test!
        end

        response '400', 'when doctor_id is not provided' do
          let(:doctor_id) { nil }
          let(:appointment_datetime) { Date.today.to_s }

          run_test!
        end

        response '400', 'when start_date is not provided' do
          let(:doctor_id) { doctor.id }
          let(:appointment_datetime) { nil }

          run_test!
        end

      end
    end
  end
  end