class ScriptureVerse
  SCRIPTURE_VERSE_FORMAT = /^(\d+)(?::(\d+))?(?::(\d+))?$/ #http://rubular.com/r/7axgNYfYiK

  def initialize scripture_verse
    raise "Scripture reference does not follow the format: '<book-number>(:<chapter-number>(:<verse-number>))'" unless follows_format? scripture_verse
    @our_hash = Hash[['book_number', 'chapter_number', 'verse_number'].zip(scripture_verse.scan(SCRIPTURE_VERSE_FORMAT).flatten.compact.map(&:to_i))]
  end
  
  def exists?
  end
  
  def chapter_exists?
  end

  def verse_exists?
  end

  def book_exists? book_number
    (1..66).include? book_number #66 books in the Bible
  end

  def chapter_exists? scripture_book, chapter_number
    find_scripture_chapter(scripture_book, chapter_number).present?
  end

  def verse_exists? scripture_chapter, verse_number
    (1..scripture_chapter['verse_count']).include? verse_number 
  end

  def find_scripture_book book_number
    Scripturable::SCRIPTURE_META.find{|book| book['book_number'] == reference_hash['book']}
  end

  def find_scripture_chapter scripture_book, chapter_number
    scripture_book['chapters'].find{|chapter| chapter['chapter_number'] == chapter_number}
  end
  protected


  def follows_format? reference
    reference.scan(SCRIPTURE_VERSE_FORMAT).any?
  end
end
