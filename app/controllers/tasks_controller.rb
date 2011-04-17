class TasksController < InheritedResources::Base
  before_filter :parse_args_create, :only => [:create]

  private

  def parse_args_create
    unless params[:task]
      params[:task] = {}
      if params[:args].match(/task (\d+) under (.+) due (.+)/)
        params[:task][:description] = BufferItem.all[$1.to_i - 1].phrase
        params[:task][:parent_clue] = $2
        if $3 =~ /in (\d+) days/
          params[:task][:due_on] = $1.to_i.days.from_now
        elsif $3 =~ /on (.+)/
          params[:task][:due_on] = $1
        end
      end
    end
  end
end
