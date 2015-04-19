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
		
		compteur = 1
 
		while (compteur < 23)
			archivePath = "http://data.githubarchive.org/2015-01-01-"+ compteur.to_s + ".json.gz"
			gz = open(archivePath)
        	js = Zlib::GzipReader.new(gz).read
        
	        Yajl::Parser.parse(js) do |event|
	          Archive.create(JSON.parse(event.to_json))
	          Archive.save
	        end 
		  	compteur += 1
		end

    	  
  	end
end
