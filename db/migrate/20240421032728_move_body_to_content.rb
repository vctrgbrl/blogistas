class MoveBodyToContent < ActiveRecord::Migration[7.0]
  def change
    Post.all.find_each do |p|
      Post.update(content: p.body)
    end

    remove_column :posts, :body
  end
end
