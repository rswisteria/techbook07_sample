require 'lograge/sql/extension'

Rails.application.configure do
  config.lograge.enabled = true

  config.lograge.custom_options = lambda do |event|
    { time: Time.now.to_i }
  end
  config.lograge_sql.extract_event = Proc.new do |event|
    { name: event.payload[:name], duration: event.duration.to_f.round(2), sql: event.payload[:sql] }
  end
  config.lograge_sql.formatter = Proc.new do |sql_queries|
    sql_queries
  end
end