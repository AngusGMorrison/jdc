class CreateBlogPosts < ActiveRecord::Migration[6.1]
  def change
    enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")

    create_table :blog_posts, id: :uuid do |t|
      t.string :title
      t.string :hero_image_path
      t.string :markdown

      t.datetime :created_at, index: true
      t.datetime :updated_at
    end
  end
end
