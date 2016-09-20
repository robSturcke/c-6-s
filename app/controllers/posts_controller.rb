class PostsController < ApplicationController
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
    @post.assign_attributes(post_params)
    if @post.save
      flash[:notice] = "Updated!"
      redirect_to @post
    else
      flash[:error] = "Not updated, try again!"
      render :new
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Posted!"
      redirect_to @post
    else
      flash[:error] = "Not posted, try again!"
      render :new
    end
  end

  def update

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
end
