json.array!(@clients) do |client|
  json.id client.id
  json.id_number client.id_number
  json.name client.data(current_user.organization.id).name
  json.url client_url(client, format: :json)
end
