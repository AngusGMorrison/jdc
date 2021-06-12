class BlogController < ApplicationController
  expose :blog_posts, fetch: -> { Services::Blog::Adapter.get(page: page) }

  private

  def page
    params[:page] || 1
  end
end
