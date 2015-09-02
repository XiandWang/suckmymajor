class UserMajorRelationshipsController < ApplicationController
	before_action :logged_in_user
	before_action :check_major_count, only: :create

	def create
		major = Major.find(params[:major_id])
		current_user.join(major)
		redirect_to majors_url
	end

	def destroy
		major = UserMajorRelationship.find(params[:id]).major
		current_user.quit(major)
		redirect_to majors_url
	end

	private

	  def check_major_count
	  	if current_user.majors.count >= 2
	  		flash[:info] = "Sorry, you can only join two majors!"
	  		redirect_to majors_url
	  	end
	  end
end
