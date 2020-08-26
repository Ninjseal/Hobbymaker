require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class GoogleCalendar

  CALENDAR_ID = 'primary'

  def initialize(user)
    @user = user
  end

  def create_event(event)
    client = get_google_calendar_client
    unless get_calendar_event(event, client).present?
      calendar_event = Google::Apis::CalendarV3::Event.new(format_event(event))
      result = client.insert_event(CALENDAR_ID, calendar_event)
      result.present?
    else
      false
    end
  end

  private

  def get_calendar_event(event, client=nil)
    client = get_google_calendar_client if client.nil?
    result = client.list_events(CALENDAR_ID, q: event.name)
    result = result.items.select { |e| e.start.date_time == event.start_date }
    result.first
  end

  def format_event(event)
    {
      summary: event.name,
      description: event.description,
      start: {
        date_time: event.start_date.strftime("%FT%T") + ".000Z",
      },
      end: {
        date_time: event.end_date.strftime("%FT%T") + ".000Z",
      },
      sendNotifications: true,
      reminders: {
        use_default: true
      }
    }
  end

  def get_google_calendar_client
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless (@user.present? && @user.access_token.present? && @user.refresh_token.present?)

    secrets = Google::APIClient::ClientSecrets.new({
      "web" => {
        "access_token" => @user.access_token,
        "refresh_token" => @user.refresh_token,
        "client_id" => ENV["GOOGLE_CLIENT_ID"],
        "client_secret" => ENV["GOOGLE_CLIENT_SECRET"]
      }
    })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = "refresh_token"

      if @user.token_expired?
        client.authorization.refresh!
        @user.update(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue => e
      raise e.message
    end
    client
  end

end
