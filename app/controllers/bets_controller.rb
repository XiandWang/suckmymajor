class BetsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]

	def create
	  @bet = current_user.bets.build(bet_params)
	  if @bet.save
	  	flash[:success] = "Bet Placed!"
	  	redirect_to root_url
	  else
	  	@feed_items = []
	  	render 'pages/home'
	  end
	end

	def destroy
	  @bet.destroy
	  flash[:success] = "Bet destroyed!"
	  redirect_to request.referrer || root_url
	end

	def like
      @bet = Bet.find(params[:id])
	  @bet.liked_by current_user if logged_in?
	  @result = false
	  if !@bet.lying?
	  	@result = true
	  end
	  respond_to do |format|
	    format.html {redirect_to root_url}
	    format.js
	  end
	end

	def dislike
      @bet = Bet.find(params[:id])
      if current_user.liked?(@bet) || current_user.disliked?(@bet)
      	flash[:info] = 'You already betted this.'
      	redirect_to root_url
      else
	    @bet.disliked_by current_user if logged_in?
	    redirect_to root_url
	  end
	end

	private

		def bet_params
		  params.require(:bet).permit(:status, :lying, :proof, :picture)			
		end

		def correct_user 
		  @bet = current_user.bets.find_by(id: params[:id])
		  redirect_to root_url if @bet.nil?
		end
end
