class Aspect < ActiveRecord::Base
  validates :name, :presence => true

  has_ancestry
end
