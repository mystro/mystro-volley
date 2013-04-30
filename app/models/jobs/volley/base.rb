require "volley"
require "volley/dsl"

class Jobs::Volley::Base < Job
  def init
    #::Volley::Dsl::VolleyFile.init
    ::Volley::Dsl::VolleyFile.load("#{Rails.root}/config/volley/volleyfile", primary: true)
  end

  def publisher
    ::Volley::Dsl.publisher
  end
end