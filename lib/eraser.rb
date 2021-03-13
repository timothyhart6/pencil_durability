module Eraser
  def erase(paper, erasing_text)
    return unless paper.include?(erasing_text)
    return unless @eraser_durability.positive?

    starting_index = paper.rindex(erasing_text)
    index_to_erase = starting_index + erasing_text.length - 1

    until index_to_erase < starting_index
      if paper[index_to_erase] != ' ' && @eraser_durability.positive?
        paper[index_to_erase] = ' '
        @eraser_durability -= 1
      end

      index_to_erase -= 1
    end
  end
end
