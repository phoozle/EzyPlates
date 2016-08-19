require './personalised_plate.rb'

class PlateSequencer
  def initialize(alphanumeric)
    @alphanumeric = alphanumeric
    # Validate alphamumeric is usable and in a correct format
    validate
  end

  def available
    available = sequencable_range.map do |number|
      # ABC001, ABC002, etc
      alphanumeric = @alphanumeric + format("%0#{available_digits}d", number)

      plate = PersonalisedPlate.new(alphanumeric)
      plate.available? ? alphanumeric : nil
    end

    # Return available plates, removes nils
    available.compact
  end

  def sequencable_range
    # Work out what is to be sequenced
    # E.g. "CAR": CARxxx -> CAR001, CAR002, ..., CAR999
    max = (10**available_digits) - 1
    0..max
  end

  def available_digits
    @availble_digits ||= 6 - @alphanumeric.length
  end

  private

  def validate
    if @alphanumeric.length > 6
      raise 'You specified too many charactors, must be 6 or less'
    end

    # If all 6 charactors are specified and last mumber is not a digit
    if @alphanumeric.length == 6 && !@alphanumeric.last.match(/\d/)
      raise 'Last charactor must be a numerical digit - e.g. MYCAR1'
    end
  end
end
