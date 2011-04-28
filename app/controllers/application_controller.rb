class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :augment_args, :only => :args

  protect_from_forgery

  def augment_args
    params[:user_id] = user_signed_in? ? current_user.id : nil
  end

  def args
    begin
      resource = send(:resource_class).send(:process!, params)
      if resource.save
        redirect_to polymorphic_path(resource)
      elsif resource.new_record?
        render :action => :new
      else
        render :action => :edit
      end
    rescue ArgDriven::UnrecognizedArgsError => e
      redirect_to :controller => :terminal, :action => :echo, :args => e.message
    end
  end
end
