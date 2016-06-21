# numeral_system                                                                                                                                                                                            
This library implements a conversion from integer to a string [numeral system](https://en.wikipedia.org/wiki/Numeral_system). It implements two numeral systems :
- [Attic Numeral](https://en.wikipedia.org/wiki/Attic_numerals)
- [Roman Numeral](https://en.wikipedia.org/wiki/Roman_numerals)

Just require attic_numeral or roman_numeral and methods to_attic_numeral or to_roman_numeral are added to Fixnum :
```ruby
6.to_roman_numeral #returns "VI"
287.to_roman_numeral #returns "CCLXXXVII" 
287.to_attic_numeral #returns "ΗΗΔΔΔΔΔΔΔΔΠΙΙ"
```
Both method can take a overflow: true argument which will  attempt to construct the number 
```ruby
9999.to_roman_numeral #returns "MMMMMMMMMCMXCIX
10000.to_roman_numeral #raise  exception : ArgumentError: Overflow error, no symbols available for numbers with 10^4 magnitude. (Biggest symbol available : M (1000)), try with overflow=true
10000.to_roman_numeral(overflow: true) #returns "MMMMMMMMMM"
```

Tests can be launched with rspec
