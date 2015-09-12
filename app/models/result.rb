class Result < ActiveRecord::Base
	belongs_to :bet 
	belongs_to :winner, class_name: "User"
	belongs_to :loser, class_name: "User"
	belongs_to :winner_major, class_name: "Major"
	validates :bet_id, presence: true
	validates :winner_id, presence: true
	validates :loser_id, presence: true
	validates :winner_major_id, presence: true


	def self.get_winning_results()
	  Result.select("*").where("created_at > ?", Time.now.beginning_of_day).group("winner_major_id").count.to_a
	end
end
