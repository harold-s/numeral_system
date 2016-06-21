# coding: utf-8
require_relative '../../modules/combine_symbols_additive_notation'

describe NumeralSystem do
  let(:numeral_system_class) do
    Class.new do
      include CombineSymbolsAdditiveNotation
    end
  end

  describe '.combine_symbols' do
    {1 => 'Ι', 2 => 'ΙΙ', 3 => 'ΙΙΙ', 4 => 'ΙΙΙΙ', 5 => 'Π', 6 => 'ΠΙ', 7 => 'ΠΙΙ', 8 => 'ΠΙΙΙ', 9 => 'ΠΙΙΙΙ'}.each do |k, v|
      it "#{k} returns #{v}" do
        expect(numeral_system_class.combine_symbols(k, { 1 => 'Ι', 5 => 'Π' })).to eql v
      end
    end
  end
end
