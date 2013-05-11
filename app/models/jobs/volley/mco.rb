require 'mcollective'

class Jobs::Volley::Mco < Jobs::Volley::Base
  include ::MCollective::RPC
  def rpcclient
    MCollective::RPC::Client.new("volley", options: {config: "#{Rails.root}/config/mcollective/client.cfg"})
  end
end
