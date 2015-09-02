class PagesController < ApplicationController
  def home
  	if logged_in?
  	  @bet = current_user.bets.build
  	  @feed_items = current_user.feed.paginate(page: params[:page])

      @winning_res = []
      Major.all.each do |major|
        @winning_res << [major, major.get_today_winning]
      end
      @winning_res.sort! {|x,y| y[1] <=> x[1]}
      @winning_res[10...@winning_res.size - 1] = nil
      @winning_res = @winning_res[0..9]
  	end
  end

  def help
  end

  def about
  end
  
end
