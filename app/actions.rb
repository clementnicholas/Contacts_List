# Homepage (Root path)
get '/contacts' do
  contacts = Contact.all
  contacts.to_json
end

get '/' do
  erb :index
end

post '/contacts' do
  contact = Contact.create(firstname: params[:firstname], lastname: params[:lastname], email: params[:email])
  halt 200, {'Content-Type' => 'application/json'}, contact.to_json
end

delete '/contacts/:id' do |id|
  contact = Contact.find(params[:id])
  contact.destroy
end

get '/contacts/:id' do |id|
  contact = Contact.find(params[:id])
  contact.to_json
end

put '/contacts/:id' do |id|
  contact = Contact.find(params[:id]).update(firstname: params[:firstname], lastname: params[:lastname], email: params[:email])
  halt 200, {'Content-Type' => 'application/json'}, contact.to_json
end