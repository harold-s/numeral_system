module CombineSymbolsAdditiveNotation
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def combine_symbols(number, symbols_at_order_of_magnitude, **params)
      if number >= 5 && symbols_at_order_of_magnitude.key?(1) && symbols_at_order_of_magnitude.key?(5)
        symbols_at_order_of_magnitude[5] + (symbols_at_order_of_magnitude[1] * (number - 5))
      else symbols_at_order_of_magnitude[1]
        symbols_at_order_of_magnitude[1] * number
      end
    end
  end
end
