# frozen_string_literal: true

require 'swagger_helper'
RSpec.describe 'admin_dashboard', swagger_doc: 'admin/v1/swagger.yaml', type: :request do
  # Doctor section
  path '/api/v1/doctors' do
    get 'Get all doctors' do
      tags 'Doctors section'
      security [{ ApiKeyAuth: [] }]
      produces 'application/json'
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

    path '/api/v1/doctors/{id}' do
      get('Doctor by ID') do
        tags 'Doctors section'
        security [{ ApiKeyAuth: [] }]
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, description: 'Hospital ID'
        response(200, 'successful') do
          run_test!
        end
        response '401', 'unauthorized' do
          run_test!
        end
        response '404', 'Hospital not found' do
          run_test!
        end
      end
    end

    path '/api/v1/doctors/create' do
      post 'Create a doctor' do
        tags 'Doctors section'
        security [{ ApiKeyAuth: [] }]
        consumes 'application/json'
        parameter name: :doctor_params, in: :body, schema: {
          type: :object,
          properties: {
            first_name: { type: :string, default: 'John' },
            last_name: { type: :string, default: 'Doe' },
            second_name: { type: :string, default: 'Doe' },
            email: { type: :string, default: 'john.doe@example.com' },
            phone: { type: :integer, default: '1234567890' },
            birthday: { type: :string, default: '1990-01-01' },
            position: { type: :string, default: 'Cardiologist' },
            hospital_id: { type: :integer, default: '1' },
            role: { type: :string, default: 'head_doctor' }
          },
          required: %w[first_name last_name second_name email phone birthday position hospital_id role]
        }

        response '201', 'returns the newly created doctor' do
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   first_name: { type: :string },
                   last_name: { type: :string },
                   second_name: { type: :string },
                   email: { type: :string },
                   phone: { type: :integer },
                   birthday: { type: :string },
                   position: { type: :string },
                   hospital_id: { type: :integer },
                   role: { type: :string }
                 },
                 required: %w[id first_name second_name last_name email phone birthday position hospital_id role]

          run_test!
        end

        response '401', 'unauthorized' do
          run_test!
        end

        response '422', 'Invalid request' do
          run_test!
        end
      end
    end
  end

  path '/api/v1/delete_doctor/{id}' do
    parameter name: :id, in: :path, type: :integer, description: 'Doctor ID'

    delete 'Delete a doctor' do
      tags 'Doctors section'
      security [{ ApiKeyAuth: [] }]

      response '204', 'Doctor deleted' do
        run_test!
      end

      response '404', 'Doctor not found' do
        run_test!
      end
    end
  end

  path '/api/v1/doctor/{id}/update' do
    patch 'Update doctors params' do
      tags 'Doctors section'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the doctor to update'
      parameter name: :doctor_params, in: :body, type: :string, description: 'Doctors params to update', schema: {
        type: :object,
        properties: {
          first_name: { type: :string, default: 'John' },
          last_name: { type: :string, default: 'Doe' },
          second_name: { type: :string, default: 'Doe' },
          email: { type: :string, default: 'john.doe@example.com' },
          phone: { type: :integer, default: '1234567890' },
          birthday: { type: :string, default: '1990-01-01' },
          position: { type: :string, default: 'Cardiologist' },
          hospital_id: { type: :integer, default: '1' },
          role: { type: :string, default: 'head_doctor' },
          second_email: { type: :string, default: '@gmail.com' },
          second_phone: { type: :integer, default: '123456789' },
          description: { type: :string, default: 'Something about yourself' },
          admission_price: { type: :integer, default: '100' }
        },
        required: %w[first_name last_name second_name email phone birthday position hospital_id role]
      }

      response '200', 'OK' do
        run_test!
      end

      response '400', 'Bad Request' do
        run_test!
      end
    end
  end
  # Hospital section
  path '/api/v1/index' do
    get('List all hospitals') do
      tags 'Hospitals section'
      security [{ ApiKeyAuth: [] }]
      produces 'application/json'
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
  path '/api/v1/hospitals/{id}' do
    get('Hospital by ID') do
      tags 'Hospitals section'
      security [{ ApiKeyAuth: [] }]
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Hospital ID'
      response(200, 'successful') do
        run_test!
      end
      response '401', 'unauthorized' do
        run_test!
      end
      response '404', 'Hospital not found' do
        run_test!
      end
    end
  end
  path '/api/v1/hospitals/create' do
    post 'Create a hospital' do
      tags 'Hospitals section'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      parameter name: :hospital_params, in: :body, schema: {
        type: :object,
        properties: {
          region: { type: :string, default: 'Some region' },
          city: { type: :string, default: 'Some city' },
          address: { type: :string, default: 'Some address' },
          name: { type: :string, default: 'Some name' }
        },
        required: %w[region city address name]
      }

      response '201', 'returns the newly created hospital' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 address: { type: :string },
                 city: { type: :string },
                 name: { type: :string },
                 region: { type: :string }
               },
               required: %w[id address city name region]

        run_test!
      end

      response '401', 'unauthorized' do
        run_test!
      end

      response '422', 'Invalid request' do
        run_test!
      end
    end
  end

  path '/api/v1/hospitals/{id}/delete' do
    parameter name: :id, in: :path, type: :integer, description: 'Hospital ID'

    delete 'Delete a hospital' do
      tags 'Hospitals section'
      security [{ ApiKeyAuth: [] }]

      response '204', 'Hospital deleted' do
        run_test!
      end

      response '404', 'Hospital not found' do
        run_test!
      end
    end
  end

  path '/api/v1/hospitals/{id}/update' do
    patch 'Update hospital parameters' do
      tags 'Hospitals section'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the hospital to update'
      parameter name: :hospital_params, in: :body, type: :object,description: 'Hospital parameters to update', schema: {
        type: :object,
        properties: {
          name: { type: :string, default: 'Some name' },
          address: { type: :string, default: 'Some address' },
          city: { type: :string, default: 'Some city' },
          region: { type: :string, default: 'Some region' }
        },
        required: %w[name address city region]
      }

      response '200', 'Successful update' do
        run_test!
      end

      response '400', 'Invalid request' do
        run_test!
      end
    end
  end
  # Patient section
  path '/api/v1/patient/{id}' do
    get('Patient by ID') do
      tags 'Patient section'
      security [{ ApiKeyAuth: [] }]
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer,
                description: 'Patient ID'
      response(200, 'successful') do
        run_test!
      end
      response '401', 'unauthorized' do
        run_test!
      end
      response '404', 'Patient not found' do
        run_test!
      end
    end
  end
  path '/api/v1/patient/{id}/delete' do
    parameter name: :id, in: :path, type: :integer,
              description: 'Patient ID'
    delete 'Delete a patient' do
      tags 'Patient section'
      security [{ ApiKeyAuth: [] }]

      response '204', 'Patient deleted' do
        run_test!
      end

      response '404', 'Patient not found' do
        run_test!
      end
    end
  end
end
