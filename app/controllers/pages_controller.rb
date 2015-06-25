class PagesController < ApplicationController
  def home
  	if logged_in?
  	  @bet = current_user.bets.build
  	  @feed_items = current_user.feed.paginate(page: params[:page])
  	end
  end

  def help
  end

  def about
  end
  
end
