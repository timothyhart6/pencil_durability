require_relative '../../lib/pencil'
describe Pencil do
  describe '#write' do
    before(:each) do
      @paper = ''
      subject.write(@paper, 'Initial text.')
    end

    let(:second_text) { ' Second text.' }
    let(:third_text) { ' Third text.' }

    it 'writes text on a paper' do
      expect(@paper).to eq('Initial text.'), 'Text is not being written'
    end

    it 'appends text on to the existing text on the paper' do
      subject.write(@paper, second_text)
      expect(@paper).to eq('Initial text. Second text.'), 'Text is not being appended'
    end

    it 'can append text to the paper multiple times' do
      subject.write(@paper, second_text)
      subject.write(@paper, third_text)
      expect(@paper).to eq('Initial text. Second text. Third text.'), 'Text is not being appended'
    end

    it 'writes leading white space' do
      subject.write(@paper, ' text after white space.')
      expect(@paper).to eq('Initial text. text after white space.'), 'white space is not being written'
    end

    it 'writes trailing white space' do
      subject.write(@paper, 'text before white space. ')
      expect(@paper).to eq('Initial text.text before white space. '), 'white space is not being written'
    end
  end

  describe '#point_degradation' do
    context 'degradation' do
      it 'decreases by 1 when writing a lowercase letter'
      it 'decreases by 2 when writing a capital letter'
      it 'does not decrease when writing a space'
      it 'does not decrease when writing a newline'
    end

    context 'pencil has a durability of 0' do
      it 'writes a space for each character'
      it 'does not have a durability less than 0'
    end

    context 'durability for partial text' do
      it 'will write characters until it is dull'
      it 'will not write an uppercase character if durability is 1'
    end
  end
end
