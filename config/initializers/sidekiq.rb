Sidekiq.configure_server do |config|
  config.redis = {
    host: Rails.application.credentials.redis[:host],
    port: Rails.application.credentials.redis[:port] || "6379"
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    host: Rails.application.credentials.redis[:host],
    port: Rails.application.credentials.redis[:port] || "6379"
  }
end
