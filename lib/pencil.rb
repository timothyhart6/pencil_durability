require_relative 'eraser'

class Pencil
  include Eraser
  attr_accessor :durability, :original_durability, :length, :eraser_durability

  def initialize(durability, length, eraser_durability)
    @original_durability = durability
    @durability = @original_durability
    @length = length
    @eraser_durability = eraser_durability
  end

  def write(paper, text)
    text.chars.each do |char|
      if @durability.zero?
        paper << ' '
      elsif @durability.positive?
        if char == ' '
          paper << char
        elsif char == "\n"
          paper << char
        elsif char.match(/[[:alpha:]]/) && char == char.upcase
          if @durability == 1
            paper << ' '
          else
            @durability -= 2
            paper << char
          end
        elsif char.match(/[[:alpha:]]/) && char == char.downcase
          @durability -= 1
          paper << char
        else
          @durability -= 1
          paper << char
        end
      end
    end
  end

  def sharpen
    return unless length.positive?

    @length -= 1
    @durability = @original_durability
  end

  def edit(paper, replacing_text)
    erased_text_index = paper.index('  ')
    return if erased_text_index.nil?

    erased_text_index += 1 if erased_text_index.positive?
    i = 0
    until i == replacing_text.length
      if paper[erased_text_index] == ' '
        paper[erased_text_index] = replacing_text[i]
      else
        paper[erased_text_index] = '@'
      end

      erased_text_index += 1
      i += 1
    end
  end
end
