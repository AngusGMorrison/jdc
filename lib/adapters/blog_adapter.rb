require "http"

module Adapters
  class Blog
    BLOG_URL = "#{Rails.application.credentials.cms[:url]}/blog-posts"

    def self.get
      # Auth
      resp = HTTP.get(BLOG_URL)
      if resp.status.success?
        raise Errors::HttpError.new(resp.code, resp.reason)
      else

      JSON.parse(resp.body.to_s)
    end
  end
end
