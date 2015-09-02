class MajorsController < ApplicationController
  def show
  	@major = Major.find(params[:id])
  	@users = @major.users
  end

  def index
  	@majors = Major.all
  end
end
