class VisualizationsController < ApplicationController
  def priority
    @tasks = current_user.tasks(5)
  end
end
