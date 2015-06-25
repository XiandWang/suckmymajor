class UserMajorRelationship < ActiveRecord::Base
	belongs_to :user, class_name: "User"
	belongs_to :major, class_name: "Major"

	validates :user_id, presence: true
	validates :major_id, presence: true
end
