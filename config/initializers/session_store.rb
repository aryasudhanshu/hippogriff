# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hippogriff_session',
  :secret      => '0e8cba6b761a563ad0e8c9c6d8ef0ad381dc9a71a244de876e13cf058b3d80bcee8f0c56ae912b566965118ee5f5d30ee5813b1e02a27ad248bb8a80bc5435c4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
