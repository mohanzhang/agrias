class AspectsController < InheritedResources::Base
  before_filter :parse_args_create, :only => [:create]

  layout false

  private

  def parse_args_create
    unless params[:aspect]
      params[:aspect] = {}
      if params[:args].match(/aspect (.+) under (.+)/)
        params[:aspect][:name] = $1
        params[:aspect][:parent_clue] = $2
      elsif params[:args].match(/aspect (.+)/)
        params[:aspect][:name] = $1
      end
    end
  end
end
