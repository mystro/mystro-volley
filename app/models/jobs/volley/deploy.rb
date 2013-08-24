class Jobs::Volley::Deploy < Jobs::Volley::Mco
  def work
    init

    d = JSON.parse(data.to_json)
    info "DATA: #{d.inspect}"

    version     = d["version"]
    environment = d["environment"]
    account     = d["account"]
    role        = d["role"]
    force       = d["force"]

    r = rpcclient

    ["mystro.environment=#{environment}", "mystro.account=#{account}", "mystro.role_#{role}=true"].each do |f|
      info "filter: #{f}"
      r.fact_filter f
    end

    list = r.run(descriptor: version)
    list.each do |o|
      rsp = o.results
      if rsp[:statuscode] == 0
        info "#{rsp[:sender]}: '#{rsp[:data][:status]}' #{rsp[:data][:out]}"
      end
    end

    (p, v) = version.split('@')
    info "version: #{p}"

    timeout = 60 * 10
    timer = 0
    count = 0
    begin
      list  = r.version(project: p)
      total = count = list.count

      list.each do |o|
        rsp        = o.results
        raise "error with host: #{rsp[:sender]}" unless rsp[:data] && rsp[:data][:version]
        (_, found) = rsp[:data][:version].chomp.split(" => ")
        info "#{rsp[:sender]}: #{v} = #{found}"

        count -= 1 if v == found
      end

      info "waiting on #{count} of #{total}: (timer: #{timer} <= #{timeout})"

      if count > 0
        timer += 5
        sleep 5
        self.save
      end
    end while count > 0 && timer <= timeout

    raise "deployment failed: count:#{count} timer:#{timer}" if count > 0 || timer > timeout

    true
  end
end
