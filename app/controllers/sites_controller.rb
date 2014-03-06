class SitesController < ApplicationController
  
  NITROUS_SUBDOMAIN = "nospeed-4917.use1"
  TEST_DOMAIN = "enderstore.com"
  
  # before_filter :check_privileges!, only: [:new, :create, :edit, :save]
  
  def index
    @domain = request.domain
    test_domain_setup
    @all_domains = Site.uniq.pluck(:domain)
    @sites = Site.find_all_by_domain(@domain)
    @avail_sites = Site.find(:all, :conditions => {:domain => @domain, :url => nil })
    @claimed_sites = Site.where("domain = '#{@domain}'").where("url <> ''")
  end

  def show
    @domain = request.domain
    @subdomain = request.subdomain
    
    test_domain_setup
    
    if /^(\w+)\./.match(@subdomain)
      @subdomain = (/^(\w+)\./.match(@subdomain))[1] 
    end
    @current_site = Site.find_by_domain_and_name(@domain.downcase, @subdomain.downcase)
    if @current_site.nil?
      redirect_to action: 'index', status: 303
    else
      redirect_to @current_site.url} unless @current_site.url.nil?
    end
  end
  
  def create
    @site = Site.find_by_id(params[:id])
  end
  
  def update
  end
  
  def delete
  end
  
  def call_domain
    domain = params[:domain].gsub(/^http(s?)\/\/\:/, '')
    redirect_to "http://#{domain}"
  end
  
  private
  
  #Preview on Nitrous box requires some 'manipulation' of the domain/subdomain
  def test_domain_setup
    if Rails.env.development?
      @domain = TEST_DOMAIN
      @subdomain = (request.subdomain).gsub(NITROUS_SUBDOMAIN, '')
    end
  end
  
  def check_privileges!
    redirect_to "/", notice: 'You dont have enough permissions to be here' unless admin_user
  end
end
