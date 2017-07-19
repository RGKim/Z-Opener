class OrdersController < ApplicationController
  before_action :set_image
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = @image.present? ? @image.orders.all : Image.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = @image.present? ? @image.orders.new : Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = @image.present? ? @image.orders.new(order_params) : Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to (@image.present? ? [@post.image, @order] : @order), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to (@image.present? ? [@order.image, @order] : @order), notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to (@image.present? ? image_order_url : orderss_url), notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:image_id]) if params[:image_id].present?
    end

    def set_order
      if @image.present?
        @order = @image.orders.find(params[:id])
      else
        @order = Order.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:hostname, :domain, :location, :os, :usehourlypricing, :cpu, :ram, :first_disk, :second_disk, :bandwidth, :image_id)
    end

end
