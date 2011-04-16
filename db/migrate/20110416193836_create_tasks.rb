class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.references :aspect

      t.string :description
      t.text :notes

      t.date :due_on
      t.integer :importance

      t.boolean :accomplished

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
