class BufferItemsController < InheritedResources::Base
  before_filter :pass_args, :only => [:create]

  respond_to :html, :json

  layout false

  def show
    show! do |format|
      format.json { render :json => @buffer_item }
    end
  end
  
  def create
    create! { buffer_items_path }
  end

  def update
    update! do |format|
      format.json { render :nothing => true }
    end
  end
end
