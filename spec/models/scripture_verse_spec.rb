require 'spec_helper'

describe ScriptureVerse do
  describe '#initialize' do

    it 'should raise an error if it does not follow the format' do
      lambda {ScriptureVerse.new("8:12-14")}.should raise_error(RuntimeError,"Scripture reference does not follow the format: '<book-number>(:<chapter-number>(:<verse-number>))'")
    end


    it 'should initializse the scripture reference when the format is valid' do
      lambda {@scripture_verse = ScriptureVerse.new("8:12:14")}.should_not raise_error(RuntimeError,"Scripture reference does not follow the format: '<book-number>(:<chapter-number>(:<verse-number>))'")
      @scripture_verse.should be_present
    end

  end

  describe '#book_exists?' do

    it 'returns a true when 35 is passed ' do
      @scripture_verse = ScriptureVerse.new("1:4:5") 
    end

    it 'returns a false when 67 is passed ' do
      pending
    end
  end

end
