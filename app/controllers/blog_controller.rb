class BlogController < ApplicationController
  expose :blog_posts, :paginated_blog_posts

  private

  def paginated_blog_posts
    BlogPost.page(page).per(per)
  end

  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 10
  end
end
