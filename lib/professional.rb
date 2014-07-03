class Professional
  
  attr_accessor :name, :bio, :linkedin_url, :gravatar_picture_url, :twitter_username, :id,
  				:average_rating, :net_promoter_score, :surveyed_count, :promoter_count
  
  def initialize
    @name = ""
    @bio = ""
    @linkedin_url = ""
    @gravatar_picture_url = ""
    @twitter_username = ""
    @id = ""

    @average_rating = 0.0
    @net_promoter_score = 0
    @surveyed_count = 0
    @promoter_count = 0
  end
  
end