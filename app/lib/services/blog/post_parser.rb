module Services
  module Blog
    class PostParser
      include Singleton

      PARSER_CONFIG = {
        fenced_code_blocks: true,
        space_after_headers: true,
        superscript: true,
        quote: true
      }.freeze

      def initialize
        @parser = Redcarpet::Markdown.new(Redcarpet::Render::HTML, **PARSER_CONFIG)
      end

      def to_html(markdown)
        @parser.render(markdown)
      end
    end
  end
end
