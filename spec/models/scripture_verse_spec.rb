require 'spec_helper'

describe ScriptureVerse do
  describe '#initialize' do

    it 'sets book, chapter and verse numbers to nil on initialization without passing any arguments' do
      @scripture_verse = ScriptureVerse.new
      @scripture_verse.book_number.should == nil
      @scripture_verse.chapter_number.should == nil 
      @scripture_verse.verse_number.should == nil 
    end

    it 'sets book, chapter and verse numbers to nil on initialization with an empty string' do
      @scripture_verse = ScriptureVerse.new("")
      @scripture_verse.book_number.should == nil
      @scripture_verse.chapter_number.should == nil 
      @scripture_verse.verse_number.should == nil 
    end

    it 'sets book, chapter and verse numbers corectly when an apporpiate Fixnum argument is passed to it' do
      @scripture_verse = ScriptureVerse.new(19119176)
      @scripture_verse.book_number.should == 19
      @scripture_verse.chapter_number.should == 119 
      @scripture_verse.verse_number.should == 176
    end

    it 'sets book, chapter and verse numbers correctly when an appropirate hash argument is passed to it' do
      @scripture_verse = ScriptureVerse.new({'book_number' => 19,  'chapter_number' => 119, 'verse_number' => 176})
      @scripture_verse.book_number.should == 19
      @scripture_verse.chapter_number.should == 119 
      @scripture_verse.verse_number.should == 176
    end

  end

  describe '#book_exists?' do

    it 'returns a true when 35 is passed ' do
      @scripture_verse = ScriptureVerse.new("35:4:5") 
      @scripture_verse.send(:book_exists?).should be_true
    end

    it 'returns a true when the book number is 66' do
      @scripture_verse = ScriptureVerse.new("66:4:5") 
      @scripture_verse.send(:book_exists?).should be_true
    end

    it 'returns a false when 67 is passed ' do
      @scripture_verse = ScriptureVerse.new("67:4:5") 
      @scripture_verse.send(:book_exists?).should be_false
    end

  end

  describe '#chapter_exists?' do

    it 'returns a true when 35 is passed ' do
      #1 John does not have chapter 6 does not exist
      @scripture_verse = ScriptureVerse.new("62:6:4") 
      @scripture_verse.send(:chapter_exists?).should be_false
    end

    it 'returns a true when the book number is 66' do
      #1 John does not have chapter 5 does not exist
      @scripture_verse = ScriptureVerse.new("62:5:5") 
      @scripture_verse.send(:chapter_exists?).should be_true
    end

  end

  describe '#verse_exists?' do

    it 'returns a true when 35 is passed ' do
      #1 John does not have chapter 6 does not exist
      @scripture_verse = ScriptureVerse.new("62:5:22") 
      @scripture_verse.send(:verse_exists?).should be_false
    end

    it 'returns a true when the book number is 66' do
      #1 John does not have chapter 5 does not exist
      @scripture_verse = ScriptureVerse.new("62:5:21") 
      @scripture_verse.send(:verse_exists?).should be_true
    end

  end

  describe '#exists?' do

    it 'returns a true when 35 is passed ' do
      #1 John does not have chapter 6 does not exist
      @scripture_verse = ScriptureVerse.new("62:5:22") 
      @scripture_verse.send(:exists?).should be_false
    end

    it 'returns a true when 35 is passed ' do
      #1 John does not have chapter 6 does not exist
      @scripture_verse = ScriptureVerse.new("62:6:4") 
      @scripture_verse.send(:exists?).should be_false
    end

    it 'returns a true when the book number is 66' do
      #1 John does not have chapter 5 does not exist
      @scripture_verse = ScriptureVerse.new("68:5:21") 
      @scripture_verse.send(:exists?).should be_false
    end

    it 'returns a true when the book number is 66' do
      #1 John does not have chapter 5 does not exist
      @scripture_verse = ScriptureVerse.new("62:5:21") 
      @scripture_verse.send(:exists?).should be_true
    end

  end

  describe '#to_i' do 
    context 'converts the scripture verse to a unique decimal integer' do

      it 'converts Gen 1:1 to 1,001,001' do
        @scripture_verse = ScriptureVerse.new("1:1:1") 
        @scripture_verse.to_i.should == 1001001
      end

      it 'converts Rev 22:21 to 66,022,021' do
        @scripture_verse = ScriptureVerse.new("66:22:21") 
        @scripture_verse.to_i.should == 66022021
      end

      it 'converts Psalm 119:176 to 19,119,176' do
        @scripture_verse = ScriptureVerse.new("19:119:176") 
        @scripture_verse.to_i.should == 19119176
      end

    end
  end



end
