require 'swagger_helper'

RSpec.describe 'api/v1/messages', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/api/v1/messages' do
    get('List all messages') do
      tags 'Messages'
      parameter name: :patient_id, in: :query, type: :integer, required: true, description: 'Patient ID'
      parameter name: :doctor_id, in: :query, type: :integer, required: true, description: 'Doctor ID'
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

    post('Create a message') do
      tags 'Messages'
      security [{ ApiKeyAuth: [] }]
      consumes 'application/json'
      parameter name: :message, in: :body, schema: {
        type: :object,
        properties: {
          patient_id: { type: :integer, default: 1 },
          doctor_id: { type: :integer, default: 1 },
          content: { type: :string, default: 'Hello, how are you feeling today?' }
        },
        required: %w[patient_id doctor_id content]
      }

      response '201', 'returns the newly created message' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 patient_id: { type: :integer },
                 doctor_id: { type: :integer },
                 content: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id patient_id doctor_id content created_at updated_at]

        let(:message) do
          {
            patient_id: 1,
            doctor_id: 1,
            content: 'Hello, how are you feeling today?'
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:message) { {} }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:message) do
          {
            patient_id: 1,
            doctor_id: 1,
            content: 'Hello, how are you feeling today?'
          }
        end

        let(:Authorization) { '' }

        run_test!
      end
    end
    path '/api/v1/messages/{id}' do
      patch('Update a message') do
        tags 'Messages'
        security [{ ApiKeyAuth: [] }]
        consumes 'application/json'
        parameter name: :id, in: :path, type: :integer
        parameter name: :message_params, in: :body, schema: {
          type: :object,
          properties: {
            content: { type: :string, default: 'New message content' },
            patient_id: { type: :integer },
            doctor_id: { type: :integer }
          }
        }

        response '200', 'message updated' do
          let(:message_params) do
            {
              content: 'Updated message content',
              patient_id: patient.id,
              doctor_id: doctor.id
            }
          end

          run_test! do
            expect(json_response[:content]).to eq('Updated message content')
          end
        end

        response '422', 'invalid request' do
          let(:message_params) { { content: '' } }

          run_test! do
            expect(json_response[:errors][:content]).to include("can't be blank")
          end
        end

        response '404', 'message not found' do
          let(:message_id) { 'invalid' }
          let(:message_params) do
            {
              content: 'Updated message content',
              patient_id: patient.id,
              doctor_id: doctor.id
            }
          end

          run_test! do
            expect(json_response[:errors]).to include('Message not found')
          end
        end

        response '401', 'unauthorized' do
          let(:message_params) do
            {
              content: 'Updated message content',
              patient_id: patient.id,
              doctor_id: doctor.id
            }
          end

          let(:Authorization) { '' }

          run_test!
        end
      end
    end

    path '/api/v1/messages/{id}' do
      delete('Deletes a message') do
        tags 'Messages'
        security [{ Bearer: [] }]
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer

        response '204', 'message deleted' do
          let(:id) { message.id }

          run_test! do |response|
            expect(response.body).to be_empty
            expect(Message.find_by_id(id)).to be_nil
          end
        end

        response '401', 'unauthorized' do
          let(:id) { message.id }
          let(:Authorization) { '' }

          run_test!
        end

        response '404', 'not found' do
          let(:id) { -1 }

          run_test!
        end
      end
    end
  end
end
