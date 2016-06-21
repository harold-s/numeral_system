# coding: utf-8
require_relative './modules/numeral_system'
require_relative './modules/combine_symbols_additive_notation'

class AtticNumeral
  include NumeralSystem
  include CombineSymbolsAdditiveNotation
  SYMBOLS_DICTIONARY = { 1 => 'Ι', 5 => 'Π', 10 => 'Δ', 100 => 'Η', 1000 => 'X', 10000 => 'Μ'}
end

class Fixnum
  def to_attic_numeral(**params)
    AtticNumeral.from_natural(self.to_i, params)
  end
end
