class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  def report_item
    @report = Report.new(report_params)
    @report.owner = current_user
    @report.status = "pending"
    @report.reported_item_id = params[:id]
    @report.save
    case params[:report][:reported_item_type]
    when "User"
      redirect_to user_profile_path(params[:id])
    when "Comment"
      post = Comment.where(id: params[:id]).first.post
      redirect_to post_path(post.id)
    when "Post"
      redirect_to post_path(params[:id])
    when "Poll"
      redirect_to poll_path(params[:id])
    when "Event"
      redirect_to event_path(params[:id])
    else
      redirect_to root_path
    end
  end

  def fetch_regions
    country = Country.where(id: params[:id]).first
    resource = params[:resource]
    if country.present? && resource.present?
      render partial: 'shared/regions_dropdown', locals: { resource: resource, regions: country.regions.order_by_name }
    else
      not_found
    end
  end

  def fetch_cities
    region = Region.where(id: params[:id]).first
    resource = params[:resource]
    if region.present? && resource.present?
      render partial: 'shared/cities_dropdown', locals: { resource: resource, cities: region.cities.order_by_name }
    else
      not_found
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.has_role? :admin
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :name, :gender, :birthdate, :country_id, :about])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :gender, :password, :current_password, :birthdate, :country_id, :about])
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    new_session_path(User)
  end

  def report_params
    params.require(:report).permit(:reported_item_type, :reason, :message)
  end

end
