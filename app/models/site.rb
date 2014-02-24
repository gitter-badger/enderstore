class Site < ActiveRecord::Base
  attr_accessible :title, :content, :name, :url, :domain
  
end
