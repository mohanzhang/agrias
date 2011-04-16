class TerminalController < ApplicationController
  before_filter :set_args

  def echo
    
  end

  private

  def set_args
    @args = params[:args]
  end
end
