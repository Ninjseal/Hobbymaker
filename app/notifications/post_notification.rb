class PostNotification < Noticed::Base
  deliver_by :database

  param :post

  def output
    params[:post].title
  end

  def url
    post_path(params[:post])
  end
end
