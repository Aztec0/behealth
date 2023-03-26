# frozen_string_literal: true

class HeadDoctor < Doctor
  has_many :doctors, dependent: :destroy
  belongs_to :hospital, optional: true

  has_secure_password

  validates :name, presence: true

  # this part is for create doctor
  def create_doctor(params)
    doctor = Doctor.new(params)
    if doctor.save
      doctor.generate_password_token!
      # DoctorMailer.with(doctor).temporary_password.deliver_later
      render json: doctor, status: :created
    else
      render json: { error: doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # this method is used to delete doctor
  def delete_doctor(doctor_id)
    doctor = Doctor.find(doctor_id)
    if doctor.destroy
      head :no_content
    else
      render json: { error: doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # this part is for cancel appointment
  def canceled_appointment
    Appointment.cancled
  end
end
