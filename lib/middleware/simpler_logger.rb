require 'logger'

class SimplerLogger
  def initialize(app)
    @app = app
    @log = Logger.new("#{Simpler.root}/log/app.log")
  end

  def call(env)
    status, headers, body = @app.call(env)
    @request = Rack::Request.new(env)
    @log.info(log_request(env, status))
    [status, headers, body]
  end

  def log_request(env, status)
    [
      request_data(env),
      handler_data(env),
      parameters_data,
      response_data(status, env)
    ]
  end

  def request_data(env)
    main_string = "Request: #{env['REQUEST_METHOD']} #{env['PATH_INFO']}"
    query_str = env['QUERY_STRING']

    query_str.empty? ? main_string : "#{main_string}/?#{query_str}"
  end

  def handler_data(env)
    "Handler: #{env['simpler.controller'].class}##{env['simpler.action']}"
  end

  def parameters_data
    "Parameters: #{@request.params}"
  end

  def response_data(status, env)
    main_string = "Response: #{status} [#{env['CONTENT_TYPE']}]"
    render_template = env['simpler.render_template']

    render_template ? main_string + " #{render_template}" : main_string
  end
end
