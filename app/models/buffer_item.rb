class BufferItem < ActiveRecord::Base
  include ArgDriven

  belongs_to :user
  validates :user_id, :presence => true

  validates :phrase, :presence => true, :uniqueness => true

  default_scope order("created_at ASC")

  on /buf (.+)/ => :create_buffer_item


  private

  def self.create_buffer_item(matchdata, params)
    current_user = User.find(params[:user_id])
    buffer_item = current_user.buffer_items.build

    buffer_item.phrase = matchdata[1]

    return buffer_item
  end
end
