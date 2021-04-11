# frozen_string_literal: true

# A ProductInfoHandler accepts input from (presumably) a bar code reader and sends the
# passed information to subscribed objects.
# Assumptions:
# * The passed catalog responds to #find_product_info_for
# * Subscribers respond to :update
#
class PointOfSale
  def initialize(catalog)
    @catalog = catalog
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
    message = message_for(barcode)
    subscribers.each { |s| s.update(message) }
    nil
  end

  private

  def message_for(barcode)
    if barcode.nil?
      'WARN: No barcode given'
    elsif catalog.nil?
      'WARN: No product info service is set up'
    else
      catalog.find_product_info_for(barcode.to_s.strip)
    end
  end

  attr_reader :catalog, :subscribers
end
