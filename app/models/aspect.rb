class Aspect < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_ancestry
  
  attr_accessor :parent_clue

  before_validation(:on => :create) do
    if self.parent_clue
      self.parent = Aspect.where("name like ?", self.parent_clue + "%").first
    end
  end
      
end
