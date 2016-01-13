class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    where(uid: auth_info.uid).first_or_create do |new_user|
      new_user.uid        = auth_info.uid
      new_user.steam_name = auth_info.info.nickname
    end
  end
end
