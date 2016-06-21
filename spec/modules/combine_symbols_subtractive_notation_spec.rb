# coding: utf-8
require_relative '../../modules/combine_symbols_subtractive_notation'

describe NumeralSystem do
  let(:numeral_system_class) do
    Class.new do
      include CombineSymbolsSubtractiveNotation
    end
  end

  describe '.combine_symbols' do
    {1 => 'I', 2 => 'II', 3 => 'III', 4 => 'IV', 5 => 'V', 6 => 'VI', 7 => 'VII', 8 => 'VIII', 9 => 'IX'}.each do |k, v|
      it "#{k} returns #{v}" do
        expect(numeral_system_class.combine_symbols(k, { 1 => 'I', 5 => 'V', 10 => 'X' })).to eql v
      end
    end
  end
end
