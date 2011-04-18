class Task < ActiveRecord::Base
  belongs_to :aspect

  validates :aspect_id, :presence => true
  validates :description, :presence => true
  validates :due_on, :presence => true

  attr_accessor :args

  before_validation(:on => :create) do
    process_args! if self.args
  end

  after_save(:on => :create) do
    origin = BufferItem.find_by_phrase(self.description)
    origin.destroy if origin
  end

  private

  def process_args!
    self.args.match(/task (\d+) under (.+) due (.+)/) do |match|
      buffer_item_index = match[1]
      aspect_clue = match[2]
      due_string = match[3]

      self.description = BufferItem.all[buffer_item_index.to_i - 1].phrase
      self.aspect = (a = Aspect.where("name like ?", aspect_clue + "%")) ? a.first : a
      if due_string=~ /in (\d+) day(s|)/
        self.due_on = $1.to_i.days.from_now.to_date
      elsif due_string =~ /on (.+)/
        self.due_on = Date.parse($1)
      else
        self.errors.add(:args, "did not specify a due date")
      end
    end
  end
end
