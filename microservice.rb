require "rubygems"
require "sinatra"
require "sinatra/activerecord"
require "json"
require "faraday"
require 'sinatra/base'
require 'sinatra/param'
require_relative 'models/ad'
require_relative 'errors/WrongStatusFromExternalService'
set :port, 7777
set :database, {adapter: "sqlite3", database: "ad.sqlite3"}
set :show_exceptions, :after_handler
helpers Sinatra::Param
before do
  content_type 'application/json'
end
error Faraday::ConnectionFailed do
  {:message => env['sinatra.error'].message}.to_json
end
error WrongStatusFromExternalService do
  {:message => env['sinatra.error'].message}.to_json
end
get '/get_user' do
 profile_microservice = Faraday.new(:url=>'http://localhost:3228')
 result = profile_microservice.get('/get_users_info', params = {user_id: 1})
 if result.status != 200
   puts "WOOOOOOOOOOOOOOOOOOOOT #{result.body}"
   msg = JSON(result.body)['message']
   raise WrongStatusFromExternalService.new(msg,result.status)
 end
 result = JSON.parse(result)
 fulName = {:name =>result['first_name'],:surname =>result['last_name']}
 fulName.to_json
end
post '/add_ad' do
  param :address,  String, required: true , blank:false
  param :square,   Float, required: true , blank:false
  param :rooms,    Integer, required: true , blank:false
  param :type, String, in: ['house', 'flat', 'apartment', 'residance']
  newAd = Ad.new
  newAd.square = params['square']
  newAd.rooms = params['rooms']
  newAd.real_estate_type = params['type']
  newAd.address = params['address']
  create_handler(newAd,'new ad was successfully created')
end
def create_handler(model,message)
  result = {}
  if model.save!
    result[:status] = 'success'
    result[:message] = message
  else
    result[:status] = "failure"
    result[:message] = "something went wrong"
  end
  result.to_json
end