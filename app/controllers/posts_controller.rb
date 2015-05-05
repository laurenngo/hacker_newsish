class PostsController < ApplicationController

before_action :is_authenticated?

# Do it in AJAX!
  def index
    @posts = Post.all
    @vote = Vote.new
    respond_to do |format|
      format.json{render json:@posts}
      format.html
    end

  end


# Do it normally!
  # def index
  #   @posts = Post.all
  #   @vote = Vote.new
  # end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
   if @post.save
     flash[:success] = "Post successful."
     # redirect_to showposts_path
     redirect_to :posts
   else
     flash[:danger] = "Post unsuccessful, please make sure you have a valid link."
     # redirect_to showposts_path
      redirect_to :posts
   end
    # render :json => params
  end

  # def show
  #   @post = Post.find(params[:id])
  #    # render :json => params
  # end

  def show

    # redirect_to post_comments_path
  end



  private

  def post_params
    params.require(:post).permit(:title, :link)

  end


end
