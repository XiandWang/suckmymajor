class LikesController < ApplicationController
	before_action :logged_in_user

	def create
		bet = Bet.find(params[:bet_id])
		current_user.like_status(bet)
		redirect_to bet.majors.first
	end

	def destroy
	end
end
