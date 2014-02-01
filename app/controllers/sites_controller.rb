class SitesController < ApplicationController
  
   before_filter :check_privileges!, only: [:new, :create, :edit, :save]
  
  def index
    @sites = Site.find(:all)
  end

  def show
    subdomain = request.subdomain
      if /^(\w+)\./.match(subdomain)
        subdomain = (/^(\w+)\./.match(subdomain))[1] #if Rails.env.development? #nitrous development preview includes a multi-segment subdomain
        @current_site = Site.find_by_name(subdomain.downcase)
        puts @current_site
      end
throw "HALT" if @current_site.nil?
    redirect_to action: 'index', status: 303 if @current_site.nil?
  end
  
  def create
  end
  
  def update
  end
  
  def delete
  end
  
  private
  def check_privileges!
    redirect_to "/", notice: 'You dont have enough permissions to be here' unless admin_user
  end
end
