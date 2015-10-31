class User < ActiveRecord::Base
	attr_accessor :remember_token, :activation_token, :reset_token
	before_save	{self.email.downcase!}
    before_create :create_activation_digest

	validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i	
    validates :email, presence: true, length: {maximum: 255 },
		format: {with: VALID_EMAIL_REGEX},
		uniqueness: {case_sensitive: false}
	has_secure_password

	validates :password, presence: true, length: {minimum: 6}, allow_nil: true

    has_many :bets, dependent: :destroy
    has_many :major_relationships, class_name: "UserMajorRelationship", 
                      foreign_key: "user_id", dependent: :destroy
    has_many :majors, through: :major_relationships
    has_many :comments, dependent: :destroy
    has_many :notifications, dependent: :destroy

    has_many :likes_relationships, class_name: "Like", foreign_key: "user_id", dependent: :destroy
    has_many :liked_bets, through: :likes_relationships, source: :bet
    
    acts_as_voter

	def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      												BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
    	SecureRandom.urlsafe_base64
    end

    def remember
    	self.remember_token = User.new_token
    	update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
    	return false if digest.nil?
    	BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
    	update_attribute(:remember_digest, nil)
    end

    def activate
        update_attribute(:activated, true)
        update_attribute(:activated_at, Time.zone.now)
    end

    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    def feed
        Bet.where("created_at >= ?", Time.now.beginning_of_day)
    end

    def join(major)
        major_relationships.create(major_id: major.id)
    end

    def quit(major)
        major_relationships.find_by(major_id: major.id).destroy
    end

    def joined?(major)
        majors.include?(major)
    end

    def betted?(bet)
        liked?(bet) || disliked?(bet)
    end

    def bet_for(bet)
        likes(bet)
    end

    def bet_against(bet)
        dislikes(bet)
    end

    def betted_for?(bet)
        liked?(bet)
    end

    def betted_against?(bet)
        disliked?(bet)
    end

    def get_bet_result(bet)
        if betted?(bet)
            if bet.lying? && betted_for?(bet)
                msg = "You lost to @#{bet.user.name}!"
                return msg
            elsif bet.lying? && betted_against?(bet)
                msg = "You beat @#{bet.user.name}!"
                return msg
            elsif !bet.lying? && betted_for?(bet)
                msg = "You beat @#{bet.user.name}!"
                return msg
            elsif !bet.lying? && betted_against?(bet)
                msg = "You lost to @#{bet.user.name}!"
                return msg
            end
        end
    end

    def get_bet_winner_loser(bet)
        if betted? bet
            if bet.lying? && betted_for?(bet)
                winner = bet.user
                loser = self
                return [winner, loser]
            elsif bet.lying? && betted_against?(bet)
                winner = self
                loser = bet.user
                return [winner, loser]
            elsif !bet.lying? && betted_for?(bet)
                winner = self
                loser = bet.user
                return [winner, loser]
            elsif !bet.lying && betted_against?(bet)
                winner = bet.user
                loser = self
                return [winner, loser]
            end
        else
            return "You have not betted this."  
        end             
    end

    def temp_access_token
      Rails.cache.fetch("user-#{self.id}-temp_access_token-#{Time.now.strftime("%Y%m%d")}") do
        SecureRandom.hex
      end
    end

    def like_status(bet)
        likes_relationships.create(bet_id: bet.id)
    end

    def liked_status?(bet)
        liked_bets.include?(bet)
    end

    
    private

        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
        end

end
