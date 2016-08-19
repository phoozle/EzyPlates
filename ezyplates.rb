#!/usr/bin/env ruby
require 'open-uri'
require 'pry'
require './plate_sequencer.rb'

print('Enter plate: ')
alphanumeric = gets.chomp.upcase

if alphanumeric.length < 6
  plate_sequencer = PlateSequencer.new(alphanumeric)
  available_plates = plate_sequencer.available
else
  plate = PersonalisedPlate.new(alphanumeric)
  available_plates = [alphanumeric] if plate.available?
end

if !available_plates.empty?
  puts 'Available Plates:'
  available_plates.each { |available_plate| puts "- #{available_plate}" }
else
  puts 'Sorry, no plates available'
end
