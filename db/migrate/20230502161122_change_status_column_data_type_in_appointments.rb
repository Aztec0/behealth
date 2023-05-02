class ChangeStatusColumnDataTypeInAppointments < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :status, 'integer USING CAST(status AS integer)'
  end
end
