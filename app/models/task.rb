class Task < ActiveRecord::Base
  belongs_to :aspect

  validates :aspect_id, :presence => true
  validates :description, :presence => true
  validates :due_on, :presence => true
end
