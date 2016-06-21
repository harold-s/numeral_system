require_relative './modules/numeral_system'
require_relative './modules/combine_symbols_subtractive_notation'

class RomanNumeral
  include NumeralSystem
  include CombineSymbolsSubtractiveNotation
  SYMBOLS_DICTIONARY = { 0 => 'nulla', 1 => 'I', 5 => 'V', 10 => 'X', 50 => 'L',  100 => 'C', 500 => 'D', 1000 => 'M'}
end

class Fixnum
  def to_roman_numeral(**params)
    #Zero does not have a roman numeral but was writtent nulla (https://en.wikipedia.org/wiki/Roman_numerals#Zero)
    if(self.to_i == 0)
      'nulla'
    else
      RomanNumeral.from_natural(self.to_i, params)
    end
  end
end
