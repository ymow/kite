# app/controllers/admin/places_controller.rb
module Admin
  class PlacesController < Admin::BaseController
    before_action :set_place, only: [:show, :edit, :update, :destroy]

    def index
      @places = Place.all
    end

    def show
    end

    def new
      @place = Place.new
    end

    def create
      @place = Place.new(place_params)
      if @place.save
        redirect_to admin_place_path(@place), notice: 'Place was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @place.update(place_params)
        redirect_to admin_place_path(@place), notice: 'Place was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @place.destroy
      redirect_to admin_places_path, notice: 'Place was successfully deleted.'
    end

    private

    def set_place
      @place = Place.find(params[:id])
    end

    def place_params
      params.require(:place).permit(:name, :address, :city, :state, :country, :postal_code, :latitude, :longitude, :category, :description, :phone_number, :website, :hours_of_operation, :rating, :reviews_count)
    end
  end
end
