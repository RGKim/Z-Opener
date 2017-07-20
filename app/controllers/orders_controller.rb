class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
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
      'operatingSystemReferenceCode' => @image.os,
      'useHourlyPricing' => @order.usehourlypricing,
      'prices' => [
         {'id' => @order.cpu }, # 1 x 2.0 GHz Core
         {'id' => @order.ram }, # 1 GB RAM
         {'id' => @image.os }, # CENTOS_6_64
         {'id' => @order.first_disk }, # 100 GB (SAN) First Disk
         {'id' => @order.second_disk }, # 100 GB (SAN) Second Disk
         {'id' => 1800 }, # 0 GB Bandwidth
         {'id' => @order.uplink_port_speed }, # 1 Gbps Public & Private Network Uplinks
         {'id' => 21 }, # 1 IP Address
         {'id' => 420 }, # Unlimited SSL VPN Users & 1 PPTP VPN User per account
         {'id' => @order.monitoring }, # Host Ping and TCP Service Monitoring
         {'id' => 57 }, # Email and Ticket
         {'id' => 418 }, # NESSUS_VULNERABILITY_ASSESSMENT_REPORTING
         {'id' => 905 }, # REBOOT_REMOTE_CONSOLE
         {'id' => @order.response }  # AUTOMATED_NOTIFICATION
      ],
      'imageTemplateId' => @image.templateid,
      'provisionScripts' => [@image.provision_script]
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
      params.require(:order).permit(:hostname, :domain, :location, :usehourlypricing, :cpu, :ram, :first_disk,
      :second_disk, :bandwidth, :image_id, :uplink_port_speed, :monitoring, :response)
    end

    def set_collection
      @location = {'Amsterdam 1'=> 265592, 'Amsterdam 3' => 814994, 'Chennai 1' => 1004997, 'Dallas 5' => 138124, 'Dallas 6' => 154820,
                  'Dallas 9' => 449494, 'Dallas 10' => 1441195, 'Dallas 12' => 1854795, 'Dallas 13' => 1854895, 'Frankfrut 2' => 449506,
                  'Hong kong 2' => 352494 , 'Houston 2' => 142775, 'London 2' => 358694, 'London 4' => 2017395, 'Melbourne 1' => 449596,
                  'Milan 1' => 815394, 'Montreal 1' => 449610, 'Oslo 1' => 1541257, 'Paris 1' => 449500, 'San hose 1' => 168642,
                  'San hose 3' => 1004995, 'Sau Paulo 1' => 983497, 'Seattle 1' => 18171, 'Seoul 1' => 1555995, 'Singapore 1' => 224092,
                  'Sydney 1' => 449612, 'Sydney 4' => 2013295, 'Tokyo 1' => 449604, 'Toronto 1' => 448994, 'Washington 1' => 37473,
                  'Washington 4' => 957095, 'Washington 6' => 2017695, 'Washington 7' => 2017603}
      @operating_systems = {'UBUNTU_16_64 (minimal)' => 171609, 'UBUNTU_16.64 (LAMP)' => 175787,
                            'CENTOS 7 (minimal)' => 46466, 'CENTOS 7 (LAMP)' => 46456}
      @cpu_core = {'1 x 2.0 GHz Core' => 1640, '2 x 2.0 GHz Core' => 1641, '4 x 2.0 GHz Core' => 1642, '8 x 2.0 GHz Core' => 1643,
                    '12 x 2.0 GHz Core' => 2231, '16 x 2.0 GHz Core' => 2235}
      @ram = {'1 GB' => 1644, '2 GB' => 1645, '4 GB' => 1646, '6 GB' => 2238, '8 GB' => 1647, '12 GB' => 2243,
              '16 GB' => 1927, '32 GB' => 21275, '48 GB' => 22422, '64 GB' => 37042}
      @first_disk = {'25 GB (SAN)' => 2202, '100 GB (SAN)' => 1639, '25 GB (local)' => 13899, '100 GB (local)' => 13887}
      @second_disk = {'10 GB (SAN)' => 2255, '20 GB (SAN)' => 2256, '25 GB (SAN)' => 21861, '30 GB (SAN)' => 2257,
                      '40 GB (SAN)' => 2258, '50 GB (SAN)' => 2259, '75 GB (SAN)' => 2260, '100 GB (SAN)' => 2277,
                      '125 GB (SAN)' => 2261, '150 GB (SAN)' => 2262, '175 GB (SAN)' => 2263, '200 GB (SAN)' => 2264,
                      '250 GB (SAN)' => 2272, '300 GB (SAN)' => 2265, '350 GB (SAN)' => 2266, '400 GB (SAN)' => 2267,
                      '500 GB (SAN)' => 2270, '750 GB (SAN)' => 2278, '1.00 TB (SAN)' => 2279, '1.50 TB (SAN)' => 2280,
                      '2.00 TB (SAN)' => 2281, '25 GB (local)' => 21857, '100 GB (local)' => 13916, '150 GB (local)' => 14011,
                      '200 GB (local)' => 13897, '300 GB (local)' => 13898}
      @uplink_port_speed = {'10 Mbps Public & Private Network Uplinks' => 272, '100 Mbps Public & Private Network Uplinks' => 273,
                            '1 Gbps Public & Private Network Uplinks' => 274, '10 Mbps Private Network Uplink' => 897,
                            '100 Mbps Private Network Uplink' => 898, '1 Gbps Private Network Uplink' => 899}
      @monitoring = {'Host Ping' => 55, 'Host Ping and TCP Service Monitoring' => 56}
      @response = {'Automated Notification' => 58, 'Automated Reboot from Monitoring' => 59}
    end
end
