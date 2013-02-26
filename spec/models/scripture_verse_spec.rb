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
      @scripture_verse = ScriptureVerse.new("35:4:5") 
      @scripture_verse.book_exists?.should be_true
    end

    it 'returns a true when the book number is 66' do
      @scripture_verse = ScriptureVerse.new("66:4:5") 
      @scripture_verse.book_exists?.should be_true
    end

    it 'returns a false when 67 is passed ' do
      @scripture_verse = ScriptureVerse.new("67:4:5") 
      @scripture_verse.book_exists?.should be_false
    end

  end

  describe '#chapter_exists?' do

    it 'returns a true when 35 is passed ' do
      #1 John does not have chapter 6 does not exist
      @scripture_verse = ScriptureVerse.new("62:6:4") 
      @scripture_verse.chapter_exists?.should be_false
    end

    it 'returns a true when the book number is 66' do
      #1 John does not have chapter 5 does not exist
      @scripture_verse = ScriptureVerse.new("62:5:5") 
      @scripture_verse.chapter_exists?.should be_true
    end

  end

  describe '#verse_exists?' do

    it 'returns a true when 35 is passed ' do
      #1 John does not have chapter 6 does not exist
      @scripture_verse = ScriptureVerse.new("62:5:22") 
      @scripture_verse.verse_exists?.should be_false
    end

    it 'returns a true when the book number is 66' do
      #1 John does not have chapter 5 does not exist
      @scripture_verse = ScriptureVerse.new("62:5:21") 
      @scripture_verse.verse_exists?.should be_true
    end

  end

  describe '#exists?' do

    it 'returns a true when 35 is passed ' do
      #1 John does not have chapter 6 does not exist
      @scripture_verse = ScriptureVerse.new("62:5:22") 
      @scripture_verse.exists?.should be_false
    end

    it 'returns a true when 35 is passed ' do
      #1 John does not have chapter 6 does not exist
      @scripture_verse = ScriptureVerse.new("62:6:4") 
      @scripture_verse.exists?.should be_false
    end

    it 'returns a true when the book number is 66' do
      #1 John does not have chapter 5 does not exist
      @scripture_verse = ScriptureVerse.new("68:5:21") 
      @scripture_verse.exists?.should be_false
    end

    it 'returns a true when the book number is 66' do
      #1 John does not have chapter 5 does not exist
      @scripture_verse = ScriptureVerse.new("62:5:21") 
      @scripture_verse.exists?.should be_true
    end

  end



end
