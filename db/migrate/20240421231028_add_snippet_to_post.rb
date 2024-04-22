class AddSnippetToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :snippet, :string
  end
end
