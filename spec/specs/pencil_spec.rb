require_relative '../../lib/pencil'
describe Pencil do
  let(:paper) { '' }

  subject { described_class.new(100, 10, 200) }
  it { is_expected.to have_attributes(durability: 100, length: 10, eraser_durability: 200) }

  describe '#write' do
    before(:each) do
      subject.write(paper, 'Initial text.')
    end

    let(:second_text) { ' Second text.' }
    let(:third_text) { ' Third text.' }

    it 'writes text on a paper' do
      expect(paper).to eq('Initial text.'), 'Text is not being written'
    end

    it 'appends text on to the existing text on the paper' do
      subject.write(paper, second_text)
      expect(paper).to eq('Initial text. Second text.'), 'Text is not being appended'
    end

    it 'can append text to the paper multiple times' do
      subject.write(paper, second_text)
      subject.write(paper, third_text)
      expect(paper).to eq('Initial text. Second text. Third text.'), 'Text is not being appended'
    end

    it 'writes leading white space' do
      subject.write(paper, ' text after white space.')
      expect(paper).to eq('Initial text. text after white space.'), 'white space is not being written'
    end

    it 'writes trailing white space' do
      subject.write(paper, 'text before white space. ')
      expect(paper).to eq('Initial text.text before white space. '), 'white space is not being written'
    end
  end

  describe 'durability' do
    context 'degradation' do
      it 'decreases by 1 when writing a lowercase letter' do
        subject.write(paper, 'abc')
        expect(subject.durability).to eq(97)
      end

      it 'decreases by 2 when writing a capital letter' do
        subject.write(paper, 'ABC')
        expect(subject.durability).to eq(94)
      end

      it 'does not decrease when writing a space' do
        subject.write(paper, '   ')
        expect(subject.durability).to eq(100), 'white space is degrading pencil'
      end

      it 'does not decrease when writing a newline' do
        subject.write(paper, "\n")
        expect(subject.durability).to eq(100), 'new line is degrading pencil'
      end

      it 'numbers'
      it 'special characters (non alpha)'
    end

    context 'pencil has a durability of 0' do
      before(:each) do
        subject.durability = 0
        subject.write(paper, 'Test')
      end

      it 'writes a space for each character' do
        expect(paper).to eq('    '), 'white space is not being written'
      end

      it 'does not have a durability less than 0' do
        expect(subject.durability).to eq(0), 'writing updated the durability when it should not have'
      end
    end

    context 'durability for partial text' do
      it 'will write characters until it is dull' do
        subject.durability = 4
        subject.write(paper, 'Test')
        expect(paper).to eq('Tes ')
      end

      it 'will not write an uppercase character if durability is 1' do
        subject.durability = 1
        subject.write(paper, 'A')
        expect(paper).to eq(' ')
      end
    end
  end

  describe '#sharpen' do
    context 'pencil length is greater than 0' do
      it 'restores the pencil to the initial durability' do
        subject.durability = 95
        subject.sharpen
        expect(subject.durability).to eq(100), 'Pencil was not sharpened'
      end

      it 'decreases pencil length by 1' do
        subject.durability = 95
        subject.sharpen
        expect(subject.length).to eq(9), 'Pencil length was not decreased'
      end

      it 'decreases the pencil length when the durability is already the default' do
        subject.sharpen
        expect(subject.length).to eq(9), 'Pencil length was not decreased'
      end
    end

    context 'pencil length is 0' do
      before(:each) do
        subject.length = 0
        subject.durability = 50
        subject.sharpen
      end

      it 'does not restore the pencil durability' do
        expect(subject.durability).to eq(50), 'Pencil was sharpened'
      end

      it 'does not have a length less than 0' do
        expect(subject.length).to eq(0), 'length was updated'
      end
    end
  end
end
