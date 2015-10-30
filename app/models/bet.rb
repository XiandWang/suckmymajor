class Bet < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc)}

  validates :user_id, presence: true
  validates :status, presence: true, length: {maximum: 140}, inclusion: { in: ["studying", "procrastinating"] }
  validates :lying, inclusion: {in: [true, false]}
  

  acts_as_votable

  has_many :comments

  has_many :major_relationships, class_name: "MajorBetRelationship",
                  foreign_key: "bet_id", dependent: :destroy
  has_many :majors, through: :major_relationships

  has_many :result_relationships, class_name: "Result",
                  foreign_key: "bet_id", dependent: :destroy

  has_many :winners, through: :result_relationships
  has_many :losers, through: :result_relationships

  has_many :major_notifications


  def create_major_relationship(majors)
    majors.each do |major|
      # catch exception
      major_relationships.create(major_id: major.id)
    end
  end


end
