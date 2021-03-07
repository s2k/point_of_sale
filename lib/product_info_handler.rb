# frozen_string_literal: true

# A ProductInfoHandler accepts input from (presumably) a bar code reader and sends the
# passed information to subscribed objects.
# I assume at least one thing will subscribe to this: A service that uses the read product ID
# queries another service for more details product information... which is finally displayed
# on an LCD screen of sorts.
#
class ProductInfoHandler
  def initialize(product_info_service = nil)
    @product_information_service = product_info_service
  end

  def on_barcode(barcode = nil)
    if barcode.nil?
      puts 'WARN: No barcode given'
      return
    end
    if product_information_service.nil?
      puts 'WARN: No product info service is set up'
    else
      product_information_service.find_product_info_for(barcode.to_s.strip)
    end
    nil
  end

  private

  attr_reader :product_information_service
end
