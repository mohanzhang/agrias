class CreateBufferItems < ActiveRecord::Migration
  def self.up
    create_table :buffer_items do |t|
      t.string :phrase

      t.timestamps
    end
  end

  def self.down
    drop_table :buffer_items
  end
end
