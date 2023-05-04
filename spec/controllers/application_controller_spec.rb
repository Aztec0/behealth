# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController do
  describe '#current_user' do
    context 'when the user is a patient' do
      it 'returns the current patient' do
        patient = create(:patient)
        controller.instance_variable_set(:@current_patient, patient)
        expect(controller.send(:current_user)).to eq(patient)
      end
    end

    context 'when the user is a doctor' do
      it 'returns the current doctor' do
        hospital = create(:hospital)
        doctor = create(:doctor, hospital_id: hospital.id)
        controller.instance_variable_set(:@current_doctor, doctor)
        expect(controller.send(:current_user)).to eq(doctor)
      end
    end
  end

  describe '#authenticate_patient_user' do
    context 'when the current user is a patient' do
      it 'does not raise an error' do
        patient = create(:patient)
        controller.instance_variable_set(:@current_patient, patient)
        expect { controller.send(:authenticate_patient_user) }.not_to raise_error
      end
    end

    context 'when the current user is not a patient' do
      it 'raises a Pundit::NotAuthorizedError error' do
        hospital = create(:hospital)
        doctor = create(:doctor, hospital_id: hospital.id)
        controller.instance_variable_set(:@current_doctor, doctor)
        expect { controller.send(:authenticate_patient_user) }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe '#authenticate_doctor_user' do
    context 'when the current user is a doctor' do
      it 'does not raise an error' do
        hospital = create(:hospital)
        doctor = create(:doctor, hospital_id: hospital.id)
        controller.instance_variable_set(:@current_doctor, doctor)
        expect { controller.send(:authenticate_doctor_user) }.not_to raise_error
      end
    end

    context 'when the current user is not a doctor' do
      it 'raises a Pundit::NotAuthorizedError error' do
        patient = create(:patient)
        controller.instance_variable_set(:@current_patient, patient)
        expect { controller.send(:authenticate_doctor_user) }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
