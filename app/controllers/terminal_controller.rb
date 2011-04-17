class TerminalController < ApplicationController
  before_filter :set_args

  def echo
    render :text => @args
  end

  private

  def set_args
    @args = params[:args]
  end
end
