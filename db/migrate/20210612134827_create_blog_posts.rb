class CreateBlogPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :hero_image_path
      t.string :html_body

      t.timestamps
    end
  end
end
