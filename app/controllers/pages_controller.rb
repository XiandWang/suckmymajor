class PagesController < ApplicationController
  def home
  	if logged_in?
  	  @bet = current_user.bets.build
  	  @feed_items = current_user.feed.paginate(page: params[:page])

      @winning_res = Result.get_winning_results()
      @winning_res.sort! {|x,y| y[1] <=> x[1]}
  	end
  end

  def help
  end

  def about
  end
  
end
