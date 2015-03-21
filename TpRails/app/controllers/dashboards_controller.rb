require 'open-uri'
require 'zlib'
require 'yajl'

class DashboardsController < ApplicationController
	def index
    	@dashboard = Dashboard.all
  	end

	def show
		@dashboard = Dashboard.find(params[:id])
	end

	#Get
	def new
  	end

  	#Post
  	def create
  		@dashboard =Dashboard.new(params.require(:dashboard).permit(:title, :dateArchive))
  		print @dashboard
  		@dashboard.save

		gz = open('http://data.githubarchive.org/2015-01-01-12.json.gz')
		js = Zlib::GzipReader.new(gz).read
 
		Yajl::Parser.parse(js) do |event|
			print event
		end 
		redirect_to @dashboard
  
   	end
end
