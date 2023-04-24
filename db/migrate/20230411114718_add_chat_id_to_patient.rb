# frozen_string_literal: true

class AddChatIdToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :chat_id, :bigint
  end
end
