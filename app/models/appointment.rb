class Appointment < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true

  validates :description, :presence => true
  validates :occurs_at, :presence => true

  default_scope order("occurs_at ASC")

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
    self.args.match(/appt (\d+) (.+)/) do |match|
      buffer_item_index = match[1]
      time_string = match[2]

      # TODO what if buffer is OOB?
      self.description = BufferItem.all[buffer_item_index.to_i - 1].phrase
      if (time = Chronic.parse(time_string))
        self.occurs_at = time
      else
        self.errors.add(:args, "did not specify a valid time")
      end
    end
  end
end
