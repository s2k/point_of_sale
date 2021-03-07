# frozen_string_literal: true

# A ProductInfoHandler accepts input from (presumably) a bar code reader and sends the
# passed information to subscribed objects.
# Assumptions:
# * The passed product_info_service responds to #find_product_info_for
# * Subscribers respond to :update
#
class ProductInfoHandler
  def initialize(product_info_service)
    @product_information_service = product_info_service
    @subscribers = []
  end

  def subscribe(client)
    @subscribers << client
  end

  # The event handling method
  # To be called form other objects when a barcode is scanned somehow.
  # Will notify subscribed objects with a text message (typically product information and p price).
  #
  def on_barcode(barcode = nil)
    if barcode.nil?
      puts 'WARN: No barcode given'
      return
    end
    if product_information_service.nil?
      message = 'WARN: No product info service is set up'
    else
      message = product_information_service.find_product_info_for(barcode.to_s.strip)
    end
    subscribers.each { |s| s.update message }
    nil
  end

  private

  attr_reader :product_information_service, :subscribers
end
