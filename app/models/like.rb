class Like < ActiveRecord::Base
	belongs_to :user, class_name: "User"
	belongs_to :bet, class_name: "Bet"
	validates :user_id, presence: true
	validates :bet_id, presence: true
end
