class VisualizationsController < ApplicationController
  layout false

  def priority
    @buffer_items = current_user.buffer_items
    @tasks = current_user.tasks(:limit => 5, :state => Task::NOT_STARTED)
  end

  def table
    @aspects = current_user.aspects.roots
  end
end
