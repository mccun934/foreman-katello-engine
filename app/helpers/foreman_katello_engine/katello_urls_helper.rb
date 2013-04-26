require 'uri'

module ForemanKatelloEngine::KatelloUrlsHelper
  
  def katello_url
    return Setting['katello_url']
  end
  
  def katello_host
    URI(katello_url).host unless katello_url.nil?
  end
  
  def katello_port
    URI(katello_url).port unless katello_url.nil?
  end
  
  def subscription_manager_configuration_url
    "http://#{katello_host}/pub/candlepin-cert-consumer-#{katello_host}-1.0-1.noarch.rpm"
  end
  
end