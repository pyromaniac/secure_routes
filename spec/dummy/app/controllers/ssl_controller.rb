class SslController < ApplicationController

  def ssl_action
    render 'action'
  end

  def action
    render 'action'
  end

  def no_ssl_action
    render 'action'
  end

end
