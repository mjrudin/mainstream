class Hashtag < ActiveRecord::Base
  attr_accessible :tag, :url_id
  
  belongs_to :url 
end
