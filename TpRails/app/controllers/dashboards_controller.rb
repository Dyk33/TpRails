require 'open-uri'
require 'zlib'
require 'yajl'

class DashboardsController < ApplicationController
	def index
    	@dashboards = Dashboard.all
  	end

	def show
		@dashboard = Dashboard.find(params[:id])

		archiveDate = @dashboard.dateArchive.strftime("%Y-%m-%d")
  		archivePath = "http://data.githubarchive.org/"+ archiveDate +"-12.json.gz"

  		gz = open(archivePath)
		js = Zlib::GzipReader.new(gz).read
 		
 		#Recalcul des données vu que bdd limitée
 		#Afficher les données dans un tableau à la place du print : Créer un tableau dans la vue SHOW.html.erb
		#Yajl::Parser.parse(js) do |event|
			#print event
		#end 

	end

	#Get
	def new
  	end

  	#Post
  	def create
  		@dashboard =Dashboard.new(params.require(:dashboard).permit(:title, :dateArchive))

  		archiveDate = @dashboard.dateArchive.strftime("%Y-%m-%d")
  		if(Date.new(2012,10,12) < @dashboard.dateArchive &&  @dashboard.dateArchive < Date.today)
  			@dashboard.save
  		end	
  		
		redirect_to @dashboard 
   	end

   	def destroy
    	@dashboard = Dashboard.find(params[:id])
    	@dashboard.destroy
 
    	redirect_to dashboards_path
  end
end
