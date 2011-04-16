class CreateIdeas < ActiveRecord::Migration
  def self.up
    create_table :ideas do |t|
      t.string :synopsis
      t.text :details

      t.timestamps
    end
  end

  def self.down
    drop_table :ideas
  end
end
