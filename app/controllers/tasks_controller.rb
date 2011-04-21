class TasksController < InheritedResources::Base
  before_filter :pass_args, :only => [:create, :update]

  layout false
end
