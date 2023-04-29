# frozen_string_literal: true

# == Schema Information
#
# Table name: passports
#
#  id         :bigint           not null, primary key
#  date       :date
#  issued_by  :string
#  number     :string
#  series     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Passport < ApplicationRecord
  include Constantable

  has_one :patient_document, as: :document

  validates :series, format: { with: PASSPORT_SERIES_REGEX }
  validates :number, format: { with: PASSPORT_NUMBER_REGEX }
  validates :issued_by, format: { with: PASSPORT_ISSUED_BY_REGEX }
end
