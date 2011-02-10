module SecureRoutes
  module Mapper

    def self.included base
      base.class_eval do
        alias_method_chain :match, :secure
      end
    end

    def match_with_secure path, options
      if Rails.application.config.action_dispatch.secure_routes
        options_ssl = options[:secure]
        options_without_ssl = options.dup
        options_without_ssl.delete(:as)

        ssl = @scope[:secure] === true || options_ssl === true
        no_ssl = @scope[:secure] === false || options_ssl === false
        options.deep_merge! :constraints => { :protocol => 'https://' } if ssl
        options.deep_merge! :constraints => { :protocol => 'http://' } if no_ssl

        match_without_secure path, options

        match_without_secure path, options_without_ssl.merge(:to => redirect {|p, req| req.url.gsub(/^http/, 'https') }) if ssl
        match_without_secure path, options_without_ssl.merge(:to => redirect {|p, req| req.url.gsub(/^https/, 'http') }) if no_ssl
      else
        match_without_secure path, options
      end
    end
  end
end

ActionDispatch::Routing::Mapper::Base.send :include, SecureRoutes::Mapper
