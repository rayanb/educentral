class User < ActiveRecord::Base
	# has_secure_password
	# validates_uniqueness_of :username
	# validates_uniqueness_of :email
	has_many :reviews
	has_many :tracks
  has_many :user_tracks
  has_many :tracks, through: :user_tracks
  has_many :user_courses
  has_many :courses, through: :user_courses

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def progress(track_id)
    hey   = Track.includes(:courses).find(track_id).courses
    if courses.find_by(id: hey.map{|i| i.id})
      taken = courses.select{|c| hey.include?(c)}
      return taken.length ? (taken.length.to_f/hey.length.to_f)*100 : 0
    else
      0
    end
  end

  def completed(track_id)
    all = Track.includes(:courses).find(track_id).courses
    if courses.find_by(id: all.map{|i| i.id})
      taken = courses.select{|c| all.include?(c)}
      return taken.length
    else
      0
    end
  end

end
