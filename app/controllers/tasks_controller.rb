class TasksController < InheritedResources::Base
  before_filter :process_args, :only => [:create, :update]

  private

  def process_args
    unless params[:task]
      params[:task] = {:args => params[:args]}
    end
  end
end
