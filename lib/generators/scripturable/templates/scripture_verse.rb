class ScriptureVerse
  SCRIPTURE_VERSE_FORMAT = /^(\d+)(?::(\d+))?(?::(\d+))?$/ #http://rubular.com/r/7axgNYfYiK

  def initialize values=0
    # raise "Scripture reference does not follow the format: '<book-number>(:<chapter-number>(:<verse-number>))'" unless follows_format? scripture_verse
    # raise "Verse does not exist in scripture" unless exists?
#   @book_number, @chapter_number, @verse_number = scripture_verse.scan(SCRIPTURE_VERSE_FORMAT).flatten.compact.map(&:to_i)
    @book_number, @chapter_number, @verse_number = values['book'].to_i , values['chapter'].to_i, values['verse'].to_i if values.is_a?(Hash)
    if values.is_a?(Fixnum)
      quotient, @verse_number = values.divmod(1000) 
      @book_number, @chapter_number = (quotient).divmod(1000) 
    end
  end
  
  def to_i
    @book_number * 1000000 + @chapter_number * 1000 + @verse_number
  end
  
  protected

  def exists?
    book_exists? && chapter_exists? && verse_exists?
  end

  def book_exists?
    (1..66).include? @book_number #66 books in the Bible
  end

  def chapter_exists? 
    chapter_hash.present?
  end

  def verse_exists?
    (1..chapter_hash['verse_count']).include? @verse_number 
  end

  def book_hash
    @book_hash ||= Scripturable::SCRIPTURE_META.find{|book| book['book_number'] == @book_number}
  end

  def chapter_hash
    @chapter_hash ||= book_hash['chapters'].find{|chapter| chapter['chapter_number'] == @chapter_number}
  end

  def follows_format? reference
    reference.scan(SCRIPTURE_VERSE_FORMAT).any?
  end

end

