require 'byebug'
require_relative 'view'


module Simpler
  class Controller

    RENDERING_TEMPLATES = [:html, :plain, :json].freeze

    attr_reader :name, :request, :response
    # attr_accessor :response
    alias :headers :response 

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      return @request.env['simpler.template'] if @request.env['simpler.format'] == :plain

      View.new(@request.env).render(binding)
    end

    def params
      @request.params
    end

    def render(template)
      params = process_template(template)
      return nil unless params

      @request.env['simpler.format'] = params[:format]
      @request.env['simpler.template'] = params[:template]
    end

    def process_template(template)
      tmp_arr = template.flatten
      return nil unless RENDERING_TEMPLATES.any?(tmp_arr[0])

      { format: tmp_arr[0], template: tmp_arr[1] }
    end

    def status(code)
      @response.status = code
    end

  end
end
