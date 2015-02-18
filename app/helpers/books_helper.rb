module BooksHelper
  def title(book)
    "Title: #{book['volumeInfo']['title']}"
  end

  def authors(book)
    authors = book["volumeInfo"]["authors"]
    authors ? "#{authors.join(', ')}" : 'Unattributed author(s)'
  end

  def thumbnail(book, options={})
    image_tag book['volumeInfo']['imageLinks']['thumbnail'], options
  end

  def snippet(book)
    book["searchInfo"]
  end

end
