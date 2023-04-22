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
  NUMBER_REGEX = /\A[0-9]{9}\z/

  has_one :patient_document, as: :document

  validates :number, format: { with: NUMBER_REGEX } #Винести в константу
  validates :issued_by, format: { with: /\A[0-9]{4}\z/ } #Винести в константу
end
