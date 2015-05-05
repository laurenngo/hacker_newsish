class VotesController < ApplicationController

  def index
    redirect_to posts_path
  end


  def new
    @vote = Vote.new
  end

  def create

    if params.key?(:comment_id)
      thing = Comment.find_by_id(params[:comment_id])
    elsif params.key?(:post_id)
      thing = Post.find_by_id(params[:post_id])
    elsif params.key?(:user_id)
      thing = User.find_by_id(params[:user_id])
    else
      return render plain: "invalid input"
    end

    my_vote = thing.votes.find_by_user_id(current_user.id)


    #if there is no vote from this user yet
    if my_vote.nil?
      #create a vote
    current_user.ratings << thing.votes.create(vote_params)

    else
      if (params[:vote][:value].to_i != my_vote.value)

        my_vote.value=params[:vote][:value]
        my_vote.save
      else
        flash[:danger] = "You already voted!"
      end
    end

    # Do it normally!
    # redirect_to :posts
    redirect_to(:back)

    # Do it in AJAX!
      # respond_to do |format|
      #   format.json {render json:{result:true, votes:thing.votes}}
      #   format.html {redirect_to :posts}

      end



    # render json: thing

    # if @vote.save
    #   flash[:success] = "Vote successful!"
    #   redirect_to :posts
    # else
    #   flash[:danger] = "Vote was unsuccessful. Please try again."
    #   redirect_to :posts
    # end




  private

  def vote_params
    params.require(:vote).permit(:value)

  end




end
