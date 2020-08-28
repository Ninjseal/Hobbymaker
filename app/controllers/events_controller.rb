class EventsController < ApplicationController
  before_action :authenticate_user!

  before_action :load_record, only: [:show, :add_to_favorites, :add_to_google_calendar]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def add_to_google_calendar
    google_calendar = GoogleCalendar.new(current_user)
    google_calendar.create_event(@event)
    head :ok
  end

  def add_to_favorites
    if favorite = Favorite.where(user_id: current_user.id, favorite_item_id: @event.id, favorite_item_type: "event").first
      favorite.destroy
    else
      favorite = Favorite.new(user_id: current_user.id)
      favorite.favorite_item = @event
      favorite.save
    end
    head :ok
  end

  private

    def load_record
      @event = Event.where(id: params[:id]).first
      return not_found unless @event.present?
    end

end
