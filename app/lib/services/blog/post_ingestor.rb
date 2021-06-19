module Services
  module Blog
    # PostIntegestor reads the markdown file at path, extracting the title, path
    # to the hero image and body, and creates a new BlogPost. Markdown tags are
    # removed from the title and image path, but the body is saved as markdown.
    #
    # Input blog posts must follow the following format:
    #
    # # Title
    #
    # ![Alt text](path/to/hero/image)
    #
    # Body
    class PostIngestor
      class FormatError < RuntimeError
        def initialize(path)
          super(<<~MSG)
            Unable to match BlogPost fields for #{path}. Markdown files must use the following format:"
            # Title

            ![Alt text](path/to/hero/image)

            Body
          MSG
        end
      end

      BLOG_POST_FORMAT = /\A# (?<title>.+)\n\n!\[(?<alt_text>.*)\]\((?<image_path>.+)\)\n\n(?<body>.+)\z/m

      # /\A# (?<title>.+)\n\n!\[(?<alt_text>.*)\]\((?<image_path>.+)\)\n\n(?<body>.+)\z/

      def self.ingest(path)
        new(path).ingest
      end

      attr_reader :path

      def initialize(path)
        @path = path
        @raw = File.read(path)
      end

      def ingest
        matches = @raw.match(BLOG_POST_FORMAT)
        raise FormatError.new(path) if matches.nil?

        BlogPost.create(
          title: matches[:title],
          hero_image_alt_text: matches[:alt_text],
          hero_image_path: matches[:image_path],
          markdown: matches[:body]
        )
      end
    end
  end
end
