require "http"

module Services
  module Blog
    class Adapter
      CMS_HOST = Rails.application.credentials.cms[:host]
      CMS_PORT = Rails.application.credentials.cms[:port]
      BLOG_URL = "#{CMS_HOST}:#{CMS_PORT}/blog-posts"

      def self.get(page: 1)
        new(page: page).get
      end

      def initialize(page:)
        @page = page
      end

      def get
        resp = HTTP.get(BLOG_URL)
        resp.status.success? ? to_posts(resp) : PostCollection.default
      end

      private

      def to_posts(resp)
        raw_blog_posts = JSON.parse(resp.body.to_s, symbolize_names: true)
        PostCollection.from_raw(raw_blog_posts)
      end
    end
  end
end
