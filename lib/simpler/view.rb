require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      template = File.read(template_path)

      # TODO: change rendering depending on format
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
      Simpler.root.join(VIEW_BASE_PATH, "#{path}.#{format}")
    end

  end
end
