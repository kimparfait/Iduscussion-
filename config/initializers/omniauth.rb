Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '544891255681050' , '1508af695fec1039d05e67dab635b8a3 ', :iframe => true
end