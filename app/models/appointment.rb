class Appointment < ActiveRecord::Base
  validates :description, :presence => true
  validates :occurs_at, :presence => true
end
