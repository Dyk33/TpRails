class Dashboard
  include Mongoid::Document
  field :title, type: String
  field :dateArchive, type: Time
end
