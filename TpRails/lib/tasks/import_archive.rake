require 'open-uri'
require 'zlib'
require 'yajl'
require 'mongoid'
require 'yaml'
require 'json'


namespace :import_archive do
	task :import do
		#YAML::ENGINE.yamler = 'syck'
		#Mongoid.load!(File.join('config', 'mongoid.yml'), :development)
		Archive.delete_all
		compteur = 1
 
		while (compteur < 23)
			archivePath = "http://data.githubarchive.org/2015-01-01-"+ compteur.to_s + ".json.gz"
			gz = open(archivePath)
        	js = Zlib::GzipReader.new(gz).read
        
	        Yajl::Parser.parse(js) do |event|
	          archive = Archive.new(JSON.parse(event.to_json))
	          archive.created_at = archive.created_at.to_date
	          archive.save
	        end 
		  	compteur += 1
		end

    	  
  	end
end
