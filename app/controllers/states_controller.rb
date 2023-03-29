class StatesController < ApplicationController
  before_action :set_state, only: %i[ show edit update destroy ]
  before_action :set_active_tab
  # GET /states or /states.json
  def index
    @states = State.all
  end

  # GET /states/1 or /states/1.json
  def show
    render layout: 'page'
  end

  # GET /states/new
  def new
    @state = State.new
  end

  # GET /states/1/edit
  def edit
  end

  # POST /states or /states.json
  def create
    @state = State.new(state_params)
    @state.save

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(:new_state, partial: 'states/index/plus_btn') +
                             turbo_stream.update(:states_count, partial: 'states/index/count', locals: { count: State.all.count }) +
                             turbo_stream.append(:states_list, partial: 'states/index/state', locals: { state: @state })
      end

      format.html { redirect_to states_path }
    end 
  end

  # PATCH/PUT /states/1 or /states/1.json
  def update
    respond_to do |format|
      if @state.update(state_params)
        format.html { redirect_to state_url(@state), notice: "State was successfully updated." }
        format.json { render :show, status: :ok, location: @state }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1 or /states/1.json
  def destroy
    @state.destroy

    respond_to do |format|
      format.html { redirect_to states_url, notice: "State was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def state_params
      params.require(:state).permit(:name)
    end

    def set_active_tab
      @active_tab = :states
    end
end
