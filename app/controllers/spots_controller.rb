class SpotsController < ApplicationController
  def index
    @spots = Spot.all.includes(:user).order(created_at: :desc)
  end
end
