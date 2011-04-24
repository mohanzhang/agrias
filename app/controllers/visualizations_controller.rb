class VisualizationsController < ApplicationController
  layout false

  def priority
    @tasks = current_user.tasks(5)
  end
end
