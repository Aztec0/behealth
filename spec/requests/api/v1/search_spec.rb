# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V1::SearchController', type: :request do
  path '/api/v1/search' do
    get 'Search for hospitals or doctors' do
      tags 'Search'
      produces 'application/json'
      parameter name: :query, in: :query, type: :string,
                description: 'Search query for hospital or doctor', required: true
      parameter name: :region, in: :query, type: :string,
                description: 'Region filter', required: false

      response '200', 'Hospitals and doctors found' do
        schema type: :object,
               properties: {
                 hospitals: {
                   type: :array
                 },
                 doctors: {
                   type: :array
                 }
               }

        let(:query) { 'John' }
        let(:region) { 'New York' }
        run_test!
      end

      response '422', 'Invalid search query' do
        let(:query) { '' }
        let(:region) { '' }
        run_test!
      end
    end
  end
end
