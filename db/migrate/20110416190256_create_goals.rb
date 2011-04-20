class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.references :user

      t.string :statement
      t.date :accomplish_on
      t.boolean :accomplished, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :goals
  end
end
