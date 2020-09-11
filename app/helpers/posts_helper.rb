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

  def get_interests(post)
    num_of_interests = @post.interests.count
    content_tag(:div, class: "post-interests") do
      @post.interests.each_with_index do |interest, idx|
        concat(link_to(interest.name, root_path))
        concat(", ") unless idx == num_of_interests - 1
      end
    end
  end

end
