class MajorsController < ApplicationController
  before_action :logged_in_user
  before_action :check_correct_major, only: :show

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

  private
    def check_correct_major
      major = Major.find(params[:id])
      if !current_user.majors.include?(major)
        flash[:danger] = "You don't belong to this major."
        redirect_to majors_url
      end
    end
end
