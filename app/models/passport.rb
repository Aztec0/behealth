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
end
