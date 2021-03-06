class ImagesController < ApplicationController
#  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :isadmin, except: [:index, :show]
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :set_client
  before_action :set_os_collection
  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



#   def server_order
#     productOrder = {
#       'virtualGuests' => [{
#          'hostname' => 'testRuby',
#          'domain'   => 'example.com',
# #         'primaryBackendNetworkComponent' => { 'networkVlan' => { 'id' => 1286783 } }
#       }],
#       'location' => 1555995,
#       'packageId' => 46,
#       'operatingSystemReferenceCode' => 'UBUNTU_16_64',
#       'useHourlyPricing' => true,
#       'prices' => [
#          {'id' => 1640 }, # 1 x 2.0 GHz Core
#          {'id' => 1644 }, # 1 GB RAM
#          {'id' => 171609 }, # CENTOS_6_64
#          {'id' => 2202 }, # 100 GB (SAN) First Disk
#          {'id' => 2255 }, # 100 GB (SAN) Second Disk
#          {'id' => 1800 }, # 250 GB Bandwidth
#          {'id' => 273 }, # 1 Gbps Public & Private Network Uplinks
#          {'id' => 21 }, # 1 IP Address
#          {'id' => 420 }, # Unlimited SSL VPN Users & 1 PPTP VPN User per account
#          {'id' => 56 }, # Host Ping and TCP Service Monitoring
#          {'id' => 57 }, # Email and Ticket
#          {'id' => 418 }, # NESSUS_VULNERABILITY_ASSESSMENT_REPORTING
#          {'id' => 905 }, # REBOOT_REMOTE_CONSOLE
#          {'id' => 58 }  # AUTOMATED_NOTIFICATION
#       ],
#       'imageTemplateId' => 1685169
#     }
#
#     @order = @softlayer_client['Product_Order'].placeOrder(productOrder)
#   end
#
#   def pricing
#
#     object_filter = SoftLayer::ObjectFilter.new
#     object_filter.set_criteria_for_key_path('items.prices.locationGroupId',
#     	'operation' => 'in',
#             'options' => [{
#             'name' => 'data',
#             'value' => 1555995
#             }])
#
#
#     location = @softlayer_client['SoftLayer_Product_Package']
#     @result = location.object_with_id(46).object_filter(object_filter).getItems
#
#   end
#

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      SoftLayer::Client.default_client = @softlayer_client = SoftLayer::Client.new(
        :username => current_user.ibm_id,             # enter your username here
            :api_key => current_user.ibm_key,   # enter your api key here
            :endpoint_URL => @API_PUBLIC_ENDPOINT
      )
    end
    def set_os_collection
      @operating_systems = {'UBUNTU_16_64 (minimal)' => 171609, 'UBUNTU_16.64 (LAMP)' => 175787,
                            'CENTOS 7 (minimal)' => 46466, 'CENTOS 7 (LAMP)' => 46456}
    end

    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:template_name, :image_type, :created_date, :account, :templateid, :os, :provision_script, :user_id)
    end

end
