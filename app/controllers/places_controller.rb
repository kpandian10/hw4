class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"]})
    if session["user_id"] != nil
      @entries = Entry.where({ "place_id" => @place["id"], "user_id" => session["user_id"] })
    else
      @entries = [] # No entries are shown if the user is not logged in
    end  
  end

  def new
    if session["user_id"] == nil
      flash["notice"] = "You must be logged in to add a new place."
      redirect_to "/login"
    end
  end

  def create
    if session["user_id"] == nil
      flash["notice"] = "You must be logged in to add a new place."
      redirect_to "/login"
    else
      @place = Place.new
      @place["name"] = params["name"]
      @place.save
      flash["notice"] = "Place created successfully."
      redirect_to "/places"
    end
  end
end
