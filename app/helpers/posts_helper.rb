module PostsHelper

  def format_date(date)
    date.strftime("%B %-d, %Y")
  end

  def date_to_iso8601(date)
    date.strftime('%FT%T%:z')
  end

  def is_favored?(post)
    return false if current_user.nil?
    post.is_favored_by?(current_user)
  end

end
