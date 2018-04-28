require 'httparty'
require 'pp'

class Recipe
  include HTTParty
  hostport= ENV['FOOD2FORK_SERVER_AND_PORT'] || 'www.food2fork.com'
  default_params key: ENV['FOOD2FORK_KEY']
  base_uri "http://#{hostport}/api"
  format :json

  #72fd644a34f5c3ce725420c9c7de7f9a

	def self.for term
		get("/search", query:{q:term})["recipes"]
	end
end
