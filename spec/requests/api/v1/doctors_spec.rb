# frozen_string_literal: true

require 'swagger_helper'
RSpec.describe 'api/v1/doctors', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/api/v1/doctors' do
    get('List all doctors') do
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

  path '/api/v1/create_doctor' do
    post 'Creates a doctor' do
      tags 'Doctors'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      parameter name: :doctor_params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, default: 'John' },
          surname: { type: :string, default: 'Doe' },
          second_name: { type: :string, default: 'Doe' },
          email: { type: :string, default: 'john.doe@example.com' },
          phone: { type: :integer, default: '1234567890' },
          birthday: { type: :string, default: '1990-01-01' },
          position: { type: :string, default: 'Cardiologist' }
        },
        required: %w[name surname second_name email phone birthday position]
      }

      response '201', 'returns the newly created doctor' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 surname: { type: :string },
                 email: { type: :string },
                 phone: { type: :integer },
                 birthday: { type: :string },
                 position: { type: :string },
                 hospital_id: { type: :integer }
               },
               required: %w[id name surname email phone birthday position hospital_id]

        let(:doctor_params) do
          {
            name: 'John',
            surname: 'Doe',
            email: 'john.doe@example.com',
            phone: '1234567890',
            birthday: '1990-01-01',
            position: 'Cardiologist',
            hospital_id: hospital.id,
            password: 'password123',
            password_confirmation: 'password123'
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:doctor_params) { {} }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:doctor_params) do
          {
            name: 'John',
            surname: 'Doe',
            email: 'john.doe@example.com',
            phone: '1234567890',
            birthday: '1990-01-01',
            position: 'Cardiologist',
            hospital_id: hospital.id,
            password: 'password123',
            password_confirmation: 'password123'
          }
        end

        let(:Authorization) { '' }

        run_test!
      end
    end
  end

  path '/api/v1/doctors/{id}' do
    delete 'Deletes a doctor by id' do
      tags 'Doctors'
      security [{ ApiKeyAuth: [] }]
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Doctor ID'

      response '204', 'doctor deleted' do
        run_test!
      end

      response '404', 'doctor not found' do
        run_test!
      end
    end
  end
  path '/api/v1/list_doctor_by_hospital' do
    get 'Retrieves a list of doctors associated with the hospital' do
      tags 'Doctors'
      security [{ ApiKeyAuth: [] }]
      produces 'application/json'
      response '200', 'returns a list of doctors' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   surname: { type: :string },
                   email: { type: :string },
                   phone: { type: :integer },
                   birthday: { type: :string },
                   position: { type: :string },
                   rating: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   hospital_id: { type: :integer }
                 },
                 required: %w[id name surname email phone birthday position rating created_at updated_at hospital_id]
               }

        run_test!
      end

      response '401', 'Unauthorized' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        run_test!
      end
    end
  end
  path '/api/v1/staff_appointments' do
    get 'Retrieves a list of doctors appointments' do
      tags 'Doctors'
      security [{ ApiKeyAuth: [] }]
      produces 'application/json'
      response '200', 'returns a list of doctors' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   appointment_datetime: { type: :string },
                   status: { type: :string },
                   doctor_full_name: { type: :string },
                   hospital_name: { type: :string },
                   patient_full_name: { type: :string }
                 },
                 required: %w[id appointment_datetime status doctor_full_name hospital_name patient_full_name]
               }

        run_test!
      end

      response '401', 'Unauthorized' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        run_test!
      end
    end
  end
end
