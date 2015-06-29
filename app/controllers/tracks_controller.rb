class TracksController < ApplicationController

  def index
  end

  def json
    @tracks = Track.includes(:owner, :category).where(parent_id: nil)
    render json: @tracks.to_json(:include => { :owner => { :only => [:name, :id] }, category: {only: :name} })
  end

  def show
    @track  = Track.includes(:owner, :parent).find(params[:id])
    @count  = @track.popularity
    @owner = Track.find(@track.parent_id).owner if @track.parent_id
    @review = Review.new
  end


  def cat
    Category.includes(:courses => [:reviews, :platform]).find(params[:category_id])
  end


  def new
    @category = cat
    @courses  = cat.courses.includes(:reviews, :platform).all
  end

  def new_json
    render json: {category: cat, courses: cat.courses.to_json(:include => [:reviews, :platform])}
  end


  def create
    user          = User.find(session[:user_id])
    track         = user.tracks.new(track_params)
    track.user_id = session[:user_id]
    array_of_ids  = params[:order].split(",").to_a.map{|i| i.to_i}
    track.courses = Course.find(array_of_ids)
    track.save
    UserTrack.create(track: track, user_id: session[:user_id])
    redirect_to track
  end


  def edit
    user   = User.find(session[:user_id])
    @track = Track.includes(:courses => :platform, :category => :courses).find(params[:id])
    @checked_courses = @track.courses
    hey = @checked_courses.map{|x| x.id}
    @all_courses     = @track.category.courses.where.not(id: hey) - @checked_courses
    unless user.tracks.include?(@track)
      redirect_to @track
    end
  end

  def edit_json
    render json: {courses: @all_courses, checked: @checked_courses}
  end

  def update
    track = Track.find(params[:id])
    track.update_attributes(name: params[:title], description: params[:description], order: params[:order])
    courses       = params[:order].split(",").to_a.map{|value, key| value.to_i }
    track.courses = Course.find(courses)
    track.save
    redirect_to track
  end

  def fork
    current_user = User.find_by(id: session[:user_id])
    if current_user && current_user.tracks.find_by(id: params[:track_id])== nil
      track = Track.includes(:courses).find(params[:track_id])
      new_track = track.fork
      track.popularity+=1
      track.save
      new_track.save
      UserTrack.create(user: current_user, track: new_track)
      redirect_to edit_track_path(new_track.id)
    else
      flash[:forked] = "You already forked this"
      redirect_to :back
    end

  end

  def follow
    if current_user.tracks.find_by(id: params[:track_id]) == nil
      track = Track.find(params[:track_id])
      track.popularity+=1
      track.save
      UserTrack.create(user_id: session[:user_id], track_id: track.id)
      redirect_to current_user
    else
      flash[:forked] = "You already followed this Course"
      redirect_to :back
    end
  end

  private
  def track_params
    params.permit(:category_id, :name, :order, :description)
  end



end