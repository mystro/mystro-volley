require "mystro-common"
require "volley"

module Mystro
  module Plugin
    module Volley
      include Mystro::Plugin::Base

      register ui: "/plugins/volley",
               schedule: {
                   volley: "*/10 * * * *",
               },
               jobs: [
                   "Jobs::Volley::Update",
                   "Jobs::Volley::Meta"
               ]

      class << self
        def configure
          @config ||= config_for self
          ::Volley::Dsl::VolleyFile.load("config/volley/volleyfile", primary: true)
          @pub ||= ::Volley::Dsl.publisher
        end

        def test
          configure
          @pub.projects
        end
      end
    end
  end
end
