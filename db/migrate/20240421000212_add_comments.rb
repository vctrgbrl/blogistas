class AddComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :post
      t.text :body
      t.timestamps
    end
  end
end
