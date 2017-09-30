class IkedaNote::EventsController < IkedaNote::ApplicationController
  before_action :set_event, only: %i[edit update destroy]

  def index
    @events = current_user.events
  end

  def new
    @event = Event.new
  end

  def create
    event = current_user.events.build(event_params)
    return unless event.valid?

    # TODO: バリデーション
    event.save
    redirect_to action: :index
  end

  def edit
  end

  def update
    # TODO: バリデーション
    @event.update!(event_params)
    redirect_to action: :index
  end

  def destroy
    @event.destroy
    redirect_to action: :index
  end

  private

  def event_params
    params.require(:event).permit(:name, :occurrence_year)
  end

  def set_event
    # TODO: notFoundのハンドリング
    @event = current_user.events.find(params[:id])
  end
end
