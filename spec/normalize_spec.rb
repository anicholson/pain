require 'spec_helper'

describe 'normalize' do
  subject { Class.new { include Pain }.new }

  it 'doesn\'t allow numbers too small' do
    expect(subject.normalize(0, :impact)).to  be_nil
    expect(subject.normalize(-1, :impact)).to be_nil
  end

  it 'doesn\'t allow numbers too big' do
    expect(subject.normalize(10, :bug_type)).to eq(7) 
    expect(subject.normalize(7,  :impact)).to   eq(5)
    expect(subject.normalize(7,  :bug_type)).to eq(7)
  end
end
