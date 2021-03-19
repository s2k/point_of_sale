# frozen_string_literal: true
#!env ruby

require_relative 'lib/product_information_service'
require_relative 'lib/point_of_sale'
require_relative 'lib/message_receiver'

pos = PointOfSale.new ProductInformationService.new
pos.subscribe MessageReceiver.new

while (scanned_code = gets) do
  pos.on_barcode scanned_code
end

puts "Bye."
