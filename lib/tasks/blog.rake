module Blog
  extend Rake::DSL

  namespace :blog do
    desc "Create BlogPost records from markdown files"
    task ingest: [:environment] do
      paths = ARGV.drop(1)
      abort("usage: rake blog:ingest path/to/post1.md ...") if paths.empty?

      paths.each(&Services::Blog::PostIngestor.method(:ingest))
    end
  end
end
