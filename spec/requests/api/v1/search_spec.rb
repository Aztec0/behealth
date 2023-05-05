# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V1::SearchController', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/api/v1/search' do
    get 'Search for a hospital or doctor in the region' do
      tags 'Search'
      produces 'application/json'
      parameter name: :query, in: :query, type: :string,
                description: 'Searching query for hospital or doctor. Input address, name, city for hospital or
                              First Name, Last Name, specialty(position) for doctor', required: false
      parameter name: :region, in: :query, type: :string,
                description: 'Region filter. Enter the name of the region to search for a hospital or doctor in that
                              location. If field leave empty, request was for all areas', required: false

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
        run_test!
      end

      response '422', 'Invalid search query' do
        run_test!
      end
    end
  end

  path '/api/v1/search_doctors_by_specialty' do
    get 'Searching doctors by specialty' do
      tags 'Search'
      produces 'application/json'
      parameter name: :query, in: :query, type: :string,
                description: 'Searching doctor by first_name, last_name, position ', required: false
      parameter name: :position, in: :query, type: :string,
                description: 'Doctor speciality', required: false

      response '200', 'Doctors found' do
        schema type: :object,
               properties: {
                 doctors: {
                   type: :array
                 }
               }
        run_test!
      end

      response '422', 'Invalid search query' do
        run_test!
      end
    end
  end

  path '/api/v1/search_hospitals' do
    get 'Searching hospitals' do
      tags 'Search'
      produces 'application/json'
      parameter name: :query, in: :query, type: :string,
                description: 'Searching hospital by name. If field leave empty request was for all hospitals',
                required: false

      response '200', 'Hospitals found' do
        schema type: :object,
               properties: {
                 hospitals: {
                   type: :array
                 }
               }
        run_test!
      end

      response '422', 'Invalid search query' do
        run_test!
      end
    end
  end
end
