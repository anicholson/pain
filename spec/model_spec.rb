require 'spec_helper'

module Pain
  RSpec.describe Model do
    describe '#user_pain' do
      it 'calculates_correctly' do
        expect(subject.user_pain(7, 5, 5)).to eq(100)
        expect(subject.user_pain(1, 1, 1)).to eq(0)
        expect(subject.user_pain(4, 3, 3)).to eq(20)
      end
    end

    describe '#normalize' do
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
  end
end
