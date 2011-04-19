class VisualizationsController < ApplicationController
  def priority
    @tasks = Task.all
  end
end
