OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "209495965909628", "b3fa8b1c7c6c3ef2a6ce545be19169e8"
end