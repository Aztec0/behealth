require 'swagger_helper'

RSpec.describe 'api/v1/calendars', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/api/v1/calendars' do
    get('List all calendars') do
      tags 'Calendars'
      security [{ ApiKeyAuth: [] }]
      parameter name: :doctor_id, in: :query, type: :integer
      response(200, 'successful') do
        let(:doctor_id) { doctor.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:doctor_id) { doctor.id }
        let(:Authorization) { '' }

        run_test!
      end
    end
  end

  path '/api/v1/calendars/{id}' do
    parameter name: :id, in: :path, type: :integer
    get('Show a calendar') do
    tags 'Calendars'
    security [{ ApiKeyAuth: [] }]

    response(200, 'successful') do
    let(:id) { calendar.id }

    after do |example|
      example.metadata[:response][:content] = {
        'application/json' => {
          example: JSON.parse(response.body, symbolize_names: true)
        }
      }
    end

    run_test!
  end

  response '404', 'not found' do
    let(:id) { 0 }

    run_test!
  end

  response '401', 'unauthorized' do
    let(:id) { calendar.id }
    let(:Authorization) { '' }

    run_test!
  end
end

    path '/api/v1/calendars/{id}' do
      patch('Update a calendar') do
        tags 'Calendars'
        security [{ ApiKeyAuth: [] }]
        consumes 'application/json'
        parameter name: :calendar_params, in: :body, schema: {
          type: :object,
          properties: {
            start_time: { type: :string, default: '2023-05-05 10:00:00' },
            end_time: { type: :string, default: '2023-05-05 11:00:00' },
            note: { type: :string, default: 'Updated note' },
          },
          required: %w[start_time end_time note]
        }
        parameter name: :id, in: :path, type: :string

        response '200', 'returns the updated calendar' do
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   start_time: { type: :string },
                   end_time: { type: :string },
                   note: { type: :string },
                   user_id: { type: :integer }
                 },
                 required: %w[id start_time end_time note user_id]

          let(:calendar_params) do
            {
              start_time: '2023-05-05 10:00:00',
              end_time: '2023-05-05 11:00:00',
              note: 'Updated note'
            }
          end

          run_test! do
            expect(json['note']).to eq('Updated note')
          end
        end

        response '404', 'calendar not found' do
          let(:id) { 'invalid' }
          let(:calendar_params) do
            {
              start_time: '2023-05-05 10:00:00',
              end_time: '2023-05-05 11:00:00',
              note: 'Updated note'
            }
          end
          run_test!
        end

        response '401', 'unauthorized' do
          let(:id) { calendar.id }
          let(:calendar_params) do
            {
              start_time: '2023-05-05 10:00:00',
              end_time: '2023-05-05 11:00:00',
              note: 'Updated note'
            }
          end

          let(:Authorization) { '' }

          run_test!
        end
      end
    end
  end