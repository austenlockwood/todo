require "bundler/setup"
require "sinatra/base"
require "json"
require "pry"
require "./config/database"
Dir.glob("./app/models/*.rb").each { |file| require file }
