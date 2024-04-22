class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_join_table :tags, :posts do |t|
      t.index :tag_id
      t.index :post_id
    end
  end
end
