require "open-uri"

class GamesController < ApplicationController
    def new
        @letters = generate_letter(8)
    end

    def score
        @word = params[:word].upcase
        @letters = params[:letters].split
        @included = included?(@word, @letters)
        @english_word = english_word?(@word)
    end

    private

    def generate_letter(grid_size)
        letters = ("A".."Z").to_a
        i = 0
        selected_letters = []
        while i < grid_size do
            selected_letters << letters.sample
            i += 1
        end
        selected_letters
    end

    def english_word?(word)
        url = "https://wagon-dictionary.herokuapp.com/#{word}"
        read_results = open(url).read
        results = JSON.parse(read_results)
        results["found"]
    end

    def included?(word, letters)
        word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
    end
end
