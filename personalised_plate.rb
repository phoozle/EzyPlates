class PersonalisedPlate
  LOOKUP_URL = 'http://www.transport.sa.gov.au/ezyplates.sa.gov.au/WebContent/ezyplate.php?plate_type=P&plate='.freeze

  def initialize(alphanumeric)
    if alphanumeric.length != 6
      raise "`#{alphanumeric}` is not 6 alphaumeric charactors with at least one number"
    end
    @alphanumeric = alphanumeric.upcase
  end

  def available?
    !lookup.include?('Number is not available')
  end

  def lookup
    open(LOOKUP_URL + @alphanumeric).read
  end
end
