class CourseTrack < ActiveRecord::Base
  belongs_to :course
  belongs_to :track
end
