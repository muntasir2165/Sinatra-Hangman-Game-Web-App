class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(char)
    #check if char is nil, empty or a non-alphabetic character
    if (char.nil? or char.empty? or (char =~ /[^a-zA-Z]/) != nil)
      raise ArgumentError.new("Invalid argument of type nil, empty string or non-alphabetic character")
    end
    
    #check if char has already been guesses
    if ((@guesses.include?(char.downcase)) or (@wrong_guesses.include?(char.downcase)))
      return false
    end
    
    if @word.downcase.include?(char.downcase)
      @guesses += char.downcase
    else
      @wrong_guesses += char.downcase
    end
    
    return true
  end

  def word_with_guesses
    display = ''
    word.downcase.each_char do |char|
      if @guesses.downcase.include?(char)
        display += char
      else
        display += '-'
      end
    end
    return display
  end
  
  def check_win_or_lose
    display = word_with_guesses
    if @wrong_guesses.length >= 7
      return :lose
    end
    #else
    if display.include?('-')
      return :play
    else
      return :win
    end
  end
end
