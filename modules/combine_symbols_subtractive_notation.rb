module CombineSymbolsSubtractiveNotation
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def combine_symbols(number, symbols_at_order_of_magnitude, **params)
      if number == 9 && symbols_at_order_of_magnitude.key?(1) && symbols_at_order_of_magnitude.key?(10)
        (symbols_at_order_of_magnitude[1] * (10 - number)) + symbols_at_order_of_magnitude[10]
      elsif (5..8) === number && symbols_at_order_of_magnitude.key?(1) && symbols_at_order_of_magnitude.key?(5)
        symbols_at_order_of_magnitude[5] + (symbols_at_order_of_magnitude[1] * (number - 5))
      elsif number == 4 && symbols_at_order_of_magnitude.key?(1) && symbols_at_order_of_magnitude.key?(5)
        symbols_at_order_of_magnitude[1] + symbols_at_order_of_magnitude[5]
      elsif symbols_at_order_of_magnitude[1]
        symbols_at_order_of_magnitude[1] * number
      end
    end
  end
end
