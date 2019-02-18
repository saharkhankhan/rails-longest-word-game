class GamesController < ApplicationController
require 'open-uri'
require 'JSON'

  def total_score(score)
    if session.has_key?(:grand_total)
      session[:grand_total] += score
    else
      session[:grand_total] = score
    end
  end

  def new
    session[:start_time] = Time.now
    alphabet = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @letters = alphabet.sample(10)
  end

  def score
    end_time = Time.now
    @time_taken = end_time - Time.parse(session[:start_time])

    @word = params[:word]
    checker = "https://wagon-dictionary.herokuapp.com/#{@word}"
    json = open(checker).read
    outcome = JSON.parse(json)
    @grid = params[:letters].split
    @score_number = outcome["length"].to_i
    if outcome["found"] == false
      @score = "Thats not a real word"
    elsif valid?(@word, @grid) == false
      @score = "Sorry but '#{@word}' cant be built out of the letters '#{params[:letters]}'"
    else
      @score = "Your Score is: #{@score_number - (@time_taken/1000)}"
    end
    total_score(@score_number)
  end

  def valid?(word, grid)
    word_array = word.split('')
    word_array.all? do |letter|
      grid.count(letter) >= word_array.count(letter)
    end
  end
end
