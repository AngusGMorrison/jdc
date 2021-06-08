module Services
  class Blog
    def self.get(page:)
      raw_blog_posts = Adapters::Blog.get(page: page)
      Domain::BlogPostCollection.from_raw(raw_blog_posts)
    rescue Adapters::Errors::HttpError
      Domain::BlogPostCollection.new([Domain::BlogPost.default])
    end
  end
end
