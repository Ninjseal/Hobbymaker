module ApplicationHelper
  def controller_inquiry
    controller_name.inquiry
  end

  def action_inquiry
    action_name.inquiry
  end

  def nav_item_class(active = false)
    "nav-item#{active ? ' active' : ''}"
  end

  def has_asset?(path)
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include? path
    else
      Rails.application.assets_manifest.assets[path].present?
    end
  end
end
