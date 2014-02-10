require 'rubygems'
require File.expand_path("../config/environment", __FILE__)

p File.expand_path("../config/environment", __FILE__)

# client = Twitter::REST::Client.new do |config|
#   config.consumer_key        = "PCC3YBsVP0XsfOz890LA4w"
#   config.consumer_secret     = "gcAIgIgvPwBAK4BdLz7jLOoTmP5iDFuLLDikMnR98"
#   config.access_token        = "83874145-bgA8phzcZDhdrL1MIUza21PwtbtrOsiV8LqtIzHQF"
#   config.access_token_secret = "iFrzRhdiUfUjJp9jx9Df23Hjy2ekTwLbxWzj6s7xOohgc"
# end

p @client.user("kevyeh")

@client.user.methods