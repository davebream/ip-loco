# frozen_string_literal: true

class DBConnectionCheckMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    return error_json unless database_connected?

    @app.call(env)
  end

  private

  def error_json
    [
      503,
      { 'Content-Type' => 'application/json' },
      [{ error: 'Could not connect to the DB' }.to_json]
    ]
  end

  def database_connected?
    ActiveRecord::Base.connection_pool.with_connection(&:active?)
  rescue StandardError
    false
  end
end
