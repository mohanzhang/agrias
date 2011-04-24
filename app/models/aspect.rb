class Aspect < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true

  validates :name, :presence => true, :uniqueness => true
  validates :weight, :presence => true, :inclusion => {:in => 1..3}

  has_ancestry
  
  attr_accessor :args

  before_validation(:on => :create) do
    process_args! if self.args
  end

  # an aspect's tasks is its tasks in priority order and then the tasks of
  # its children by weight
  def tasks
    ret = Task.where(:aspect_id => self.id).order("importance DESC").all
    if self.has_children?
      self.children.order("weight DESC").each do |aspect|
        ret << aspect.tasks
      end
    end
    return ret.flatten
  end

  private

  def process_args!
    if self.args.match(/aspect (.+) (\d) under (.+)/)
      name = $1
      weight = $2.to_i
      parent_clue = $3

      parents = Aspect.where("name like ?", parent_clue + "%")
      
      if parents.size > 1
        self.errors.add(:args, "specified an ambiguous parent")
      elsif parents.size == 0
        self.errors.add(:args, "specified a parent that did not exist")
      else
        self.parent = parents.first
      end

      self.name = name
      self.weight = weight
    elsif self.args.match(/aspect (.+) (\d) as root/)
      self.name = $1
      self.weight = $2.to_i
    else
      self.errors.add(:args, "are invalid")
    end
  end
      
end
