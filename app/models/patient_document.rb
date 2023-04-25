# frozen_string_literal: true

# == Schema Information
#
# Table name: patient_documents
#
#  id            :bigint           not null, primary key
#  document_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  document_id   :bigint
#  patient_id    :bigint           not null
#
# Indexes
#
#  index_patient_documents_on_document    (document_type,document_id)
#  index_patient_documents_on_patient_id  (patient_id)
#
class PatientDocument < ApplicationRecord
  belongs_to :patient
  belongs_to :document, polymorphic: true
end
