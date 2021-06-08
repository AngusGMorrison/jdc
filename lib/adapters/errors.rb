module Adapters
  module Errors
    class HttpError < RuntimeError
      def initialize(code:, reason:)
        super("Remote service responded #{code} #{reason}")
      end
    end
  end
end
