module BooksHelper

  def title(book)
    book['volumeInfo']['title']
  end

  def authors(book)
    authors = book["volumeInfo"]["authors"]
    authors ? "#{authors.join(', ')}" : 'Unattributed author(s)'
  end

  def thumbnail(book, options={})
    images?(book) ? (image_tag thumbnail_url(book), options) : 'no image'
  end

  def images?(book)
    !!book['volumeInfo']['imageLinks']
  end

  def snippet(book)
    snippet?(book) ? book["searchInfo"]["textSnippet"] : 'There is no text snippet available for this song.'
  end

  def snippet?(book)
    !!book['searchInfo']
  end


  def thumbnail_url(book)
    images?(book) ? book['volumeInfo']['imageLinks']['thumbnail'] : 'no image'
  end

  def page_count(book)
    book['volumeInfo']['pageCount']
  end

  def most_recent_books(user, count=3)
    #Returns last 3 books added to user's profile
    user.books.reverse.first(count)
  end

end
