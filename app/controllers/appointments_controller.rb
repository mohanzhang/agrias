class AppointmentsController < InheritedResources::Base
  respond_to :html, :json

  layout false

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

  def attended
    @appointment = begin_of_association_chain.appointments.find(params[:id])
    @appointment.update_attribute(:attended, true)
    redirect_to appointment_path(@appointment)
  end

  protected

  def begin_of_association_chain
    current_user
  end
end
