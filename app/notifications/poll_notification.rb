class PollNotification < Noticed::Base
  deliver_by :database

  param :poll

  def output
    params[:poll].question
  end

  def url
    poll_path(params[:poll])
  end
end
