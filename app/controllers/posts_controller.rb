class PostsController < ApplicationController
  before_filter :check_post_count, only: [:new, :create]
  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Posted!"
      redirect_to posts_path
    else
      flash[:error] = "Not posted, try again!"
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)
    if @post.save
      flash[:notice] = "Updated!"
      redirect_to @post
    else
      flash[:error] = "Not updated, try again!"
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.destroy
      flash[:notice] = "Deleted your posting!"
      redirect_to posts_path
    else
      flash[:error] = "Posting not killed, try again!"
      redirect_to :back
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :console, :light_lvl, :activity, :destiny_class, :mic, :notes)
  end

  def check_post_count
    if current_user.posts.count >= 1
      redirect_to edit_post_path(current_user.posts.first),
        notice: 'You already have an active post.'
    end
  end
end
