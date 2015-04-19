class Helper
	def self.new_from_json(json_string)
     self.new(JSON.parse(json_string)
  end
end