# frozen_string_literal: true

require_relative 'spec_helper'

describe 'ProductInfoHandler' do
  it 'instantiates a product info handler' do
    expect { ProductInfoHandler.new }.not_to raise_exception
  end
end
