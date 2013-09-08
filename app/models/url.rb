class Url < ActiveRecord::Base
  attr_accessible :frequency, :link, :topic, :article, :author, :title, :word_count, :date_published
  
  has_many :hashtags
end
