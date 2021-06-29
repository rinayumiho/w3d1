require_relative "fragment"
# require 'byebug'
class Ai
    attr_reader :strikes

    def initialize
        @strikes = ""
    end

    def add_strike
        @strikes += "@"
    end

    def get_input(seq)
        idx = seq.length
        # Fragment.implement_dict
        words = Fragment.dict[seq]
        weights = Array.new(26, nil)
        words.each do |word|
            len = word.length - idx
            cur_char = word[idx]
            pos = cur_char.ord - "a".ord
            weights[pos] = len if weights[pos].nil? || weights[pos] > len
        end
        odd_char = nil
        odd = 100
        even_char = nil
        even = 0
        (0..25).each do |i|
            next if weights[i].nil?
            if weights[i].odd? && odd > weights[i]
                odd = weights[i]
                odd_char = ("a".ord + i).chr
            end
            if weights[i].even? && even < weights[i]
                even = weights[i]
                even_char = ("a".ord + i).chr
            end
        end
        return odd_char if !odd_char.nil?
        ("a".ord + (0..25).reject { |i| weights[i].nil? }.sample).chr
    end

    def lose?
        @strikes.length == 5
    end
end

# test = Ai.new

# debugger
# test.get_input("r")