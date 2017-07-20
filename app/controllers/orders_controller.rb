class OrdersController < ApplicationController
  before_action :set_image
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_collection, only: [:new]
  before_action :set_client

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

#    respond_to do |format|
      if @order.save
#        format.html { redirect_to (@image.present? ? [@order.image, @order] : @order), notice: 'Order was successfully created.' }
#        format.json { render :show, status: :created, location: @order }
        redirect_to devices_url
        server_order
#      else
#        format.html { render :new }
#        format.json { render json: @order.errors, status: :unprocessable_entity }
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
#    respond_to do |format|
    redirect_to image_orders_url
#      format.html { redirect_to (@image.present? ? image_order_url : orders_url), notice: 'Order was successfully destroyed.' }
#      format.json { head :no_content }
#    end
  end

  def set_client
    SoftLayer::Client.default_client = @softlayer_client = SoftLayer::Client.new(
      :username => "c001220_skcc70253",             # enter your username here
          :api_key => "7d89165fd6d8fd259abfb7bba886ba00cb5428174c5e276cd595ed58091d3757",   # enter your api key here
          :endpoint_URL => @API_PUBLIC_ENDPOINT
    )
  end

  def server_order
    productOrder = {
      'virtualGuests' => [{
         'hostname' => @order.hostname,
         'domain'   => @order.domain,
#         'primaryBackendNetworkComponent' => { 'networkVlan' => { 'id' => 1286783 } }
      }],
      'location' => @order.location,
      'packageId' => 46,
      'operatingSystemReferenceCode' => @order.os,
      'useHourlyPricing' => @order.usehourlypricing,
      'prices' => [
         {'id' => @order.cpu }, # 1 x 2.0 GHz Core
         {'id' => @order.ram }, # 1 GB RAM
         {'id' => @order.os }, # CENTOS_6_64
         {'id' => @order.first_disk }, # 100 GB (SAN) First Disk
         {'id' => @order.second_disk }, # 100 GB (SAN) Second Disk
         {'id' => @order.bandwidth }, # 250 GB Bandwidth
         {'id' => 273 }, # 1 Gbps Public & Private Network Uplinks
         {'id' => 21 }, # 1 IP Address
         {'id' => 420 }, # Unlimited SSL VPN Users & 1 PPTP VPN User per account
         {'id' => 56 }, # Host Ping and TCP Service Monitoring
         {'id' => 57 }, # Email and Ticket
         {'id' => 418 }, # NESSUS_VULNERABILITY_ASSESSMENT_REPORTING
         {'id' => 905 }, # REBOOT_REMOTE_CONSOLE
         {'id' => 58 }  # AUTOMATED_NOTIFICATION
      ],
      'imageTemplateId' => @image.templateid,
      #'provisionScripts' => ['https://raw.githubusercontent.com/neuron03/provision/master/redmine_provision.sh']
    }

    @order = @softlayer_client['Product_Order'].placeOrder(productOrder)
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

    def set_collection
      @OperatingSystems = {'UBUNTU_16_64' => 171609}
    end
end
