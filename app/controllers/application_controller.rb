class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  protect_from_forgery

  def pass_args
    unless params[send(:resource_instance_name)]
      params[send(:resource_instance_name)] = {
        :args => params[:args],
        :user_id => user_signed_in? ? current_user.id : nil
      }
    end
  end
end
