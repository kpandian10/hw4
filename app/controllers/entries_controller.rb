class EntriesController < ApplicationController

  def new
    if session["user_id"] == nil
      flash["notice"] = "You must be logged in to add an entry."
      redirect_to "/login"
    else
      @place = Place.find_by({ "id" => params["place_id"] })
      if @place == nil
        flash["notice"] = "Place not found."
        redirect_to "/places"
      end
    end
  end


  def create
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    @entry["user_id"] = session["user_id"]
    @entry.save
    redirect_to "/places/#{@entry["place_id"]}"
  end

end
