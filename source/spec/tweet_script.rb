require 'rubygems'
require 'oauth'
require 'json'

#setting up environment variables
baseurl = "https://api.twitter.com"
path = "/1.1/statuses/user_timeline.json"
query = URI.encode_www_form('screen_name' => 'NathanFillion', 'count' => 10)
address = URI("#{baseurl}#{path}?#{query}")

consumer_key = OAuth::Consumer.new(
  "Vd9sZZ8Ocdjhtxb1rZMYQ",
  "ktn6tFsG5HKiIAEsUwtQLs4GEL4DtRTN0Yif5LZ28")
access_token = OAuth::Token.new(
  "1398484105-oYD0ylXRmGue693oEXhSrw5IHc9lXqPdklfPM3G",
  "1ANKN5ffqjLKwhysvI6KdGV8WWpVSTS4jnqWQb6rAkcJr")

def recent_tweets(tweets)
  tweets.each do |tweet|
    puts tweet["text"]
  end
end


#setup http
http = Net::HTTP.new address.host, address.port
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

#issue request
request = Net::HTTP::Get.new address.request_uri
request.oauth! http, consumer_key, access_token

http.start
response = http.request(request)
tweet = nil

# Calls recent_tweets to return most recent tweets
if response.code == '200' then
  tweets = JSON.parse(response.body)
  recent_tweets(tweets)
end



