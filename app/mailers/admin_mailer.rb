class AdminMailer < ApplicationMailer
  default from: 'no-reply@hobbymaker.com'

  def report_notification_email
    @user = User.find(params[:reported_user_id])
    @report = Report.find(params[:report_id])
    @reason = @report.other? ? "other reasons" : @report.reason
    @message = params[:admin_message]
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, subject: params[:subject], template_name: "report_#{@report.reported_item_type.downcase}_email")
  end
end
