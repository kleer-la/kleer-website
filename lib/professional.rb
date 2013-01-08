class Professional
  
  attr_accessor :name, :bio, :linkedin_url, :gravatar_picture_url, :twitter_username, :last_tweet_url
  
  def initialize
    @name = ""
    @bio = ""
    @linkedin_url = ""
    @gravatar_picture_url = ""
    @twitter_username = ""
    @last_tweet_url = ""
  end
  
  def twitter_username= twitter_username
    @twitter_username = twitter_username
    
    plain_twitter_username = @twitter_username.gsub("@","")
    @last_tweet_url = "http://api.twitter.com/1/statuses/user_timeline.xml?screen_name=#{plain_twitter_username}&count=1"
  end  
  
  def last_tweet_text
    tweet_text = ""
    
    begin
      parser =  LibXML::XML::Parser.file( @last_tweet_url )
      doc = parser.parse
      loaded_tweets = doc.find('/statuses/status')
    
      loaded_tweets.each do |loaded_tweet|
        tweet_text = loaded_tweet.find_first('text').content
      end
    rescue
      tweet_text = ""
    end
    
    tweet_text.gsub /((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)/, %Q{<a href="\\1">\\1</a>}
  end
  
end