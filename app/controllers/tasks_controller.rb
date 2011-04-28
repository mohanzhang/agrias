class TasksController < InheritedResources::Base
  layout false

  def index
  end

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

  def reset
    @task = Task.find(params[:id])
    raise "User does not own task" unless @task.aspect.user_id == current_user.id

    @task.update_attribute(:state, Task::NOT_STARTED)
    redirect_to task_path(@task)
  end

  def start
    @task = Task.find(params[:id])
    raise "User does not own task" unless @task.aspect.user_id == current_user.id

    @task.update_attribute(:state, Task::IN_PROGRESS)
    redirect_to task_path(@task)
  end

  def wait
    @task = Task.find(params[:id])
    raise "User does not own task" unless @task.aspect.user_id == current_user.id

    @task.update_attribute(:state, Task::WAITING)
    redirect_to task_path(@task)
  end

  def complete
    @task = Task.find(params[:id])
    raise "User does not own task" unless @task.aspect.user_id == current_user.id

    @task.update_attribute(:state, Task::ACCOMPLISHED)
    redirect_to task_path(@task)
  end
end
