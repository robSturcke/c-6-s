class PostsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
  end

  def new
    @post = current_user.posts.last
  end

  def edit

  end

  def create
    @post.user = current_user
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
    if @post.destroy
      flash[:notice] = "Deleted your posting!"
      redirect_to posts_path
    else
      flash[:error] = "Posting not killed, try again!"
      redirect_to :back
    end
  end

  private

  def post_params
    params.require(:post).permit(:name)
  end
end
