# frozen_string_literal: true

require_relative 'spec_helper'

describe ProductInfoHandler do
  context 'initialisation' do
    it 'instantiates a product info handler' do
      expect { ProductInfoHandler.new }.not_to raise_exception
    end
  end

  context 'reacting to an incoming bar code' do
    before(:example) do
      @product_info_handler = ProductInfoHandler.new
    end
    it 'reacts to a bar code reading event' do
      expect { @product_info_handler.on_barcode('1234\n') }.to_not raise_exception
    end

    it 'can be called without an argument' do
      expect { @product_info_handler.on_barcode }.to_not raise_exception
    end
  end
end
