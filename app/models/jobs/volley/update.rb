class Jobs::Volley::Update < Jobs::Volley::Base
  def work
    init
    projects = publisher.projects
    projects.each do |p|
      #info "* #{p}"
      project = MystroVolley::Project.find_or_create_by(name: p)
      publisher.branches(p).each do |b|
        #info "  * #{b}"
        branch = MystroVolley::Branch.find_or_create_by(name: b, project_id: project.id)
        publisher.versions(p, b).each do |v|
          #info "    * #{v}"
          o = publisher.version_data(p, b, v)
          d = {
              files: o[:contents],
              timestamp: o[:timestamp].to_time,
              latest: o[:latest]
          }
          version = MystroVolley::Version.find_or_create_by(name: v, branch_id: branch.id)
          version.update_attributes(d)
        end
      end
    end
    true
  end
end