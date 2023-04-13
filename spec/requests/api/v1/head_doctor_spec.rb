# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Head Doctors API', type: :request do
  path '/api/v1/head_doctors' do
    get 'Retrieves a list of doctors associated with the head doctor' do
      tags 'Head Doctors'
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
                   head_doctor_id: { type: :integer },
                   hospital_id: { type: :integer }
                 },
                 required: %w[id name surname email phone birthday position rating created_at updated_at head_doctor_id
                              hospital_id]
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

  path '/api/v1/head_doctors/create_doctor' do
    post 'Creates a doctor' do
      tags 'Head Doctors'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      parameter name: :doctor_params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          surname: { type: :string },
          email: { type: :string },
          phone: { type: :integer },
          birthday: { type: :string },
          position: { type: :string }
        },
        required: %w[name surname email phone birthday position hospital_id password password_confirmation]
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

  path '/api/v1/head_doctors/create_hospital' do
    post 'Creates a hospital' do
      tags 'Head Doctors'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      parameter name: :hospital, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          address: { type: :string },
          city: { type: :string },
          region: { type: :string }
        },
        required: %w[name address city region]
      }

      response '201', 'returns the newly created hospital' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 address: { type: :string },
                 city: { type: :string },
                 region: { type: :string }
               },
               required: %w[id name address city region]

        let(:hospital) { { name: 'New Hospital', address: '123 Main St', city: 'Anytown', region: 'NY' } }
        run_test!
      end

      response '422', 'returns an error message if hospital cannot be created' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        let(:hospital) { { name: '', address: '', city: '', region: '' } }
        run_test!
      end
    end
  end

  path '/api/v1/head_doctors/{id}/delete_doctor' do
    delete 'Deletes a doctor by id' do
      tags 'Head Doctors'
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
end
