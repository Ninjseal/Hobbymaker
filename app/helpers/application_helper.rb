module ApplicationHelper
  def controller_inquiry
    controller_name.inquiry
  end

  def nav_item_class(active = false)
    "nav-item#{active ? ' active' : ''}"
  end

end
