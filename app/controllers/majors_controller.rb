class MajorsController < ApplicationController
  def show
  	@major = Major.find(params[:id])
  	@users = @major.users
  	@bets = @major.get_today_bets
  end

  def index
  	@majors = Major.all
  end

  def students
  	@major = Major.find(params[:id])
  	@students = @major.users
  end
end
