class CreateSubtasks < ActiveRecord::Migration
  def self.up
    create_table :subtasks do |t|
      t.references :task

      t.string :description
      t.boolean :accomplished, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :subtasks
  end
end
