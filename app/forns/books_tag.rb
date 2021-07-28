class BooksTag

  include ActiveModel::Model
  attr_accessor :title,:body,:user_id,:book_id,:tag_ids

  def save
    @book = Book.create(title: title, body: body, user_id: user_id)
    tag_list = tag_ids.split(/[[:blank:]]+/).select(&:present?)
    tag_list.each do |tag_name|
      @tag = Tag.where(name: tag_name).first_or_initialize
      @tag.save
      unless BookTag.where(book_id: @book.id,tag_id: @tag.id).exists?
        BookTag.create(book_id: @book.id, tag_id: @tag.id)
      end
    end
  end
end