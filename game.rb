require 'set'
require_relative "fragment"
require_relative "player"
require_relative "ai"

class Game
    def initialize(p2_Ai)
        @player1 = Player.new
        @player2 = p2_Ai ? Ai.new : Player.new
        Fragment.implement_dict
    end

    def switch_player
        if @current_player == @player1
            @current_player = @player2
        else
            @current_player = @player1
        end
    end

    def play_one_round
        puts
        puts "*" * 21
        puts "** Round #{@player1.strikes.length + @player2.strikes.length + 1} starts! **"
        puts "*" * 21
        fragment = Fragment.new
        @current_player = @player1
        while !fragment.game_over?
            fragment.print_sequence
            puts
            if @current_player == @player1
                puts "Now it's turn for Player1"
            else
                puts "Now it's turn for Player2"
            end
            puts "Please enter a character (a ~ z):"
            if @current_player.is_a?(Player)
                char = @current_player.get_input
                while !fragment.valid_ch?(char)
                    puts "Invalid input, please re-enter:"
                    char = @current_player.get_input
                end
                fragment.add_ch(char)
            else
                char = @current_player.get_input(fragment.sequence)
                fragment.add_ch(char)
            end
            switch_player
        end
        puts "A word completed!"
        fragment.print_sequence
        if @current_player == @player1
            puts "Player1 lost this round"
        else
            puts "Player2 lost this round"
        end
        @current_player.add_strike
    end

    def run
        until @player1.lose? || @player2.lose?
            play_one_round
            puts "Player1's strikes are: " + @player1.strikes
            puts "Player2's strikes are: " + @player2.strikes
        end
        if @player1.lose?
            puts "Player2 win!"
        else
            puts "Player1 win!"
        end
    end
end