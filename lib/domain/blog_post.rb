require "redcarpet"

module Domain
  class BlogPost
    DEFAULT_PARAMS = {
      title: "It's all gone wrong...",
      hero_image: image_url("/gifs/tesseract.gif"),
      body: "We couldn't reach the blog server, so here's a placeholder. \
        Why do we have a separate server for our blog, you ask? Isn't that \
        needlessly complex, inviting failures that wouldn't happen if we just \
        stuffed our blog posts in a Postgres text column? The simple answer is \
        that we're filled with regret and your smugness is unattractive, but \
        hey, we've all learned something.",
      created_at: Time.zone.now
    }.freeze

    def self.default
      new(DEFAULT_PARAMS)
    end

    attr_reader :title, :hero_image, :body, :created_at

    def initialize(raw_blog_post)
      @title = raw_blog_post[:title]
      @hero_image = raw_blog_post[:hero_image]
      @body = raw_blog_post[:body]
      @created_at = raw_blog_post[:created_at]
    end

    def html_body
      return @html_body if @html_body.present?

      @html_body = Services::BlogPostParser.instance.to_html(body)
    end
  end
end
