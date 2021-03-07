# frozen_string_literal: true

# A ProductInfoHandler accepts input from (presumably) a bar code reader and sends the
# passed information to subscribed objects.
# I assume at least one thing will subscribe to this: A service that uses the read product ID
# queries another service for more details product information… which is finally displayed
# on an LCD screen of sorts.
#
class ProductInfoHandler
  def on_barcode(read_barcode = nil)
    # code here
  end
end
