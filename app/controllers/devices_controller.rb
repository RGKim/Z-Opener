class DevicesController < ApplicationController
  before_action :set_client
  def index
  end


  private

  def set_client
    if user_signed_in?
    SoftLayer::Client.default_client = @softlayer_client = SoftLayer::Client.new(
      :username => current_user.ibm_id,             # enter your username here
          :api_key => current_user.ibm_key,   # enter your api key here
          :endpoint_URL => @API_PUBLIC_ENDPOINT
    )
    end
  end
end
