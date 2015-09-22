class LocationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def correct_user
      @location = current_user.locations.find_by(id: params[:id])
      redirect_to root_url if @location.nil?
    end


end
