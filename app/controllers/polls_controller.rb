class PollsController < ApplicationController
  before_action :authenticate_user!

  before_action :load_record, only: [:show, :vote]
  before_action :init_record, only: [:create]

  def index
    @polls = Poll.all
  end

  def show
  end

  def new
    @poll = Poll.new
    2.times { @poll.options.build }
  end

  def create
    if @poll.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def vote
    option_ids = params[:poll][:option_ids].reject(&:blank?)
    option_ids.each do |option_id|
      PollVote.create(user_id: current_user.id, poll_option_id: option_id, poll_id: @poll.id)
    end
    redirect_to poll_url(@poll)
  end

  def report_poll
    @poll = Poll.where(id: params[:id]).first
    @report = Report.new
  end

  private

    def create_params
      params.require(:poll).permit(:question, :allow_multiple_answers, options_attributes: [:answer])
    end

    def init_record
      @poll = Poll.new(create_params)
      @poll.owner = current_user
    end

    def load_record
      @poll = Poll.where(id: params[:id]).first
      return not_found unless @poll.present?
    end

end
