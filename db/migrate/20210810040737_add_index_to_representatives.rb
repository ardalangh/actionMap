# frozen_string_literal: true

class AddIndexToRepresentatives < ActiveRecord::Migration[5.2]
    def change
        add_index :representatives, :name, unique: true
    end
end
