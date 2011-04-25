class Task < ActiveRecord::Base
  belongs_to :aspect

  validates :aspect, :leaf => true
  validates :aspect_id, :presence => true
  validates :description, :presence => true
  validates :due_on, :presence => true
  validates :importance, :presence => true, :inclusion => {:in => 1..3}
  validates :state, :presence => true, :inclusion => {:in => 1..4}

  attr_accessor :args, :user_id

  before_validation(:on => :create) do
    process_args! if self.args
  end

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

  def process_args!
    current_user = User.find(self.user_id)
    self.args.match(/task (\d+) under (.+) due (.+) i(\d)/) do |match|
      buffer_item_index = match[1]
      aspect_clue = match[2]
      due_string = match[3]
      importance = match[4].to_i

      self.aspect = (a = current_user.aspects.with_clue(aspect_clue)) ? a.first : a
      self.description = current_user.buffer_items.all[buffer_item_index.to_i - 1].phrase
      self.importance = importance
      self.state = NOT_STARTED
      if (time = Chronic.parse(due_string))
        self.due_on = time.to_date
      else
        self.errors.add(:args, "did not specify a due date")
      end
    end
  end
end
