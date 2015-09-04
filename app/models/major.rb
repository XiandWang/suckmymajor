class Major < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true, length: {maximum: 255}
	has_many :user_relationships, class_name: "UserMajorRelationship",
								  foreign_key: "major_id"
	has_many :users, through: :user_relationships
	has_many :bet_relationships, class_name: "MajorBetRelationship",
									foreign_key: "major_id"
	has_many :bets, through: :bet_relationships
    

    has_many :result_relationships, class_name: "Result", foreign_key: "winner_major_id"
    has_many :winning_bets, through: :result_relationships, source: :bet
    has_many :winners, through: :result_relationships, source: :winner

	def get_today_studying_people()
		bet_ids = MajorBetRelationship.where("major_id = ? AND created_at >= ?", 
			self.id, Time.now.beginning_of_day).pluck(:bet_id)
		Bet.where("id IN (?) AND status = ?", bet_ids, "studying").count
	end

	def get_today_procrastinating_people()
		bet_ids = MajorBetRelationship.where("major_id = ? AND created_at >= ?", 
			self.id, Time.now.beginning_of_day).pluck(:bet_id)
		Bet.where("id IN (?) AND status = ?", bet_ids, "procrastinating").count		
	end

	def get_today_winning()
		Result.where("winner_major_id = ? AND created_at >= ?", self.id, Time.now.beginning_of_day).count
	end

	def get_today_bets()
		Bet.select("*").from("Bets, Majors, Major_Bet_Relationships").where("Majors.id = Major_Bet_Relationships.major_id AND 
			Bets.id = Major_Bet_Relationships.bet_id AND Majors.id = ? AND Bets.created_at >= ?", self.id, Time.now.beginning_of_day)
	end
end
