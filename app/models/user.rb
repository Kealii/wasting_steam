class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid        = auth_info.uid
      new_user.user_name   = auth_info.extra.raw_info.name
      new_user.twitter_name = auth_info.extra.raw_info.screen_name
    end
  end
end
