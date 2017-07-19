json.extract! order, :id, :hostname, :domain, :location, :os, :usehourlypricing, :cpu, :ram, :first_disk, :second_disk, :bandwidth, :image_id, :created_at, :updated_at
json.url order_url(order, format: :json)
