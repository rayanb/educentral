class Course < ActiveRecord::Base
  has_many :course_tracks
  has_many :reviews
  has_many :tracks, through: :course_tracks
  has_many :user_courses
  has_many :users, through: :user_courses
  belongs_to :category
  belongs_to :platform


  def rating
    ratings = reviews.map { |rev| rev.rating  }
    average = ratings.reduce(:+).to_f / ratings.size
  end

  def difficulty
    difficulties = reviews.map { |rev| rev.difficulty  }
    average = difficulties.reduce(:+).to_f / difficulties.size
  end

end
