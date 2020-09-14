ActiveAdmin.register Report do
  actions :all, except: [:new, :edit]

  index do
    selectable_column
    id_column
    column "Reported By", :owner
    column :reported_item
    column :reported_item_type
    column "Reason" do |r|
      r.reason.titleize
    end
    column :created_at
    tag_column :status
    actions
  end

  show do
    attributes_table do
      row "Reported By" do |r|
        link_to(r.owner.name, admin_user_path(r.owner))
      end
      row :reported_item
      row :reported_item_type
      row "Reason" do |r|
        r.reason.titleize
      end
      row :created_at
      tag_row :status
      row :message
    end
  end

  action_item :send_notification, only: :show, if: proc { Report.where(id: params[:id]).first&.pending? } do
    link_to "Send notification",  report_notification_path(id: params[:id]), method: :get
  end
  action_item :reject_report, only: :show, if: proc { Report.where(id: params[:id]).first&.pending? } do
    link_to "Reject Report", reject_report_path(id: params[:id]), method: :post
  end

  controller do
    def reject
      @report = Report.where(id: params[:id]).first
      @report.rejected!
      redirect_to admin_report_path(@report)
    end

    def report_notification
      @report_id = params[:id]
      render template:'admin/send_notification'
    end

    def mail
      @report = Report.where(id: params[:id]).first
      @subject = "Your #{@report.reported_item_type.titleize} has been reported"
      case @report.reported_item_type
      when "User"
        AdminMailer.with(reported_user_id: @report.reported_item.id, report_id: @report.id, admin_message: params[:message][0], subject: "You have been reported").report_notification_email.deliver
      when "Event"
        @report.reported_item.organizers.each do |u|
          AdminMailer.with(reported_user_id: u.id, report_id: @report.id, admin_message: params[:message][0], subject: @subject).report_notification_email.deliver
        end
      else
        AdminMailer.with(reported_user_id: @report.reported_item.try(:user_id) || @report.reported_item.try(:created_by), report_id: @report.id, admin_message: params[:message][0], subject: @subject).report_notification_email.deliver
      end
      @report.approved!
      redirect_to admin_report_path(@report)
    end
  end

  filter :reported_item_type, as: :select, collection: ["User", "Event", "Post", "Poll", "Comment"]
  filter :reason, as: :select, collection: Report.reasons.transform_keys(&:titleize)
  filter :status, as: :select, collection: Report.statuses.transform_keys(&:titleize)
  filter :created_at
end
