require 'spec_helper'


describe 'pain' do
  subject { Class.new { include Pain }.new }

  it 'calculates_correctly' do
    expect(subject.user_pain(7, 5, 5)).to eq(100)
    expect(subject.user_pain(1, 1, 1)).to eq(0)
    expect(subject.user_pain(4, 3, 3)).to eq(20)
  end
end
