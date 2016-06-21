module NumeralSystem
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def from_natural(number, **params)
      raise ArgumentError, 'Roman symbols only work with natural numbers' if number < 0
      params[:overflow] ||= false
      res = ''
      number.to_s(10).reverse.chars.each_with_index do |v, index|
        #Roman symbols have two symbols for every power of 10 (unit_symbol and five_unit_symbol, we can find the symbol in the hash
        res.insert(0, from_natural_at_order_of_magnitude(v.to_i, index, params))
      end
      res
    end

    private
    #This method returns all symbols from @@symbols_dictionary betwen 10^order_of_magnitude and 10^(order_of_magnitude + 1) (for example from to 1 to 10 / 10 to 100)
    def get_symbols_at_order_of_magnitude(order_of_magnitude, **params)
      raise RangeError, 'NumeralSystem symbols only work with natural numbers' if order_of_magnitude < 0
      range = ((10 ** order_of_magnitude)..(10 ** (order_of_magnitude + 1)))

      res = {}
      self.const_get(:SYMBOLS_DICTIONARY).each do |k,v|
        if(range.include?(k))
          res[k / (10 ** order_of_magnitude)] = v
        end
      end
      res
    end

    def from_natural_at_order_of_magnitude(number, order_of_magnitude, **params)
      symbols_at_order_of_magnitude = get_symbols_at_order_of_magnitude(order_of_magnitude, params)
      #No symbols found at this magnitude :
      if(symbols_at_order_of_magnitude.empty?)
        #If overflowe true, we print 10 times the number 1 10^(order_of_magnitude -1)
        if(params[:overflow])
          from_natural_at_order_of_magnitude(1, order_of_magnitude - 1, params) * 10 * number
        else
          raise ArgumentError, "Overflow error, no symbols available for numbers with 10^#{order_of_magnitude} magnitude. (Biggest symbol available : #{self.const_get(:SYMBOLS_DICTIONARY).max_by{|k,v| k}.reverse.join(' (')})), try with overflow=true"
        end
      #We first look if we have the symbol in the dictionnary at the magnitude provided
      elsif(symbols_at_order_of_magnitude[number])
        symbols_at_order_of_magnitude[number]
      #If no symbol for 0 exists and number is 0, we return ''
      elsif(number == 0)
        ''
      #We try to combine symbols (NotImplementedError will be raised if not implemented by class)
      else
        combine_symbols(number, symbols_at_order_of_magnitude, params)
      end
    end
  end
end
