class Goal < ActiveRecord::Base
  validates :statement, :presence => true
  validates :accomplish_on, :presence => true
end
