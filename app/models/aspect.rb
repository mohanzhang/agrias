class Aspect < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true

  validates :name, :presence => true, :uniqueness => true
  validates :weight, :presence => true, :inclusion => {:in => 1..3}

  default_scope order("weight DESC")

  has_ancestry
  
  attr_accessor :args

  before_validation(:on => :create) do
    process_args! if self.args
  end

  private

  def process_args!
    if self.args.match(/aspect (.+) under (.+)/)
      name = $1
      parent_clue = $2

      parents = Aspect.where("name like ?", parent_clue + "%")
      
      if parents.size > 1
        self.errors.add(:args, "specified an ambiguous parent")
      elsif parents.size == 0
        self.errors.add(:args, "specified a parent that did not exist")
      else
        self.parent = parents.first
      end

      self.name = name
    elsif self.args.match(/aspect (.+)/)
      self.name = $1
    end
  end
      
end
