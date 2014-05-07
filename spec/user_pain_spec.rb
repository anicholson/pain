require 'spec_helper'

module UserPain
  MAX_BUG_TYPE   = 7
  MAX_LIKELIHOOD = 5
  MAX_IMPACT     = 5
  MAX_PAIN       = 5 * 5 * 7

  def user_pain(type, likelihood, impact)
    100 * (type * likelihood * impact) / MAX_PAIN
  end
end

describe 'user_pain' do
  subject { Class.new { include UserPain }.new }

  it 'calculates_correctly' do
    expect(subject.user_pain(7, 5, 5)).to eq(100)
    expect(subject.user_pain(1, 1, 1)).to eq(0)
    expect(subject.user_pain(4, 3, 3)).to eq(20)
  end
end
