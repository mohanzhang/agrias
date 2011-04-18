class AppointmentsController < InheritedResources::Base
  before_filter :pass_args, :only => :create
end
