module Simpler
  class Router
    class Route
      attr_reader :controller, :action, :param

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(method, path)
        if @param = @path[/:\S+/]
          controller = @path[/\w+/]
          obtain_hash_param(path)
          @method == method && path[/\/#{controller}\/\d+$/]
        else
          @method == method && path[/^#{@path}$/]
        end
      end

      def obtain_hash_param(path)
        param_name = @param[/\w+/].to_sym
        param_value = path[/\d+/].to_i
        @param = { param_name => param_value }
      end
    end
  end
end
