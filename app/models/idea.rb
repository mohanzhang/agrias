class Idea < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true

  validates :synopsis, :presence => true
end
