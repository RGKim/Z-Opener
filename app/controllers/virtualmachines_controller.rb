class VirtualmachinesController < ApplicationController
  before_action :set_virtualmachine, only: [:show, :edit, :update, :destroy]

  # GET /virtualmachines
  # GET /virtualmachines.json
  def index
    @virtualmachines = Virtualmachine.all
  end

  # GET /virtualmachines/1
  # GET /virtualmachines/1.json
  def show
  end

  # GET /virtualmachines/new
  def new
    @virtualmachine = Virtualmachine.new
  end

  # GET /virtualmachines/1/edit
  def edit
  end

  # POST /virtualmachines
  # POST /virtualmachines.json
  def create
    @virtualmachine = Virtualmachine.new(virtualmachine_params)

    respond_to do |format|
      if @virtualmachine.save
        format.html { redirect_to @virtualmachine, notice: 'Virtualmachine was successfully created.' }
        format.json { render :show, status: :created, location: @virtualmachine }
      else
        format.html { render :new }
        format.json { render json: @virtualmachine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /virtualmachines/1
  # PATCH/PUT /virtualmachines/1.json
  def update
    respond_to do |format|
      if @virtualmachine.update(virtualmachine_params)
        format.html { redirect_to @virtualmachine, notice: 'Virtualmachine was successfully updated.' }
        format.json { render :show, status: :ok, location: @virtualmachine }
      else
        format.html { render :edit }
        format.json { render json: @virtualmachine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /virtualmachines/1
  # DELETE /virtualmachines/1.json
  def destroy
    @virtualmachine.destroy
    respond_to do |format|
      format.html { redirect_to virtualmachines_url, notice: 'Virtualmachine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_virtualmachine
      @virtualmachine = Virtualmachine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def virtualmachine_params
      params.require(:virtualmachine).permit(:datacenter, :price, :description)
    end
end
