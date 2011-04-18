class ApplicationController < ActionController::Base
  protect_from_forgery

  def pass_args
    unless params[send(:resource_instance_name)]
      params[send(:resource_instance_name)] = {:args => params[:args]}
    end
  end
end
