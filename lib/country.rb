class Country
  attr_reader :iso_code, :name
  
  def initialize(iso_code, name)
  	@iso_code = iso_code
    @name = name
  end

  def ==(other_country)
    @name == other_country.name
  end

  # FIXME: Online debe quedar en ultimo lugar
  def <=>(other_country)
	return -1 if ((@name < other_country.name) or (other_country.name == "Online"))
	return  0 if (@name == other_country.name)
	return  1 if ((@name > other_country.name) or (@name == "Online"))
  end
end