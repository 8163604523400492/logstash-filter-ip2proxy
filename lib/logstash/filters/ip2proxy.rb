# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

require "logstash-filter-ip2proxy_jars"

class LogStash::Filters::IP2Proxy < LogStash::Filters::Base
  config_name "ip2proxy"

  # The path to the IP2Proxy.BIN database file which Logstash should use.
  # If not specified, this will default to the IP2PROXY-LITE-PX4.BIN database that embedded in the plugin.
  config :database, :validate => :path

  # The field containing the IP address.
  # If this field is an array, only the first value will be used.
  config :source, :validate => :string, :required => true

  # The field used to define iplocation as target.
  config :target, :validate => :string, :default => 'ip2proxy'

  public
  def register
    if @database.nil?
      @database = ::Dir.glob(::File.join(::File.expand_path("../../../vendor/", ::File.dirname(__FILE__)),"IP2PROXY-LITE-PX8.BIN")).first

      if @database.nil? || !File.exists?(@database)
        raise "You must specify 'database => ...' in your ip2proxy filter (I looked for '#{@database}')"
      end
    end

    @logger.info("Using ip2proxy database", :path => @database)
    
    @ip2proxyfilter = org.logstash.filters.IP2ProxyFilter.new(@source, @target, @database)
  end

  public
  def filter(event)
    return unless filter?(event)
    if @ip2proxyfilter.handleEvent(event)
      filter_matched(event)
    else
      tag_iplookup_unsuccessful(event)
    end
  end

  def tag_iplookup_unsuccessful(event)
    @logger.debug? && @logger.debug("IP #{event.get(@source)} was not found in the database", :event => event)
  end

end # class LogStash::Filters::IP2Proxy
