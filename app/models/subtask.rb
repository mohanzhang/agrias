class Subtask < ActiveRecord::Base
  belongs_to :task

  validates :description, :presence => true
  validates :task_id, :presence => true
end
