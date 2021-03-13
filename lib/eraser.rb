class Eraser
  attr_accessor :durability

  def initialize(durability)
    @durability = durability
  end

  def erase(paper, erasing_text)
    return unless paper.include?(erasing_text)
    return unless durability.positive?

    starting_index = paper.rindex(erasing_text)
    index_to_erase = starting_index + erasing_text.length - 1

    until index_to_erase < starting_index
      if paper[index_to_erase] != ' ' && @durability.positive?
        paper[index_to_erase] = ' '
        @durability -= 1
      end

      index_to_erase -= 1
    end
  end
end
