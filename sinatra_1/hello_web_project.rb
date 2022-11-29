# Request:
# GET /hello?name=Leo

# # Expected response (200 OK):
# Hello Leo
# require 'sinatra/base'

# class Application < Sinatra::Base
#   get "/hello" do
#     name = params[:name]

#     return "Hello #{name}"
#   end
# end
