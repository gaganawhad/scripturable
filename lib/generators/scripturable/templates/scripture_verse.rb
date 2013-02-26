class ScriptureVerse
  SCRIPTURE_VERSE_FORMAT = /^(\d+)(?::(\d+))?(?::(\d+))?$/ #http://rubular.com/r/7axgNYfYiK

  def initialize scripture_verse
    raise "Scripture reference does not follow the format: '<book-number>(:<chapter-number>(:<verse-number>))'" unless follows_format? scripture_verse
    @book_number, @chapter_number, @verse_number = scripture_verse.scan(SCRIPTURE_VERSE_FORMAT).flatten.compact.map(&:to_i)
  end
  
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

  protected


  def follows_format? reference
    reference.scan(SCRIPTURE_VERSE_FORMAT).any?
  end
end
