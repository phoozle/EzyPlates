class PersonalisedPlate
  LOOKUP_URL = 'http://www.transport.sa.gov.au/ezyplates.sa.gov.au/WebContent/ezyplate.php?plate_type=P&plate='.freeze

  def initialize(alphanumeric)
    @alphanumeric = alphanumeric.upcase
    validate
  end

  def available?
    !lookup.include?('Number is not available')
  end

  def lookup
    open(LOOKUP_URL + @alphanumeric).read
  end

  private

  def validate
    if @alphanumeric.length != 6
      raise "`#{@alphanumeric}` is not 6 alphaumeric charactors with at least one number"
    end

    unless @alphanumeric[0] =~ /[a-zA-Z]/
      raise "`#{@alphanumeric}` must begin with a letter"
    end
  end
end
