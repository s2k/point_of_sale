# frozen_string_literal: true

require 'spec_helper'

describe Display do
  subject { Display.new StringIO.new }

  it 'should respond to update' do
    expect { subject.update('message') }.to_not raise_exception
    expect(subject.update('message')).to be_nil
  end
end
