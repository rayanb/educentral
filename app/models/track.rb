class Track < ActiveRecord::Base
  belongs_to :owner, class_name: "User",
                        foreign_key: "user_id"
  belongs_to :category
  has_many :course_tracks
  has_many :courses, through: :course_tracks
  has_many :user_tracks
  has_many :users, through: :user_tracks

  has_many :children, class_name: "Track",
                          foreign_key: "parent_id"
  belongs_to :parent, class_name: "Track"

  def fork
    new_track           = track.dup
    new_track.courses   = track.courses
    new_track.owner     = current_user
    new_track.parent_id = track.id
    new_track.save
    new_track
  end
end
