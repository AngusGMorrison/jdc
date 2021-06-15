# == Schema Information
#
# Table name: blog_posts
#
#  id                  :uuid             not null, primary key
#  hero_image_alt_text :string
#  hero_image_path     :string
#  markdown            :string
#  title               :string
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_blog_posts_on_created_at  (created_at)
#
class BlogPost < ApplicationRecord
  self.implicit_order_column = "created_at"

  def html
    @html ||= Services::Blog::PostParser.instance.to_html(markdown)
  end
end
