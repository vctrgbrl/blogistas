class AddRelationships < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user, foreign_key: true
    add_reference :comments, :user
  end
end
