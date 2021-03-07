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
      expect(@product_info_service).to receive(:find_product_info_for).with('47856').and_return( "Product: Thingy\nPrice: 47.11" )
      expect(@product_info_handler.on_barcode("47856\n")).to be_nil
    end
  end

  context 'accepts clients to subscribe and sends updates' do
    before(:each) do
      @subscriber = instance_double('Subscriber')
      allow(@subscriber).to receive :update
    end

    it 'Accepts subscriber' do
      expect{@product_info_handler.subscribe @subscriber}.to_not raise_exception
    end

    it 'Notifies subscriber when a barcode events happens' do
      expect(@product_info_service).to receive(:find_product_info_for).with('47856').and_return("Product: Thingy\nPrice: 47.11")
      expect{@product_info_handler.subscribe @subscriber}.to_not raise_exception
      expect(@subscriber).to receive(:update).with("Product: Thingy\nPrice: 47.11")
      @product_info_handler.on_barcode("47856\n")
    end
  end
end
