require 'spec_helper'

describe Primata::SMS do
  describe '.normalized_number' do
    context 'valid number' do
      [
        ' 62 812 345 678 90',
        '+62 812 345 678 90',
        '+62-812-345-678-90',
        '+6281234567890',
        '6281234567890',
        '081234567890',
        '0812-345-678-90',
        '0812_345_678_90',
        '0812.345.678.90'
      ].each do |number|
        it { expect(described_class.normalized_number(number)).to eq('+6281234567890') }
      end

      # 13 digit number
      %w(
        0895363788442
        62895363788442
      ).each do |number|
        it { expect(described_class.normalized_number(number)).to eq('+62895363788442') }
      end

      [
        '0271234567',
        '(0271) 234567',
        '+62 (0271) 234567',
        '+62.271.234567',
        '62.271.234567'
      ].each do |number|
        it { expect(described_class.normalized_number(number)).to eq('+62271234567') }
      end
    end

    context 'bad number' do
      it { expect(described_class.normalized_number('this-is-my-number')).to be_nil }
      it { expect(described_class.normalized_number('0812')).to be_nil }
      it { expect(described_class.normalized_number('0271234567891234567890123456789')).to be_nil }
    end
  end
end
