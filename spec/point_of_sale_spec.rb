# frozen_string_literal: true

require_relative 'spec_helper'

MAX_ID = 2**(0.size * 8)
MESSAGE_TEXT = "Product: Thingy\nPrice: 47.11"
VALID_BARCODE = "47856\n"

describe PointOfSale do
  before(:example) do
    @catalog = instance_double('Catalog')
    @display = instance_double( 'Display')
    allow(@catalog).to receive(:find_product_info_for).once
    expect(@display).to receive( :update).once
    @check_out_system = PointOfSale.new(@catalog, @display)
  end

  context 'reacting to an incoming bar code' do
    it 'reacts to a bar code reading event' do
      expect { @check_out_system.on_barcode('1234\n') }.to_not raise_exception
    end

    it 'can be called without an argument' do
      expect { @check_out_system.on_barcode }.to_not raise_exception
    end

    it 'handles string and integer inputs' do
      expect { @check_out_system.on_barcode rand(MAX_ID) }.to_not raise_exception
    end
  end

  context 'getting product information (price in particular) from … elsewhere' do
    it 'Again: It can be instantiated' do
      expect(@catalog).to receive(:find_product_info_for).with('47856').and_return(MESSAGE_TEXT)
      expect(@check_out_system.on_barcode(VALID_BARCODE)).to be_nil
    end
  end
end
