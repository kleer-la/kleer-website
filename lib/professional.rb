class Professional
  
  attr_accessor :name, :bio, :linkedin_url, :gravatar_picture_url, :twitter_username, :id,
  				:average_rating, :net_promoter_score, :surveyed_count, :promoter_count
  
  def initialize  xml=nil, lang="es"
    bio_tag = lang=="en" ? "bio_en" : "bio" 

    if xml.nil?
      @id = ""
      @name = ""
      @bio = ""
      @linkedin_url = ""
      @gravatar_picture_url = ""
      @twitter_username = ""
    else
      @id = first_content(xml, "id").to_i
      @name = xml.find_first('name').content
      @bio = first_content(xml, bio_tag)
      @linkedin_url = xml.find_first('linkedin-url').content
      @gravatar_picture_url = xml.find_first('gravatar-picture-url').content
      @twitter_username = xml.find_first('twitter-username').content

    end

    @average_rating = 0.0
    @net_promoter_score = 0
    @surveyed_count = 0
    @promoter_count = 0
  end
  
end