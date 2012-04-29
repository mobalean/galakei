module Galakei::RouteConstraints
=begin
Galakei usually doesn't support PUT / DELETE requests, so you sometimes need to define somes for galakei. Use this route constraint to restrict those routes to requests from galakei only.

Example routes:

  put 'resend'
  get 'resend', :constraints => Galakei::RouteConstraints::GalakeiOnly

=end
  module GalakeiOnly
    def self.matches?(request)
      request.galakei?
    end
  end
end
