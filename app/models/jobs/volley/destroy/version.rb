class Jobs::Volley::Destroy::Version < Jobs::Volley::Base
  def work
    info "volley: #{Volley::Version::STRING}"
    info "destroy version #{model.to_s}"
    p = model.project
    b = model.branch
    v = model
    info "project: #{p.name}"
    info "branch:  #{b.name}"
    info "version: #{v.name}"
    raise "something wrong with version heirarchy" unless p && b && v
    publisher.delete_version(p.name, b.name, v.name)
  ensure
    model.destroy
  end
end
