require 'lograge/sql/extension'

Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new

  config.lograge.custom_options = lambda do |event|
    now = Time.zone.now
    exceptions = %w(controller action format id)
    {
      params: event.payload[:params].except(*exceptions),
      unixtime: now.to_i,
      time: now.iso8601,
      exception: event.payload[:exception],
      exception_object: event.payload[:exception_object],
      backtrace: event.payload[:exception_object]&.backtrace
    }
  end
  config.lograge_sql.extract_event = Proc.new do |event|
    {
      name: event.payload[:name],
      duration: event.duration.to_f.round(2),
      sql: event.payload[:sql]
    }
  end
  config.lograge_sql.formatter = Proc.new do |sql_queries|
    sql_queries
  end
end