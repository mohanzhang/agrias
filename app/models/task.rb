class Task < ActiveRecord::Base
  include ArgDriven

  belongs_to :aspect

  validates :aspect, :leaf => true
  validates :aspect_id, :presence => true
  validates :description, :presence => true
  validates :due_on, :presence => true
  validates :importance, :presence => true, :inclusion => {:in => 1..3}
  validates :state, :presence => true, :inclusion => {:in => 1..4}

  on /(mk|make) task (\d+) under (.+) due (.+) i(\d)/ => :create_task

  attr_accessor :user_id

  after_save(:on => :create) do
    origin = BufferItem.find_by_phrase(self.description)
    origin.destroy if origin
  end

  UNDEFINED = 0
  NOT_STARTED = 1
  IN_PROGRESS = 2
  WAITING = 3
  ACCOMPLISHED = 4

  def not_started?
    return self.state == NOT_STARTED
  end

  def in_progress?
    return self.state == IN_PROGRESS
  end

  def waiting?
    return self.state == WAITING
  end

  def accomplished?
    return self.state == ACCOMPLISHED
  end

  def weight
    Aspect.find(self.aspect.path_ids).map {|a| a.weight}
  end

  private

  def self.create_task(matchdata, params)
    current_user = User.find(params[:user_id])

    task = Task.new

    buffer_item_index = matchdata[2]
    aspect_clue = matchdata[3]
    due_string = matchdata[4]
    importance = matchdata[5].to_i

    task.aspect = (a = current_user.aspects.with_clue(aspect_clue)) ? a.first : a
    task.description = current_user.buffer_items.all[buffer_item_index.to_i - 1].phrase
    task.importance = importance
    task.state = NOT_STARTED
    if (time = Chronic.parse(due_string))
      task.due_on = time.to_date
    else
      task.arg_errors << "did not specify a due date"
    end

    return task
  end
end
