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

  def snippet(book)
    book["searchInfo"]
  end

  def images?(book)
    !!image_url(book)
  end

  def thumbnail_url(book)
    book['volumeInfo']['imageLinks']['thumbnail']
  end

end
