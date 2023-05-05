require 'swagger_helper'

RSpec.describe Api::V2::AppointmentsController, type: :request, swagger_doc: 'v2/swagger.yaml' do
  let(:appointment_params) do
    {
      appointment_datetime: Time.zone.now + 1.hour,
      status: 'planned',
      doctor_id: doctor.id,
      patient_id: user.id
    }
  end

  path '/api/v2/appointments' do
    get('List all appointments') do
      tags 'Appointments'
      parameter name: :upcoming, in: :query, type: :boolean, description: 'List only upcoming appointments'
      parameter name: :past, in: :query, type: :boolean, description: 'List only past appointments'
      produces 'application/json'

      response '200', 'successful' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   appointment_datetime: { type: :string },
                   status: { type: :string, enum: %w[cancelled completed planned unconfirmed] },
                   doctor_id: { type: :integer },
                   patient_id: { type: :integer }
                 },
                 required: %w[id appointment_datetime status doctor_id patient_id]
               }

        let(:upcoming) { true }

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response).to match_response_schema('appointments')
        end
      end

      response '401', 'unauthorized' do
        let(:Authorization) { '' }
        run_test!
      end
    end

    post('Create an appointment') do
      tags 'Appointments'
      consumes 'application/json'
      parameter name: :appointment_params, in: :body, schema: {
        type: :object,
        properties: {
          appointment_datetime: { type: :string, format: 'date-time' },
          status: { type: :integer, enum: [0, 1, 2, 3], default: 3 },
          doctor_id: { type: :integer },
          patient_id: { type: :integer }
        },
        required: %w[appointment_datetime doctor_id patient_id]
      }

      response '201', 'appointment created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 appointment_datetime: { type: :string },
                 status: { type: :integer },
                 doctor_id: { type: :integer },
                 patient_id: { type: :integer }
               },
               required: %w[id appointment_datetime status doctor_id patient_id]

        let(:appointment_params) { appointment_params }

        run_test! do |response|
          expect(response).to have_http_status(:created)
          expect(response).to match_response_schema('appointment')
        end
      end

      response '422', 'invalid request' do
        let(:appointment_params) { { appointment_datetime: nil, status: 4, doctor_id: doctor.id, patient_id: user.id } }

        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to include("Appointment datetime can't be blank", 'Status is not included in the list')
        end
      end

      response '401', 'unauthorized' do
        let(:Authorization) { '' }
        let(:appointment_params) { appointment_params }

        run_test!
      end
    end

    path '/api/v2/appointments/{id}' do
      parameter name: :id, in: :path, type: :integer, required: true, description: 'Appointment ID'
      get('Get an appointment') do
        tags 'Appointments'
        produces 'application/json'
        response '200', 'successful' do
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   appointment_datetime: { type: :string },
                   status: { type: :string },
                   doctor_id: { type: :integer },
                   patient_id: { type: :integer }
                 },
                 required: %w[id appointment_datetime status doctor_id patient_id]

          let(:id) { appointment.id }

          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response).to match_response_schema('appointment')
          end
        end

        response '401', 'unauthorized' do
          let(:Authorization) { '' }
          let(:id) { appointment.id }

          run_test!
        end

        response '404', 'not found' do
          let(:id) { -1 }

          run_test! do |response|
            expect(response).to have_http_status(:not_found)
          end
        end
      end
    end

    put('Update an appointment') do
      tags 'Appointments'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :appointment_params, in: :body, schema: {
        type: :object,
        properties: {
          appointment_datetime: { type: :string, format: 'date-time' },
          status: { type: :string, enum: %w[scheduled planned cancelled completed] },
          doctor_id: { type: :integer },
          patient_id: { type: :integer }
        }
      }

      response '200', 'appointment updated' do
        let(:id) { appointment.id }
        let(:appointment_params) { { status: 'completed' } }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 appointment_datetime: { type: :string },
                 status: { type: :string },
                 doctor_id: { type: :integer },
                 patient_id: { type: :integer }
               },
               required: %w[id appointment_datetime status doctor_id patient_id]

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response).to match_response_schema('appointment')
          expect(appointment.reload.status).to eq('completed')
        end
      end

      response '422', 'invalid request' do
        let(:id) { appointment.id }
        let(:appointment_params) { { appointment_datetime: nil, status: 'invalid' } }

        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to include("Appointment datetime can't be blank", 'Status is not included in the list')
        end
      end

      response '401', 'unauthorized' do
        let(:Authorization) { '' }
        let(:id) { appointment.id }
        let(:appointment_params) { { status: 'completed' } }

        run_test!
      end
    end

    path '/api/v2/appointments/{id}/accept' do
      put('Accept appointment') do
        tags 'Appointments'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, description: 'Appointment ID'
        response '204', 'appointment accepted' do
          let(:id) { appointment.id }

          run_test! do |response|
            expect(response).to have_http_status(:no_content)
          end
        end

        response '401', 'unauthorized' do
          let(:Authorization) { '' }
          let(:id) { appointment.id }

          run_test!
        end

        response '404', 'appointment not found' do
          let(:id) { 'invalid' }

          run_test! do |response|
            expect(response).to have_http_status(:not_found)
            expect(response.body).to include("Couldn't find Appointment with 'id'=invalid")
          end
        end
      end
    end

    put('/api/v2/appointments/{id}/cancel') do
      tags 'Appointments'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      security [Bearer: []]
      produces 'application/json'
      response '200', 'appointment cancelled' do
        let(:Authorization) { "Bearer #{user.authentication_token}" }
        let(:id) { appointment.id }

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response).to match_response_schema('appointment')
          expect(appointment.reload.status).to eq('cancelled')
        end
      end

      response '401', 'unauthorized' do
        let(:id) { appointment.id }
        let(:Authorization) { '' }
        run_test!
      end

      response '404', 'not found' do
        let(:id) { 'invalid' }
        let(:Authorization) { "Bearer #{user.authentication_token}" }

        run_test!
      end
    end
  end
end
