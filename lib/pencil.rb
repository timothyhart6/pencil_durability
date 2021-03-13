class Pencil
  attr_accessor :durability

  def initialize(durability)
    @durability = durability
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
end
