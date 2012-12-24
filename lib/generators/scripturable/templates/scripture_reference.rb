class ScriptureReference < ActiveRecord::Base
  REFERENCE_FORMAT = /^(\d+)(?::(\d+))?(?::(\d+))?$/ #http://rubular.com/r/7axgNYfYiK

  belongs_to :scripturable, :polymorphic => true

  validates_presence_of :start_at
  validates :start_at, :format => {:with => REFERENCE_FORMAT, 
    :message => "start reference should follow the format '<book-number>(:<chapter-number>(:<verse-number>))" }
  validates :end_at, :format => {:with => REFERENCE_FORMAT, 
    :message => "end reference should follow the format '<book-number>(:<chapter-number>(:<verse-number>))" }

  
  def start_book
    start_reference['book']
  end
  
  def start_chapter
    start_reference['chapter']
  end

  def start_verse
    start_reference['verse']
  end

  def start_reference
    raise 'start_at value not set for the object' if start_at.blank?
    @start_reference ||= parse_reference start_at
  end

  def end_book
    end_reference['book']
  end

  def end_chapter
    end_reference['chapter']
  end

  def end_verse
    end_reference['verse']
  end

  def end_reference
    raise 'end_at value not set for the object' if end_at.blank?
    @end_reference ||= parse_reference end_at
  end
  
  private

  def parse_reference reference
    raise "Scripture reference does not follow the format: '<book-number>(:<chapter-number>(:<verse-number>))'" unless follows_format? reference
    Hash[['book_number', 'chapter_number', 'verse_number'].zip(reference.scan(REFERENCE_FORMAT).flatten.compact.map(&:to_i))]
  end

  def follows_format? reference
    reference.scan(REFERENCE_FORMAT).any?
  end

  def reference_exists? reference
    raise "Scripture reference does not follow the format: '<book-number>(:<chapter-number>(:<verse-number>))'" unless follows_format? reference

    book_number, chapter_number, verse_number = parse_reference(reference).values
    answer = catch(:message) do
      if book_exists? book_number
        scripture_book = find_scripture_book book_number
        if chapter_number.present?
          if chapter_exists? scripture_book, verse_number
            scripture_chapter = find_scripture_chapter(chapter_number)
            if verse_number.present?
              if 1..scripture_chapter['verse_count']).include? verse_number
                "Scripture reference exists"
              else
                "Book does not exist"
              end
            else
              "Scripture reference exists"
            end
          else
            "Book does not exist"
          end
        else 
          "Scripture reference exists"
        end
      else #book does not exist
        "Book does not exist"
      end
    end
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

end
