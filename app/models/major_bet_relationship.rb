class MajorBetRelationship < ActiveRecord::Base
	belongs_to :bet 
	belongs_to :major 
	validates :major_id, presence: true
	validates :bet_id, presence: true
end
