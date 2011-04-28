class AspectsController < InheritedResources::Base
  before_filter :augment_args

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

  def args
    begin
    aspect = Aspect.process!(params)
    if aspect.save
      redirect_to aspect_path(aspect)
    elsif aspect.new_record?
      render :action => :new
    else
      render :action => :edit
    end
    rescue ArgDriven::UnrecognizedArgsError => e
      redirect_to :controller => :terminal, :action => :echo, :args => e.message
    end
  end

  protected

  def begin_of_association_chain
    current_user
  end
end
