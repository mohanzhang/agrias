class AspectsController < InheritedResources::Base
  respond_to :html, :json

  layout false

  def index
    @aspects = Aspect.roots.order("weight DESC")
  end

  def show
    show! do |format|
      format.json { render :json => @aspect }
    end
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
