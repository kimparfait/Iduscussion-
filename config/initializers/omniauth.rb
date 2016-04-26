Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV[544891255681050], ENV['1508af695fec1039d05e67dab635b8a3']
end