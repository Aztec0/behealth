# frozen_string_literal: true

class AddHeadDoctorIdToDoctors < ActiveRecord::Migration[7.0]
  add_reference :doctors, :head_doctor, foreign_key: { to_table: :doctors }
end
