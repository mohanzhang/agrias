class AppointmentsController < InheritedResources::Base
  before_filter :pass_args, :only => :create

  respond_to :html, :json

  def show
    show! do |format|
      format.json { render :json => @appointment }
    end
  end

  def update
    update! do |format|
      format.json { render :nothing => true }
    end
  end

  protected

  def begin_of_association_chain
    current_user
  end
end
