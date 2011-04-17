class BufferItem < ActiveRecord::Base
  validates :phrase, :presence => true, :uniqueness => true

  default_scope order("created_at ASC")
end
