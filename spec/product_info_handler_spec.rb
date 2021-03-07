# frozen_string_literal: true

require_relative 'spec_helper'

describe ProductInfoHandler do
  MAX_ID = 2**(0.size * 8)

  before(:example) do
    @product_info_service = instance_double('ProductInformationService')
    allow(@product_info_service).to receive :find_product_info_for
    @product_info_handler = ProductInfoHandler.new(@product_info_service)
  end

  context 'reacting to an incoming bar code' do
    it 'reacts to a bar code reading event' do
      expect { @product_info_handler.on_barcode('1234\n') }.to_not raise_exception
    end

    it 'can be called without an argument' do
      expect { @product_info_handler.on_barcode }.to_not raise_exception
    end

    it 'handles string and integer inputs' do
      expect { @product_info_handler.on_barcode rand(MAX_ID) }.to_not raise_exception
    end
  end

  context 'getting product information (price in particular) from … elsewhere' do
    it 'Again: It can be instantiated' do
      expect(@product_info_service).to receive(:find_product_info_for).with('47856').and_return( { id: '47856', name: 'Thingy', price: 47.11 } )
      expect(@product_info_handler.on_barcode("47856\n")).to be_nil
    end
  end
end
