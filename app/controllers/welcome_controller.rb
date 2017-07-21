class WelcomeController < ApplicationController
before_action :set_client
before_action :server_order
  def index
  end

  def server_order
    productOrder = {
      'virtualGuests' => [{
         'hostname' => 'testRuby',
         'domain'   => 'example.com',
#         'primaryBackendNetworkComponent' => { 'networkVlan' => { 'id' => 1286783 } }
      }],
      'location' => 1555995,
      'packageId' => 46,
      'operatingSystemReferenceCode' => 'UBUNTU_16_64',
      'useHourlyPricing' => true,
      'prices' => [
         {'id' => 164000 }, # 1 x 2.0 GHz Core
         {'id' => 1644 }, # 1 GB RAM
         {'id' => 171609 }, # CENTOS_6_64
         {'id' => 2202 }, # 100 GB (SAN) First Disk
         {'id' => 2255 }, # 100 GB (SAN) Second Disk
         {'id' => 1800 }, # 250 GB Bandwidth
         {'id' => 273 }, # 1 Gbps Public & Private Network Uplinks
         {'id' => 21 }, # 1 IP Address
         {'id' => 420 }, # Unlimited SSL VPN Users & 1 PPTP VPN User per account
         {'id' => 56 }, # Host Ping and TCP Service Monitoring
         {'id' => 57 }, # Email and Ticket
         {'id' => 418 }, # NESSUS_VULNERABILITY_ASSESSMENT_REPORTING
         {'id' => 905 }, # REBOOT_REMOTE_CONSOLE
         {'id' => 58 }  # AUTOMATED_NOTIFICATION
      ],
      'imageTemplateId' => 1685169
    }
    begin
      @order = @softlayer_client['Product_Order'].verifyOrder(productOrder)
    rescue => exception
      flash[:alert] = "다음과 같은 이유로 인해 상품 주문이 완료되지 못 하였습니다. #{exception}"
    end
    # begin
    #     # exception일수도 있고 아닐수도 있는 코드
    #   rescue SomeExceptionClass => some_variable
    #     # 어떤 excpetion을 처리하는 코드
    #   rescue SomeOtherException => some_other_variable
    #     # 또 다른 excpetion을 처리하는 코드
    #   else
    #     # exception이 raise되지 않은 경우 실행할 코드
    #   ensure
    #     # exception이 있던 없던 무조건 실행될 코드
    # end
  end

  def pricing

    object_filter = SoftLayer::ObjectFilter.new
    object_filter.set_criteria_for_key_path('items.prices.locationGroupId',
    	'operation' => 'in',
            'options' => [{
            'name' => 'data',
            'value' => 1555995
            }])


    location = @softlayer_client['SoftLayer_Product_Package']
    @result = location.object_with_id(46).object_filter(object_filter).getItems

  end

private

  def set_client
    SoftLayer::Client.default_client = @softlayer_client = SoftLayer::Client.new(
      :username => current_user.ibm_id,             # enter your username here
          :api_key => current_user.ibm_key,   # enter your api key here
          :endpoint_URL => @API_PUBLIC_ENDPOINT
    )
  end

end
