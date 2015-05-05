class CommentsController < ApplicationController

before_action :is_authenticated?

  def index

    # @comment = Comment.post_id(params[:id])
    # @comments = Comment.all
    @post = Post.find_by_id(params[:post_id])
    @vote = Vote.new

    # render :json => params

  end

  def new
    @post = Post.find(params[:post_id])
    @comment= Comment.new


  end

  def create


    Comment.create({:body => params[:comment][:body], :post_id => params[:post_id], :user_id => current_user.id})

    redirect_to post_comments_path

  end

  private

  def post_params
    params.require(:post).permit(:title, :link, :id)

  end


end
