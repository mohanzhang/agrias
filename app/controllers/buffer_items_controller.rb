class BufferItemsController < InheritedResources::Base
  before_filter :parse_args, :only => [:create, :update]

  layout false
  
  def create
    create! { buffer_items_path }
  end

  private

  def parse_args
    unless params[:buffer_item]
      params[:buffer_item] = {
        :phrase => params[:args]
      }
    end
  end
end
