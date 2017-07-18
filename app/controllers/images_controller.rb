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
    datacenter: SoftLayer::Datacenter.datacenter_named('seo01'),
    cores: 1, # 2 x 2.0 GHz Cores
    memory: 1, # 4GB RAM
    private_network_only: false,
    dedicated_host_only: false,
    os_reference_code: 'UBUNTU_16_64', # CentOS 6.latest minimal (64 bit)
    image_template: SoftLayer::ImageTemplate.template_with_global_id('1685169'),
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
    # @core_options = core_options(client = nil)
    #
    # @disk_options = disk_options(client = nil)
    # @portspped_options = max_port_speed_options(client = nil)
    # @memory_options = memory_options(client = nil)
    # @os_options = os_reference_code_options(client = nil)

    @datacenter = SoftLayer::Datacenter.datacenter_named('seo01')
    order_template
    order

    render "order_page"
  end
  #
  # def create_object_options(client = nil)
  #   softlayer_client = @softlayer_client || Client.default_client
  #   raise "#{__method__} requires a client but none was given and Client::default_client is not set" if !softlayer_client
  #
  #   @@create_object_options ||= nil
  #   @@create_object_options = softlayer_client[:Virtual_Guest].getCreateObjectOptions() if !@@create_object_options
  #   @@create_object_options
  # end
  #
  # def core_options(client = nil)
  #   create_object_options(client)['processors'].collect { |processor_spec| processor_spec['template']['startCpus'] }.uniq.sort!
  # end
  #
  # def disk_options(client = nil)
  #   create_object_options(client)['blockDevices'].collect { |block_device_spec| block_device_spec['template']['blockDevices'][0]['diskImage']['capacity']}.uniq.sort!
  # end
  #
  # def max_port_speed_options(client = nil)
  #   create_object_options(client)['networkComponents'].collect { |component_spec| component_spec['template']['networkComponents'][0]['maxSpeed'] }
  # end
  #
  # def memory_options(client = nil)
  #   create_object_options(client)['memory'].collect { |memory_spec| memory_spec['template']['maxMemory'].to_i / 1024}.uniq.sort!
  # end
  #
  # def os_reference_code_options(client = nil)
  #   create_object_options(client)['operatingSystems'].collect { |os_spec| os_spec['template']['operatingSystemReferenceCode'] }.uniq.sort!
  # end

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
