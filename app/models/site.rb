class Site < ActiveRecord::Base
  attr_accessible :title, :content, :name, :url, :domain

  #url MUST BE set to NULL in the database for each unclaimed subdomain.  Although an empty string works with sqlite3 (in development), the Postgresql is more particular
end
