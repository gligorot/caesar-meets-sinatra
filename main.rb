require 'sinatra'
require 'sinatra/reloader' if development?

def caesar_cipher(string, factor)

  words_array = string.split(" ")
  result = Array.new

  words_array.map do |word|
    coded = "" #blank result, gets updated on every cycle
    word.chars.map do |char|
      letter = char.ord
      #ghetto wrap and interpunction control
      if letter < 65 || letter > 122
        letter
      else
        letter += factor
        if char == char.downcase
          if letter > 122
            letter -= 26
          end
        elsif char == char.upcase
          if letter > 90
            letter -= 26
          end
        end
      end
      letter = letter.chr

      coded += letter
    end
    result.push(coded)
  end
  result.join(" ")
end


get '/' do
  text = params["text"]
  factor = params["factor"].to_i

  encrypted_text = caesar_cipher(text, factor) if text && factor
  erb :main_view, :locals => {:encrypted_text => encrypted_text}
end

