class BufferItem < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true

  validates :phrase, :presence => true, :uniqueness => true

  default_scope order("created_at ASC")

  attr_accessor :args

  before_validation(:on => :create) do
    process_args! if self.args
  end

  private

  def process_args!
    if self.args.match(/(.+)/)
      self.phrase = $1
    else
      self.errors.add(:args, "were empty")
    end
  end
end
