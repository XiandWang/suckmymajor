class BetsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]

	def show
	  @bet = Bet.find(params[:id])
	  @comments = @bet.comments.all
	end

	def create
	  @bet = current_user.bets.build(bet_params)
	  if @bet.save
	  	flash[:success] = "Bet Placed!"
	  	@bet.create_major_relationship(current_user.majors)
	  	respond_to do |format|
	  	  format.html {redirect_to root_url}
	  	  format.js
	  	end
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
      if current_user.betted?(@bet)
      	flash[:info] = "You already betted this."
      	redirect_to root_url
      else
	    @bet.liked_by current_user if logged_in?
	    winner, loser = current_user.get_bet_winner_loser(@bet)
	    winner.majors.each do |major|
	      @bet.result_relationships.create(winner_id: winner.id, loser_id: loser.id, winner_major_id: major.id)
	    end
	    respond_to do |format|
	      format.html {redirect_to root_url}
	      format.js
	    end
	  end
	end

	def dislike
      @bet = Bet.find(params[:id])
      if current_user.betted?(@bet)
      	flash[:info] = 'You already betted this.'
      	redirect_to root_url
      else
	    @bet.disliked_by current_user if logged_in?
	    winner, loser = current_user.get_bet_winner_loser(@bet)
	    winner.majors.each do |major|
	      @bet.result_relationships.create(winner_id: winner.id, loser_id: loser.id, winner_major_id: major.id)
	    end
	    respond_to do |format|
	      format.html {redirect_to root_url}
	      format.js
	    end
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
