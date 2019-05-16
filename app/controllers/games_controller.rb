require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    6.times do
    @letters << ('A'..'Z').to_a.sample
    end
    4.times do
    @letters << ['A', 'E', 'I', 'O', 'U'].sample
    end
  end

  def in_grid?(grid)
    @word = params[:word]
    letter_check = @word.split("")
    letter_check.each do |letter|
      return false if letter_check.count(letter) > grid.count(letter)
    end
    return true
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    if in_grid?(@letters)
      if dico?(@word)
        @result = "Well done! You use the right letters"
      else
        @result = "0 - It is not an english word"
      end
    else
      @result = "You have to use the letters given"
    end
  end

  def dico?(word)
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user = open(url).read
    user_hash = JSON.parse(user)
    user_hash['found'] ? true : false
  end
end
