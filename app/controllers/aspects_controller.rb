class AspectsController < InheritedResources::Base
  before_filter :pass_args, :only => [:create]

  layout false

  def index
    @aspects = Aspect.roots
  end
end
