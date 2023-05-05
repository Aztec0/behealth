# frozen_string_literal: true

# == Schema Information
#
# Table name: id_cards
#
#  id         :bigint           not null, primary key
#  date       :date
#  issued_by  :string
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class IdCard < ApplicationRecord
  include Constantable

  has_one :patient_document, as: :document

  validates :number, format: { with: ID_CARD_NUMBER_REGEX }
  validates :issued_by, format: { with: ID_CARD_ISSUED_BY_REGEX }
end
