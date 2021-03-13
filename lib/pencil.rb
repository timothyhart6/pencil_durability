class Pencil
  attr_accessor :durability, :original_durability, :length

  def initialize(durability, length)
    @original_durability = durability
    @durability = @original_durability
    @length = length
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
end
