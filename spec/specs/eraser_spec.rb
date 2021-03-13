require_relative '../../lib/eraser'

describe Eraser do
  describe '#erase' do
    let(:paper) { 'Text for testing.' }

    context 'text is erased' do
      it 'only erases the specified text' do
        subject.erase(paper, 'for')
        expect(paper).to eq('Text     testing.')
      end

      it 'can erase text with white space to the left' do
        subject.erase(paper, 'testing')
        expect(paper).to eq('Text for        .')
      end

      it 'can erase text with white space to the right' do
        subject.erase(paper, 'Text')
        expect(paper).to eq('     for testing.')
      end

      it 'can erase text between other characters' do
        subject.erase(paper, 'est')
        expect(paper).to eq('Text for t   ing.')
      end
    end

    context 'text is not erased' do
      it 'will not erase text that does not match' do
        subject.erase(paper, 'Txt')
        expect(paper).to eq('Text for testing.'), 'should not have deleted text'
      end

      it 'is case sensative' do
        subject.erase(paper, 'text')
        expect(paper).to eq('Text for testing.'), 'Deleted uppercase text'
      end
    end

    context 'duplicate text on the paper' do
      let(:paper) { 'text with repeated text in the text.'}

      it 'erases the most recently written text' do
        subject.erase(paper, 'text')
        expect(paper).to eq('text with repeated text in the     .'), 'last written occurence of text to delete should have been deleted'
      end

      it 'can erase the same text multiple times' do
        subject.erase(paper, 'text')
        subject.erase(paper, 'text')
        subject.erase(paper, 'text')
        expect(paper).to eq('     with repeated      in the     .'), 'all occurences of the text to deleted should have been deleted'
      end
    end
  end

  describe 'eraser degradation' do
    context 'eraser durability greater than 0' do
      it 'should degrade eraser by 1 for all non-white space characters'
      it 'should not degrade when erasing white spaces'
    end

    context 'does not erase more than the durability' do
      it 'will not erase more characters than eraser durability'
      it 'should erase right to left'
    end

    context 'eraser durability is 0' do
      it 'does not erase'
      it 'does not have a length less than 0'
    end
  end
end
