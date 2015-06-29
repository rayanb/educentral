class Category < ActiveRecord::Base
  has_many :courses
  has_many :tracks

  def color
    ['#34495e', '#2ecc71', '#16a085', '#f1c40f', '#1abc9c', '#3498db', '#bdc3c7', '#8e44ad', '#c0392b', '#f39c12', '#2c3e50', '#2ecc71', '#95a5a6', '#8e44ad', '#bdc3c7', '#c0392b', '#2980b9', '#2c3e50', '#bdc3c7', '#16a085', '#27ae60', '#d35400', '#f39c12', '#95a5a6', '#c0392b' ][id-1]
  end
end
