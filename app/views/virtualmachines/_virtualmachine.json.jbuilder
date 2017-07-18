json.extract! virtualmachine, :id, :datacenter, :price, :description, :created_at, :updated_at
json.url virtualmachine_url(virtualmachine, format: :json)
