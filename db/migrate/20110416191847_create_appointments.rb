class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      t.string :description
      t.text :notes

      t.datetime :occurs_at
      t.boolean :optional, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
