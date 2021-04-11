# frozen_string_literal: true

# A ProductInfoHandler accepts input from (presumably) a bar code reader and sends the
# passed information to subscribed objects.
# Assumptions:
# * The passed catalog responds to #find_product_info_for
# * Subscribers respond to :update
#
class PointOfSale
  private attr_reader :catalog, :display

  def initialize(catalog, display = Display.new)
    @catalog = catalog
    @display = display
  end

  # The event handling method
  # To be called form other objects when a barcode is scanned somehow.
  # Will update the display
  #
  def on_barcode(barcode = nil)
    display.update message_for(barcode)
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
end
