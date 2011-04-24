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

  def completed
    @task = Task.find(params[:id])
    raise "User does not own task" unless @task.aspect.user_id == current_user.id

    @task.update_attribute(:accomplished, true)
    redirect_to task_path(@task)
  end
end
