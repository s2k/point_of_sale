# frozen_string_literal: true

require_relative 'spec_helper'

MAX_ID = 2**(0.size * 8)
MESSAGE_TEXT = "Product: Thingy\nPrice: 47.11"
VALID_BARCODE = "47856\n"

describe PointOfSale do
  before(:example) do
    @catalog = instance_double('Catalog')
    allow(@catalog).to receive :find_product_info_for
    @check_out_system = PointOfSale.new(@catalog)
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

  context 'accepts clients to subscribe and sends updates' do
    before(:each) do
      @display = instance_double('Display')
    end

    it 'Accepts subscriber' do
      expect { @check_out_system.subscribe @display }.to_not raise_exception
    end

    it 'Notifies subscriber when a barcode event happens' do
      expect(@catalog).to receive(:find_product_info_for).with('47856').and_return(MESSAGE_TEXT)
      expect { @check_out_system.subscribe @display }.to_not raise_exception
      expect(@display).to receive(:update).with(MESSAGE_TEXT)
      @check_out_system.on_barcode(VALID_BARCODE)
    end

    it 'No one is notified, when nobody subscribes' do
      expect(@catalog).to receive(:find_product_info_for).with('47856').and_return(MESSAGE_TEXT)
      expect(@display).not_to receive(:update)
      @check_out_system.on_barcode(VALID_BARCODE)
    end

    it 'Notifies all displays when a barcode event happens' do
      displays = [@display, instance_double('Display')]
      expect(@catalog).to receive(:find_product_info_for).once.with('47856').and_return(MESSAGE_TEXT)
      displays.each do |s|
        expect { @check_out_system.subscribe s }.to_not raise_exception
        expect(s).to receive(:update).with(MESSAGE_TEXT)
      end
      @check_out_system.on_barcode(VALID_BARCODE)
    end
  end
end
