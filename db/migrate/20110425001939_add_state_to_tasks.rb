class AddStateToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :state, :integer, :default => 1, :null => false
    remove_column :tasks, :accomplished
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
