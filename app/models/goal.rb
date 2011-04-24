class Goal < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true

  validates :statement, :presence => true
  validates :accomplish_on, :presence => true
end
