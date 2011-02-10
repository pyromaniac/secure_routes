module SecureRoutes
  module RouteSet

    def self.included base
      base.class_eval do
        alias_method_chain :url_for, :secure
      end
    end

    def url_for_with_secure options
      if Rails.application.config.action_dispatch.secure_routes
        options[:only_path] = false if (options[:secure] === true && options[:protocol] == 'http://') || (options[:secure] === false && options[:protocol] == 'https://')
        options[:protocol] = 'http://' if options[:secure] === false
        options[:protocol] = 'https://' if options[:secure] === true
      end
      url_for_without_secure options
    end

  end
end

ActionDispatch::Routing::RouteSet.send :include, SecureRoutes::RouteSet
