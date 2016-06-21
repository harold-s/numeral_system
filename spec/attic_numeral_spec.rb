# coding: utf-8
require_relative '../attic_numeral'
describe AtticNumeral do
  {1 => 'Ι', 2 => 'ΙΙ', 3 => 'ΙΙΙ', 4 => 'ΙΙΙΙ', 5 => 'Π', 6 => 'ΠΙ', 7 => 'ΠΙΙ', 8 => 'ΠΙΙΙ', 9 => 'ΠΙΙΙΙ', 10 => 'Δ', 11 => 'ΔΙ', 12 => 'ΔΙΙ', 13 => 'ΔΙΙΙ', 14 => 'ΔΙΙΙΙ', 15 => 'ΔΠ', 16 => 'ΔΠΙ', 17 => 'ΔΠΙΙ', 18 => 'ΔΠΙΙΙ', 19 => 'ΔΠΙΙΙΙ', 20 => 'ΔΔ', 21 => 'ΔΔΙ', 50 => 'ΔΔΔΔΔ', 51 => 'ΔΔΔΔΔΙ', 55 => 'ΔΔΔΔΔΠ', 59 => 'ΔΔΔΔΔΠΙΙΙΙ', 60 => 'ΔΔΔΔΔΔ', 61 => 'ΔΔΔΔΔΔΙ', 99 => 'ΔΔΔΔΔΔΔΔΔΠΙΙΙΙ', 100 => 'Η', 151 => 'ΗΔΔΔΔΔΙ', 179 => 'ΗΔΔΔΔΔΔΔΠΙΙΙΙ', 499 => 'ΗΗΗΗΔΔΔΔΔΔΔΔΔΠΙΙΙΙ', 500 => 'ΗΗΗΗΗ', 689 => 'ΗΗΗΗΗΗΔΔΔΔΔΔΔΔΠΙΙΙΙ', 873 => 'ΗΗΗΗΗΗΗΗΔΔΔΔΔΔΔΙΙΙ', 999 => 'ΗΗΗΗΗΗΗΗΗΔΔΔΔΔΔΔΔΔΠΙΙΙΙ', 1000 => 'X', 1001 => 'XΙ', 1664 => "XΗΗΗΗΗΗΔΔΔΔΔΔΙΙΙΙ", 2000 => 'XX', 4999 => 'XXXXΗΗΗΗΗΗΗΗΗΔΔΔΔΔΔΔΔΔΠΙΙΙΙ', 5000 => 'XXXXX', 10000 => 'Μ'}.each do |k,v|
    it "#{k} returns #{v}" do
      expect(k.to_attic_numeral).to eql v
    end
  end


  context 'when order magnitude is too high (overflow) and overflow is false' do
    [100000, 1000000].each do |k|
      it 'raises a ArgumentError' do
        expect {k.to_attic_numeral}.to raise_error(ArgumentError)
      end
    end
  end

  context 'when order magnitude is too high (overflow) and overflow is true' do
    {100000 => 'ΜΜΜΜΜΜΜΜΜΜ', 1000000 => 'ΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜΜ'}.each do |k, v|
      it "returns #{v}" do
        expect(k.to_attic_numeral(overflow: true)).to eql v
      end
    end
  end
end
