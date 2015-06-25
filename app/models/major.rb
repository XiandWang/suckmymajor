class Major < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true, length: {maximum: 255}
	has_many :user_relationships, class_name: "UserMajorRelationship",
								  foreign_key: "major_id"
	has_many :users, through: :user_relationships
end
