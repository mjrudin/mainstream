class AddArticleToUrl < ActiveRecord::Migration
  def change
    add_column :urls, :article, :text
  end
end
