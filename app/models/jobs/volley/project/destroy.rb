class Jobs::Volley::Project::Destroy < Job
  def work
    info "destroy project #{model.name}"

  end
end