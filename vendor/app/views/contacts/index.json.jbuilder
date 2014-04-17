json.array!(@contacts) do |contact|
  json.extract! contact, :id
  json.url contact_url(contact, format: :json)
end
