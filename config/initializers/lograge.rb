require 'lograge/sql/extension'

Rails.application.configure do
  config.lograge.enabled = true

  config.lograge.custom_options = lambda do |event|
    now = Time.zone.now
    { unixtime: now.to_i, time: now.iso8601 }
  end
  config.lograge_sql.extract_event = Proc.new do |event|
    event.payload[:sql]
  end
  config.lograge_sql.formatter = Proc.new do |sql_queries|
    "'#{sql_queries.join("\\n")}'"
  end
end