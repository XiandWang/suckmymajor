class BetsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]
	before_action :check_major, only: [:create, :like, :dislike]

	def show
	  @bet = Bet.find(params[:id])
	  @comments = @bet.comments.find_each
	end

	def create
	  @bet = current_user.bets.build(bet_params)
	  @result = false
	  if @bet.save
	  	flash[:success] = "Bet Placed!"
	  	@bet.create_major_relationship(current_user.majors)
	  	@result = true
	  	create_notifications(@bet.id)
	  	respond_to do |format|
	  	  format.html {redirect_to root_url}
	  	  format.js
	  	end
	  else
	  	@feed_items = []
	  	@winning_res = []
	  	respond_to do |format|
	  	  format.html {render 'pages/home'}
	  	  format.js  
	  	end
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

		def create_notifications(bet_id)
			current_user.majors.each do |major|
				major_users = major.users 
				major_users.each do |user|
					MajorNotification.create(user_id: user.id, bet_id: bet_id, read:false)
				end
			end
		end

		def check_major
			if current_user.majors.blank?
				flash[:danger] = "Please join a major first like the others."
				redirect_to majors_url
			end
		end
end
