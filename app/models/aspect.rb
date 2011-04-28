class Aspect < ActiveRecord::Base
  include ArgDriven

  belongs_to :user
  validates :user_id, :presence => true

  validates :name, :presence => true, :uniqueness => {:scope => :user_id}
  validates :weight, :presence => true, :inclusion => {:in => 1..3}

  has_ancestry
  
  scope :with_clue, lambda {|clue| where("upper(name) like ?", clue.upcase + "%")}

  on /(make|mk) aspect (.+) (\d) under (.+)/ => :create_child_aspect,
    /(make|mk) aspect (.+) (\d) as root/ => :create_root_aspect,
    /(move|mv) aspect (.+) under (.+)/ => :move_aspect

  # an aspect's tasks is its tasks in priority order and then the tasks of
  # its children by weight
  def tasks(options={})
    ret = Task.where(options.merge(:aspect_id => self.id)).order("importance DESC").all
    if self.has_children?
      self.children.order("weight DESC").each do |aspect|
        ret << aspect.tasks(options)
      end
    end
    return ret.flatten
  end

  private

  def self.find_unique_by_arg_clue(parent_scope, arg)
    aspect = parent_scope.aspects.with_clue(arg)
    if aspect.size > 1
      raise ArgDriven::AmbiguousArgError.new(arg)
    elsif aspect.size == 0
      raise ArgDriven::NotFoundArgError.new(arg)
    else
      aspect = aspect.first
    end

    return aspect
  end

  def self.create_child_aspect(matchdata, params)
    current_user = User.find(params[:user_id])
    aspect = current_user.aspects.build

    name = matchdata[2]
    weight = matchdata[3].to_i
    parent_clue = matchdata[4]

    parents = current_user.aspects.with_clue(parent_clue)

    if parents.size > 1
      aspect.arg_errors << "specified an ambiguous parent"
    elsif parents.size == 0
      aspect.arg_errors << "specified a parent that did not exist"
    else
      aspect.parent = parents.first
    end

    aspect.name = name
    aspect.weight = weight

    return aspect
  end

  def self.create_root_aspect(matchdata, params)
    current_user = User.find(params[:user_id])
    aspect = current_user.aspects.build

    aspect.name = matchdata[2]
    aspect.weight = matchdata[3].to_i
    aspect
  end

  def self.move_aspect(matchdata, params)
    current_user = User.find(params[:user_id])
    aspect_clue = matchdata[2]
    parent_clue = matchdata[3]

    aspect = find_unique_by_arg_clue(current_user, aspect_clue)
    parent = find_unique_by_arg_clue(current_user, parent_clue)

    aspect.parent = parent

    return aspect
  end
end
