class CitiesController < ApplicationController
  before_action :set_city, only: %i[ show edit update destroy ]
  before_action :set_active_tab
  # GET /cities or /cities.json
  def index
    @cities = City.all
    puts("city: #{@cities.to_a}")
  end

  # GET /cities/1 or /cities/1.json
  def show
    render layout: 'page'
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities or /cities.json
  def create
    @city = City.new(city_params)
    @city.save

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(:new_city, partial: 'cities/index/plus_btn') +
                             turbo_stream.update(:cities_count, partial: 'cities/index/cities_count', locals: { count: City.all.count }) +
                             turbo_stream.append(:cities_list, partial: 'cities/index/city', locals: { city: @city })
      end

      format.html { redirect_to cities_path }
    end  
  end

  # PATCH/PUT /cities/1 or /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to city_url(@city), notice: "City was successfully updated." }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1 or /cities/1.json
  def destroy
    @city.destroy

    respond_to do |format|
      format.html { redirect_to cities_url, notice: "City was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def city_params
      params.require(:city).permit(:name)
    end

    def set_active_tab
      @active_tab = :cities
    end
end
