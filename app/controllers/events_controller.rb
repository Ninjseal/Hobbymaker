class EventsController < ApplicationController
  before_action :authenticate_user!

  before_action :load_record, only: [:show, :add_to_favorites, :add_to_google_calendar, :join, :withdraw]
  before_action :init_record, only: [:create]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    if @event.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def add_to_google_calendar
    google_calendar = GoogleCalendar.new(current_user)
    if google_calendar.create_event(@event)
      respond_to do |format|
        format.js {
          render js: "alert('Event added to calendar.');", status: 200
        }
      end
    else
      respond_to do |format|
        format.js {
          render js: "alert('Failed to add event to calendar.');", status: 400
        }
      end
    end
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

  def join
    unless current_user.participates?(@event)
      current_user.joined_events << @event
      render partial: 'join_button', locals: { btn_type: 'withdraw', event_id: @event.id }
    else
      render :status => 400
    end
  end

  def withdraw
    if current_user.participates?(@event)
      current_user.joined_events.delete(@event)
      render partial: 'join_button', locals: { btn_type: 'join', event_id: @event.id }
    else
      render :status => 400
    end
  end

  private

    def create_params
      params.require(:event).permit(:thumbnail, :name, :start_date, :end_date, :kind, :description, interest_ids: [])
    end

    def create_params_venue
      params.require(:event).permit(:thumbnail, :name, :start_date, :end_date, :kind, :city_id, :location, :description, interest_ids: [])
    end

    def init_record
      if params[:event][:kind] == "online"
        @event = Event.new(create_params)
      else
        @event = Event.new(create_params_venue)
      end
      @event.organizers << current_user
    end

    def load_record
      @event = Event.with_rich_text_description_and_embeds.where(id: params[:id]).first
      return not_found unless @event.present?
    end

end
