require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require "./microservice.rb"
  end
end