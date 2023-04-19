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
  has_one :patient_document, as: :document

  validates :series, format: { with: /\A[A-Z]{2}\z/ }
  validates :number, format: { with: /\A[0-9]{6}\z/ }
  validates :issued_by, format: { with: /\A[\p{Cyrillic}\s]{1,60}\z/ }
end
