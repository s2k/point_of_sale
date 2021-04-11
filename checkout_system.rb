# frozen_string_literal: true
#!env ruby

require_relative 'lib/catalog'
require_relative 'lib/point_of_sale'
require_relative 'lib/display'

pos = PointOfSale.new Catalog.new
pos.subscribe Display.new

while (scanned_code = gets) do
  pos.on_barcode scanned_code
end

puts "Bye."
