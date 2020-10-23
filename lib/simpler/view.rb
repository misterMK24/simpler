require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      template = File.read(template_path)
      ERB.new(template).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end
    
    def custom_format
      format = @env['simpler.format']
      return nil if format == :html || format.nil?
      
      format.to_s
    end

    def template_path
      path = template || [controller.name, action].join('/')
      format = custom_format || "html.erb"
      render_template = "#{path}.#{format}"
      @env['simpler.render_template'] = render_template
      Simpler.root.join(VIEW_BASE_PATH, render_template)
    end

  end
end
