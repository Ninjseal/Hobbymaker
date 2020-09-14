class EventNotification < Noticed::Base
  deliver_by :database

  param :event

  def output
    params[:event].name
  end

  def url
    event_path(params[:event])
  end
end
