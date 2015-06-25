class Bet < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :status, presence: true, length: {maximum: 140}, inclusion: { in: ["studying", "procrastinating"] }
  validates :lying, inclusion: {in: [true, false]}
  validates :proof, presence: true, allow_blank: true
  validate :picture_size

  acts_as_votable

  private

    def picture_size
      if picture.size > 5.megabytes
      	errors.add(:picture, "Picture's size is too big. Should be less than 5MB")
      end
    end
end
