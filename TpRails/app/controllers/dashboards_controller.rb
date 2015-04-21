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

		#datetime = DateTime.strptime(@dashboard.dateArchive, '%m/%d/%Y %H:%M')
    #datetime.hour # => 21

	end

	#Get
	def new
  	end

  	#Post
  	def create
  		@dashboard =Dashboard.new(params.require(:dashboard).permit(:title, :dateArchive))
      archiveHour = Integer(@dashboard.dateArchive)
  		#archiveDate = @dashboard.dateArchive.strftime("%Y-%m-%d")
  		if(00 < archiveHour &&  archiveHour < 23)
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
