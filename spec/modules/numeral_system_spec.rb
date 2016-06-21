require_relative '../../modules/numeral_system'
  #Create a class that extends the NumeralSystem module
describe NumeralSystem do

  let(:numeral_system_class) do
    Class.new do
      include NumeralSystem
      SYMBOLS_DICTIONARY = { 1 => 'I', 5 => 'V', 10 => 'X', 50 => 'L', 100 => 'C', 500 => 'D', 1000 => 'M' } unless const_defined?(:SYMBOLS_DICTIONARY)
    end
  end

  describe '.get_symbols_at_order_of_magnitude' do
    context 'when order magnitude is negative' do
      it 'raises a RangeError' do
        expect {numeral_system_class.send(:get_symbols_at_order_of_magnitude, -1)}.to raise_error(RangeError)
      end
    end

    context 'when order magnitude at 0' do
      it 'returns I, V, X' do
        expect(numeral_system_class.send(:get_symbols_at_order_of_magnitude, 0)).to eql({1 => 'I', 5 => 'V', 10 => 'X'})
      end
    end

    context 'when order magnitude at 1' do
      it 'returns X, L, C' do
        expect(numeral_system_class.send(:get_symbols_at_order_of_magnitude, 1)).to eql({1 => 'X', 5 => 'L', 10 => 'C'})
      end
    end

    context 'when order magnitude at 2' do
      it 'returns C, D, M' do
        expect(numeral_system_class.send(:get_symbols_at_order_of_magnitude, 2)).to eql({1 => 'C', 5 => 'D', 10 => 'M'})
      end
    end

    context 'when order magnitude at 3' do
      it 'returns M' do
        expect(numeral_system_class.send(:get_symbols_at_order_of_magnitude, 3)).to eql({1 => 'M'})
      end
    end

    context 'when order magnitude at 4' do
      it 'returns {}' do
        expect(numeral_system_class.send(:get_symbols_at_order_of_magnitude, 4)).to eql({})
      end
    end
  end

  describe '.from_natural' do
    context 'when number negative' do
      it 'raises a ArgumentError' do
        expect {numeral_system_class.from_natural(-1)}.to raise_error(ArgumentError)
      end
    end

    context 'when number needs to be combinded' do
      [2, 6, 20, 200, 2000].each do |k|
        it 'raises a NoMethodError' do
          expect {numeral_system_class.from_natural(k)}.to raise_error(NoMethodError)
        end
      end
    end

    #Test a few values, the algorithm should be able to return (no combine necessary)
    { 1 => 'I', 5 => 'V', 10 => 'X', 11 => 'XI', 50 => 'L', 51 => 'LI', 100 => 'C', 101 => 'CI', 500 => 'D', 501 => 'DI', 1000 => 'M', 1511 => 'MDXI' }.each do |k,v|
      it "returns #{v}" do
        expect(numeral_system_class.from_natural(k)).to eql v
      end
    end
  end

  context 'when order magnitude is too high (overflow) and overflow is false' do
    [10000, 100000, 1000000].each do |k|
      it 'raises a ArgumentError' do
        expect {numeral_system_class.from_natural(k)}.to raise_error(ArgumentError)
      end
    end
  end

  context 'when order magnitude is too high (overflow) and overflow is true' do
    {10000 => 'MMMMMMMMMM', 100000 => 'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM', 1000000 => 'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM'}.each do |k, v|
      it "returns #{v}" do
        expect(numeral_system_class.from_natural(k, overflow: true)).to eql v
      end
    end
  end
end
