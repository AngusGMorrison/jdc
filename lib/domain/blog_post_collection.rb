module Domain
  class BlogPostCollection
    include Enumerable

    def self.from_raw(raw_blog_posts)
      blog_posts = raw_blog_posts.map(&BlogPost.method(:new))
      new(blog_posts)
    end

    attr_reader :blog_posts

    def initialize(blog_posts)
      @blog_posts = blog_posts
    end

    def each(&block)
      blog_posts.each(&block)
    end
  end
end
