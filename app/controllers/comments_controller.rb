class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def new
  	@comment = Comment.new
  end

  def create
  	if bet = Bet.find_by_id(params[:bet_id])
  		bet_hash = {bet_id: bet.id}
 		  comment_params = params.require(:comment).permit(:body).to_hash.merge! bet_hash
  		@comment = current_user.comments.build(comment_params)
  		if @comment.save
  			flash[:success] = "Comment created!"
  			redirect_to bet
  		else
  			flash[:danger] = "Comment could not be created!"
  			redirect_to bet
  		end
  	else
  		flash[:danger] = "Invalid request"
  		redirect_to root_url
  	end
  end

  def destroy
  end

  def show
  end

end
