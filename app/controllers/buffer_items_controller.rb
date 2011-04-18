class BufferItemsController < InheritedResources::Base
  before_filter :pass_args, :only => [:create, :update]

  layout false
  
  def create
    create! { buffer_items_path }
  end
end
