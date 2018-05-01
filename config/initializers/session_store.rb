# config/initializers/session_store.rb
# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_[[name]]_session', domain: :all # tld_length info here: http://stackoverflow.com/questions/10402777/share-session-cookies-between-subdomains-in-rails/15009883#15009883