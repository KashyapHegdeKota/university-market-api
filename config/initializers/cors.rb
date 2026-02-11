Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Change this to your Vercel URL later for security
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end