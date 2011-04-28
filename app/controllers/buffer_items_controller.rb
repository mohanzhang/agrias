class BufferItemsController < InheritedResources::Base
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

  protected

  def begin_of_association_chain
    current_user
  end
end
