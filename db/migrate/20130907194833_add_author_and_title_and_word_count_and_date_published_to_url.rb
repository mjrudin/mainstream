class AddAuthorAndTitleAndWordCountAndDatePublishedToUrl < ActiveRecord::Migration
  def change
    add_column :urls, :author, :string
    add_column :urls, :title, :string
    add_column :urls, :word_count, :integer
    add_column :urls, :date_published, :string
  end
end
