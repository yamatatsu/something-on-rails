class IkedaNote::EventsController < IkedaNote::ApplicationController
  def index
    @events = current_user.events
  end

  def new
    @event = Event.new
  end

  def create
    event = current_user.events.build(event_params)
    if event.valid?
      event.save
      redirect_to action: :index
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :occurrence_year)
  end
end
