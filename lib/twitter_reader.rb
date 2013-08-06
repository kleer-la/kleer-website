require 'oauth'
require 'json'

require File.join(File.dirname(__FILE__),'../lib/tweet')

class TwitterReader
	def initialize
		# Search for configuration in the usual keys storage
		@access_token = ENV['TWITTER_ACCESS_TOKEN']
		@access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
		@consumer_key = ENV['TWITTER_CONSUMER_KEY']
		@consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
		if @access_token.nil? or @access_token_secret.nil? or 
			@consumer_key.nil? or @consumer_secret.nil?
			raise 'Twitter API secrets incorrectly configured.'
		end
	end
	def last_tweet(screen_name)

		token = prepare_access_token(@access_token, @access_token_secret)

		# use the access token as an agent to get the home timeline
		response = token.request(:get, 
		  "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{screen_name}&trim_user=true&include_rts=true&count=1")

		tweets = JSON.parse(response.body)

		#puts tweets[0]["user"]

		return Tweet.new(tweets[0]['user']['id_str'], tweets[0]['text'])
	end

private

	# Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
	def prepare_access_token(oauth_token, oauth_token_secret)

	  consumer = OAuth::Consumer.new(@consumer_key, @consumer_secret, 
	    { :site => 'http://api.twitter.com', :scheme => :header })

	  token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }

	  access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

	  return access_token
	end
end