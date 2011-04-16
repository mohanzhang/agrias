class BufferItem < ActiveRecord::Base
  validates :phrase, :presence => true
end
