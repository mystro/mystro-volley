class Jobs::Volley::Destroy::Branch < Jobs::Volley::Base
  def work
    info "destroy branch #{model.to_s}"
    publisher.delete_branch(model.project.name, model.name)
  ensure
    model.destroy
  end
end
