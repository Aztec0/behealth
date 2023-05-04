# frozen_string_literal: true

# == Schema Information
#
# Table name: feedbacks
#
#  id              :bigint           not null, primary key
#  body            :text
#  doctorable_type :string
#  rating          :integer
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  doctorable_id   :bigint
#  patient_id      :bigint           not null
#
# Indexes
#
#  index_feedbacks_on_doctorable_type_and_doctorable_id  (doctorable_type,doctorable_id)
#  index_feedbacks_on_patient_id                         (patient_id)
#
# Foreign Keys
#
#  fk_rails_...  (patient_id => patients.id)
#
class Feedback < ApplicationRecord
  belongs_to :doctorable, polymorphic: true
  belongs_to :patient, optional: true
end
