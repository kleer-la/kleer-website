class Country
  attr_reader :iso_code, :name
  
  def initialize(iso_code, name)
  	@iso_code = iso_code
    @name = name
  end

  def ==(other_country)
    @iso_code == other_country.iso_code
  end
end