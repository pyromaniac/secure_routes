Dummy::Application.routes.draw do
  match 'ssl_action' => 'ssl#ssl_action', :secure => true
  match 'action' => 'ssl#action'
  match 'no_ssl_action' => 'ssl#no_ssl_action', :secure => false
end
