module SecureRoutes
  module Options

    def self.included base
      base.class_eval do
        config.action_dispatch.secure_routes = false
      end
    end

  end
end

ActionDispatch::Railtie.send :include, SecureRoutes::Options
