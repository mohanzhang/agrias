class CreateAspects < ActiveRecord::Migration
  def self.up
    create_table :aspects do |t|
      t.references :user

      t.string :name
      t.integer :weight

      t.string :ancestry

      t.timestamps
    end

    add_index :aspects, :ancestry
  end

  def self.down
    remove_index :aspects, :ancestry
    drop_table :aspects
  end
end
