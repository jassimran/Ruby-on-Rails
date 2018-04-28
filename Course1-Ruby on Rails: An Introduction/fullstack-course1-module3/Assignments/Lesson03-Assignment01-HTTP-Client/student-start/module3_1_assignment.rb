require 'httparty'
require 'pp'

class Recipe
	include HTTParty
	base_uri 'http://food2fork.com/api'
	default_params key: "72fd644a34f5c3ce725420c9c7de7f9a"
	format :json

	def self.for term
		get("/search", query:{q:term})["recipes"]
	end


end
