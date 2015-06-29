class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.includes(:courses, :tracks).find(params[:id])
    @courses = @category.courses
    @tracks = @category.tracks.includes(:owner)
  end

end