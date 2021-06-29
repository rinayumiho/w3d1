require 'set'

class Fragment
    attr_reader :sequence
    @@dict = Hash.new { |h, k| h[k] = Set.new }

    def self.dict
        @@dict
    end

    def self.implement_dict
        File.open("dictionary.txt", "r") do |file|
            file.each_line { |line| add_word(line.chomp) }
        end
    end

    def self.add_word(word)
        n = word.length
        (0...n).each do |i|
            @@dict[word[0..i]] << word
        end
    end

    def initialize
        @sequence = ""
    end

    def add_ch(ch)
        return false if !valid_ch?(ch)
        @sequence += ch
    end

    def valid_ch?(ch)
        ("a".."z").include?(ch) && @@dict.key?(@sequence + ch)
    end

    def game_over?
        @@dict[sequence].include?(sequence)
    end

    def print_sequence
        puts "###  " + @sequence + "  ###"
    end

end