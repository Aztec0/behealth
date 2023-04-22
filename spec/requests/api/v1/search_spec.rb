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

  path '/api/v1/search_by_doctor' do
    get 'Searching doctors in the hospital' do
      tags 'Search'
      produces 'application/json'
      parameter name: :query, in: :query, type: :string,
                description: 'Searching doctor by name, surname, second name, position ', required: true
      parameter hospital_id: :hospital_id, in: :query, type: :string,
                description: 'Hospital id for filtering', required: true

      response '200', 'Doctors found' do
        schema type: :object,
               properties: {
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

  path '/api/v1/search_by_hospital' do
    get 'Searching hospitals in region' do
      tags 'Search'
      produces 'application/json'
      parameter name: :query, in: :query, type: :string,
                description: 'Searching hospital by name, address, city', required: true
      parameter name: :region, in: :query, type: :string,
                description: 'Region filter, enter region name', required: true

      response '200', 'Hospitals found' do
        schema type: :object,
               properties: {
                 hospitals: {
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
