class UserMajorRelationshipsController < ApplicationController
	before_action :logged_in_user

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
end
