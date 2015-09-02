class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :bet

  validates :body, presence: true, length: {maximum: 255 }

  def extract_mentions
    mentions = body.scan(/@\w+/)
    if mentions.any?
      mentioned_user_ids = []
      mentions.each do |mention_name|
      	mention_name = mention_name[1...mention_name.size]
      	if user = User.find_by(name: mention_name)
      		# create notification for every user
      	end
      end
    end

  end
end
