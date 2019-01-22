require "rubygems"
require "sinatra"
require "sinatra/activerecord"
require "json"
require 'sinatra/base'
require 'sinatra/param'
require_relative 'models/ad'

set :database, {adapter: "sqlite3", database: "ad.sqlite3"}
helpers Sinatra::Param
before do
  content_type 'application/json'
end
post '/add_ad' do
  param :address,  String, required: true , blank:false
  param :square,   Float, required: true , blank:false
  param :rooms,       Integer, required: true , blank:false
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