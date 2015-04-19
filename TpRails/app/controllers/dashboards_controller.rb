require 'open-uri'
require 'zlib'
require 'yajl'

class DashboardsController < ApplicationController
	def index
    	@dashboards = Dashboard.all
  	end

	def show
		@dashboard = Dashboard.find(params[:id])

    # Recupération des archives correspondantes au dashboard + Affichage en graph
		

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
        archiveDate = @dashboard.dateArchive.strftime("%Y-%m-%d")
        archivePath = "http://data.githubarchive.org/"+ archiveDate +"-12.json.gz"

        gz = open(archivePath)
        js = Zlib::GzipReader.new(gz).read
        
        #Recalcul des données vu que bdd limitée
        #Sauvegarde des archives calculées dans la base mongolab
        
        #Yajl::Parser.parse(js) do |event|
          #print event
        #end       
  		end	

  		redirect_to @dashboard 
   	end

   	def destroy
    	@dashboard = Dashboard.find(params[:id])
    	@dashboard.destroy
 
    	redirect_to dashboards_path
  end
end
