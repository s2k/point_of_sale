# frozen_string_literal: true

require_relative 'spec_helper'

describe ProductInformationService do
  it 'can be instantiated' do
    expect { ProductInformationService.new }.not_to raise_exception
  end

  it 'returns a message when queried for unknown product' do
    expect(subject.find_product_info_for :not_a_product_code).to eq 'Product not found'
  end

  it 'returns a formatted string with product info for found products' do
    existing_product = '549876'
    expect(subject.find_product_info_for existing_product).to eq "Product: Shiny New Thingy\nPrice: 42.42"
  end
end
