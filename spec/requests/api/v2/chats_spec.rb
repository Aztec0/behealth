require 'swagger_helper'

RSpec.describe 'api/v2/chats', swagger_doc: 'v1/swagger.yaml', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:chat) { create(:chat, user_ids: [user.id, other_user.id]) }

  path '/api/v2/chats' do
    get('List all chats') do
      tags 'Chats'
      security [{ ApiKeyAuth: [] }]
      parameter name: :user_id, in: :query, type: :integer, required: true

      response '200', 'successful' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       type: { type: :string },
                       attributes: {
                         type: :object,
                         properties: {
                           name: { type: :string },
                           user_ids: {
                             type: :array,
                             items: {
                               type: :integer
                             }
                           }
                         }
                       }
                     }
                   }
                 }
               },
               required: %w[data]

        let(:user_id) { user.id }

        before { chat }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:user_id) { user.id }
        let(:Authorization) { '' }

        run_test!
      end
    end
  end

  path '/api/v2/chats/{id}' do
    parameter name: :id, in: :path, type: :integer

    get('Show a chat') do
      tags 'Chats'
      security [{ ApiKeyAuth: [] }]

      response '200', 'successful' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     type: { type: :string },
                     attributes: {
                       type: :object,
                       properties: {
                         name: { type: :string },
                         user_ids: {
                           type: :array,
                           items: {
                             type: :integer
                           }
                         }
                       }
                     }
                   }
                 }
               },
               required: %w[data]

        let(:id) { chat.id }

        run_test!
      end

      response '404', 'not found' do
        let(:id) { chat.id + 1 }

        run_test!
      end
    end
  end

    path '/api/v2/chats/{id}' do
      patch('Updates a chat') do
        tags 'Chats'
        security [{ BearerAuth: [] }]
        consumes 'application/json'
        parameter name: :id, in: :path, type: :integer
        parameter name: :chat_params, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string, default: 'New Chat Title' },
            description: { type: :string, default: 'New Chat Description' }
          },
          required: []
        }

        response '200', 'successful' do
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   description: { type: :string }
                 },
                 required: %w[id title description]

          let(:id) { chat.id }
          let(:chat_params) { { title: 'New Chat Title', description: 'New Chat Description' } }

          run_test! do |response|
            data = JSON.parse(response.body, symbolize_names: true)
            expect(data[:title]).to eq(chat_params[:title])
            expect(data[:description]).to eq(chat_params[:description])
          end
        end

        response '422', 'invalid request' do
          let(:id) { chat.id }
          let(:chat_params) { { title: '' } }

          run_test!
        end

        response '401', 'unauthorized' do
          let(:id) { chat.id }
          let(:chat_params) { { title: 'New Chat Title' } }
          let(:headers) { {} }

          run_test!
        end
      end
    end

      path '/chats/{id}' do
        delete 'Deletes a chat' do
          tags 'Chats'
          security [{ ApiKeyAuth: [] }]
          parameter name: :id, in: :path, type: :integer

          response '204', 'chat deleted' do
            let(:Authorization) { "Bearer #{access_token.token}" }

            run_test! do |response|
              expect(Chat.exists?(id)).to be_falsey
            end
          end

          response '401', 'unauthorized' do
            let(:Authorization) { '' }

            run_test!
          end

          response '404', 'chat not found' do
            let(:id) { 'invalid' }
            let(:Authorization) { "Bearer #{access_token.token}" }

            run_test!
          end
        end
      end
    end