class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :set_client

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

  def set_client
    SoftLayer::Client.default_client = @softlayer_client = SoftLayer::Client.new(
      :username => "c001220_skcc70253",             # enter your username here
          :api_key => "7d89165fd6d8fd259abfb7bba886ba00cb5428174c5e276cd595ed58091d3757",   # enter your api key here
          :endpoint_URL => @API_PUBLIC_ENDPOINT
    )
  end


  def order_template
    @order_template = {
    hostname: 'test_rails',
    domain: 'test001.sk.com',
    datacenter: 'seo01',
    cores: 1, # 2 x 2.0 GHz Cores
    memory: 1, # 4GB RAM
    private_network_only: false,
    dedicated_host_only: false,
    #os_reference_code: 'CENTOS_6_64', # CentOS 6.latest minimal (64 bit)
    image_template: SoftLayer::ImageTemplate.template_with_global_id('1682381'),
    use_local_disk: false, # Use a SAN disk
    hourly: true # Charge me for hourly use, rather than monthly.
    }
  end

  def order
    @order = SoftLayer::VirtualServerOrder.new
    @order_template.keys.each do |k|
    @order.send("#{k}=", @order_template[k])
    end
  end

  def order_page
    order_template
    order
    @options = create_object_options
    render "order_page"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:template_name, :image_type, :created_date, :account, :templateid)
    end
end
