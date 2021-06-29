require_relative "fragment"

class Player
    attr_reader :strikes

    def initialize
        @strikes = ""
    end

    def add_strike
        @strikes += "@"
    end

    def get_input
        gets.chomp
    end

    def lose?
        @strikes.length == 5
    end
end