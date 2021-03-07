# frozen_string_literal: true

# Can retrieve product info from _some_ source.
# It's unclear where this info comes from yet.
# Therefore: return a hard coded response, since _for now_ only one product is sold.
# Decide later if/how to deal with more than one product
#
# As the only convenience: In case the product is not fount return the string 'Product not found', since
# it's unclear if/how reliably the product IDs are the Service will receive
#
class ProductInformationService
  PRODUCTS = {
    '549876' => {
      name: 'Shiny New Thingy',
      price: 42.42
    }
  }.freeze

  def find_product_info_for product_code
    format_product_info PRODUCTS[product_code]
  end

  def format_product_info product
    product.nil? ? 'Product not found' : "Product: #{product.fetch(:name)}\nPrice: #{'%2.2f' % product.fetch(:price)}"
  end
end
