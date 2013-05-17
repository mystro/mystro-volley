class Jobs::Volley::Destroy::Project < Jobs::Volley::Base
  def work
    info "destroy project #{model.to_s}"
    publisher.delete_project(model.name)
  ensure
    model.destroy
  end
end
