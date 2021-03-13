class Eraser
  def erase(paper, erasing_text)
    return unless paper.include? erasing_text

    index_to_erase = paper.rindex(erasing_text) + erasing_text.length - 1
    i = 0
    while i < erasing_text.length
      paper[index_to_erase] = ' '
      i += 1
      index_to_erase -= 1
    end
  end
end
