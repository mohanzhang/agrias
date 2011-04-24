class TasksController < InheritedResources::Base
  before_filter :pass_args, :only => [:create, :update]

  layout false

  def show
    show! do |format|
      format.json { render :json => @task }
    end
  end

  def update
    update! do |format|
      format.json { render :nothing => true }
    end
  end
end
