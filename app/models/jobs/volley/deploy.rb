class Jobs::Volley::Deploy < Jobs::Volley::Mco
  def work
    init

    info "DATA: #{data.inspect}"

    version = data["version"]
    environment = data["environment"]
    account = data["account"]
    role = data["role"]
    force = data["force"]

    r = rpcclient

    ["mystro.environment=#{environment}", "mystro.account=#{account}", "mystro.role_#{role}=true"].each do |f|
      puts "filter: #{f}"
      info "filter: #{f}"
      r.fact_filter f
    end

    list = r.run(descriptor: version)
    #list = r.meta()
    list.each do |o|
      r = o.results
      if r[:statuscode] == 0
        info "#{r[:sender]}: '#{r[:data][:status]}' #{r[:data][:out]}"

        #vs = r[:data][:out].split("\n")
        #vs.each do |v|
        #  puts "-- #{r[:sender]}: #{v}"
        #  info "-- #{r[:sender]}: #{v}"
        #end
      end
    end

    true
  end
end
