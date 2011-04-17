class Task < ActiveRecord::Base
  belongs_to :aspect

  validates :aspect_id, :presence => true
  validates :description, :presence => true
  validates :due_on, :presence => true

  attr_accessor :parent_clue

  before_validation(:on => :create) do
    if self.parent_clue
      self.aspect = Aspect.where("name like ?", self.parent_clue + "%").first
    end
  end
end
