class VisualizationsController < ApplicationController
  layout false

  def priority
    @buffer_items = current_user.buffer_items
    @tasks = current_user.tasks(:limit => 5, :accomplished => false)
  end
end
