class PostsController < ApplicationController
  before_action :authenticate_user!

  before_action :load_record, only: [:show, :add_to_favorites]
  before_action :init_record, only: [:create]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    if @post.save
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

  def add_to_favorites
    if favorite = Favorite.where(user_id: current_user.id, favorite_item_id: @post.id, favorite_item_type: "post").first
      favorite.destroy
    else
      favorite = Favorite.new(user_id: current_user.id)
      favorite.favorite_item = @post
      favorite.save
    end
    head :ok
  end

  private

    def create_params
      params.require(:post).permit(:thumbnail, :title, :content, :disable_comments, interest_ids: [])
    end

    def init_record
      @post = Post.new(create_params)
      @post.creator = current_user
    end

    def load_record
      @post = Post.includes(:interests).where(id: params[:id]).first
      return not_found unless @post.present?
    end

end
