class ScriptureVerse
# SCRIPTURE_VERSE_FORMAT = /^(\d+)(?::(\d+))?(?::(\d+))?$/ #http://rubular.com/r/7axgNYfYiK
  SCRIPTURE_VERSE_FORMAT = /^(\d+):(\d+):(\d+)$/ 


  def initialize values=nil
    values = parse_verse(values) if values.is_a?(String)
    values = resolve values if values.is_a?(Fixnum)
    @book_number, @chapter_number, @verse_number = values['book_number'], values['chapter_number'], values['verse_number'] if values.is_a?(Hash)
  end
  
  def book_number
    @book_number
  end

  def chapter_number
    @chapter_number
  end

  def verse_number
    @verse_number
  end

  def book_name
    book_hash['name'] unless book_hash.nil?
  end

  def to_hash
    {
      :book_number => book_number,
      :chapter_number => chapter_number,
      :verse_number => verse_number,
      :book_name => book_name
    }
  end

  def to_i
    @book_number * 1000000 + @chapter_number * 1000 + @verse_number
  end

  def resolve number
    resolution = {}
    quotient, resolution['verse_number'] = number.divmod(1000) 
    resolution['book_number'], resolution['chapter_number'] = (quotient).divmod(1000) 
    resolution
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

  def parse_verse string
    raise "arugment is a string but does not follow the format: '<book-number>(:<chapter-number>(:<verse-number>))" unless follows_format? string
    Hash[['book_number', 'chapter_number', 'verse_number'].zip(string.scan(SCRIPTURE_VERSE_FORMAT).flatten.compact.map(&:to_i))]
  end

  def follows_format? reference
    return true if reference.blank?
    reference.scan(SCRIPTURE_VERSE_FORMAT).any?
  end

end

