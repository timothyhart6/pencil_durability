require_relative '../../lib/pencil'

describe Eraser do
  subject { Pencil.new(100, 10, 200) }
  let(:paper) { 'Text for testing.' }

  describe '#erase' do
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
        expect(paper).to eq('Text for testing.'), 'Text was deleted'
      end

      it 'is case sensative' do
        subject.erase(paper, 'text')
        expect(paper).to eq('Text for testing.'), 'Uppercase text was deleted'
      end

      it ' does not delete white space' do
        subject.erase(paper, ' ')
        expect(paper).to eq('Text for testing.'), 'White space was deleted'
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
      it 'should degrade eraser by 1 for all non-white space characters' do
        subject.erase(paper, 'Text')
        expect(subject.eraser_durability).to eq(196)
      end
      it 'should not degrade when erasing white spaces' do
        subject.erase(paper, ' ')
        expect(subject.eraser_durability).to eq(200), 'White space should have have degraded durability'
      end

      it 'should not include duplicate words in degrade count' do
        paper = 'Test Test Test'
        subject.erase(paper, 'Test')
        expect(subject.eraser_durability).to eq(196), 'duplicate text counted against durability'
      end
    end

    context 'does not erase more than the durability' do
      before(:each) do
        subject.eraser_durability = 3
        subject.erase(paper, 'Text')
      end

      it 'will not erase more characters than eraser durability' do
        expect(paper).to eq('T    for testing.')
      end

      it 'should erase right to left' do
        expect(paper).to eq('T    for testing.')
      end

      it 'should not erase text connected from both ends' do
        paper = 'st filler text Te'
        subject.erase(paper, 'Test')
        expect(paper).to eq('st filler text Te')
      end
    end

    context 'eraser durability is 0' do
      before(:each) do
        subject.eraser_durability = 0
        subject.erase(paper, 'Text')
      end

      it 'does not erase' do
        expect(paper).to eq('Text for testing.'), 'Text should not have been erased'
      end

      it 'does not have a durability less than 0' do
        expect(subject.eraser_durability).to be(0), 'Durability should not have changed'
      end
    end
  end
end
