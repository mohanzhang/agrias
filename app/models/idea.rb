class Idea < ActiveRecord::Base
  validates :synopsis, :presence => true
end
