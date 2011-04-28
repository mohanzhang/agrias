class Appointment < ActiveRecord::Base
  include ArgDriven

  belongs_to :user
  validates :user_id, :presence => true

  validates :description, :presence => true
  validates :occurs_at, :presence => true

  default_scope order("occurs_at ASC")

  scope :unattended, where(:attended => false)
  scope :attended, where(:attended => true)

  on /(make|mk) appt (\d+) (.+)/ => :create_appointment

  after_save(:on => :create) do
    origin = BufferItem.find_by_phrase(self.description)
    origin.destroy if origin
  end

  private
  
  def self.create_appointment(matchdata, params)
    current_user = User.find(params[:user_id])

    buffer_item_index = matchdata[2]
    time_string = matchdata[3]

    appt = current_user.appointments.build

    # TODO what if buffer is OOB?
    appt.description = current_user.buffer_items.all[buffer_item_index.to_i - 1].phrase
    if (time = Chronic.parse(time_string))
      appt.occurs_at = time
    else
      appt.arg_errors << "did not specify a valid time"
    end

    return appt
  end
end
