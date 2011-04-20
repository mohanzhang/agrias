class CreateMuses < ActiveRecord::Migration
  def self.up
    create_table :muses do |t|
      t.references :user

      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :muses
  end
end
