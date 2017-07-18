json.extract! device, :id, :domain, :type, :public_ip, :private_ip, :region, :state, :order_date, :created_at, :updated_at
json.url device_url(device, format: :json)
