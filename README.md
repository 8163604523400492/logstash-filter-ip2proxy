# IP2Proxy Filter Plugin
This is IP2Proxy filter plugin for Logstash that enables Logstash's users to query an IP address if it was being used as open proxy, web proxy, VPN anonymizer and TOR exits. It also appends country, state, city and ISP information of the server. The library took the proxy IP address from **IP2Proxy BIN Data** file.

For the methods to use IP2Proxy filter plugin with Elastic Stack (Elasticsearch, Filebeat, Logstash, and Kibana), please take a look on this [tutorial](https://www.ip2location.com/tutorials/how-to-use-ip2proxy-filter-plugin-with-elastic-stack).


## Dependencies (IP2PROXY BIN DATA FILE)
This plugin requires IP2Proxy BIN data file to function. You may download the BIN data file at
* IP2Proxy LITE BIN Data (Free): https://lite.ip2location.com
* IP2Proxy Commercial BIN Data (Commercial): https://www.ip2location.com


## Installation
Install this plugin by the following code:
```
bin/logstash-plugin install logstash-filter-ip2proxy
```


## Config File Example
```
input {
  beats {
    port => "5043"
  }
}

filter {
  grok {
    match => { "message" => "%{COMBINEDAPACHELOG}"}
  }
  ip2proxy {
    source => "clientip"
  }
}

output {
  elasticsearch {
    hosts => [ "localhost:9200" ]
  }
}
```


## IP2Proxy Filter Configuration
|Setting|Input type|Required|
|---|---|---|
|source|string|Yes|
|database|a valid filesystem path|No|

* **source** field is a required setting that containing the IP address or hostname to get the ip information.
* **database** field is an optional setting that containing the path to the IP2Proxy BIN database file.


## Sample Output
|Field|Description|
|---|---|
|ip2proxy.city|the city name of the proxy|
|ip2proxy.country_long|the ISO3166-1 country name of the proxy|
|ip2proxy.country_short|the ISO3166-1 country code (two-characters) of the proxy|
|ip2proxy.is_proxy|Check whether if an IP address was a proxy. Returned value:<ul><li>-1 : errors</li><li>0 : not a proxy</li><li>1 : a proxy</li><li>2 : a data center IP address</li></ul>|
|ip2proxy.isp|the ISP name of the proxy|
|ip2proxy.proxy_type|the proxy type. Please visit <a href="https://www.ip2location.com/databases/px4-ip-proxytype-country-region-city-isp" target="_blank">IP2Location</a> for the list of proxy types supported|
|ip2proxy.region|the ISO3166-2 region name of the proxy|

![Example of data](https://www.ip2location.com/images/tutorial/logstash-filter-ip2proxy-screenshot.png)


## Support
Email: support@ip2location.com

URL: [https://www.ip2location.com](https://www.ip2location.com)
