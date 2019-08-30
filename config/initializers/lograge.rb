require 'lograge/sql/extension'

Rails.application.configure do
  config.lograge.enabled = true

  config.lograge.custom_options = lambda do |event|
    { time: Time.now.to_i }
  end
end