class Muse < ActiveRecord::Base
  validates :name, :presence => true
end
