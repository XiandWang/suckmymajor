class Notification < ActiveRecord::Base
  belongs_to :user

  after_create :real_time_push_to_client

  def real_time_push_to_client
  	if self.user
  		hash = {}
  		# need updates
  		hash[:count] = 5
      MessageBus.publish "/notifications_count/#{self.user.temp_access_token}", hash
  	end
  end
end
