class Jobs::Volley::Meta < Jobs::Volley::Mco
  def work
    init
    client = rpcclient
    list = client.meta()
    list.each do |o|
      #info "o: #{o.inspect}"
      sender = o[:sender]
      data = o[:data]
      out = data[:out]
      next unless out

      record = ::Record.where(name: sender).first
      if record
        if record.nameable && record.nameable.class == ::Compute
          compute = record.nameable
        else
          compute = ::Compute.find_by_record(record)
        end
      end

      MystroVolley::Install.where(compute: compute).destroy_all if compute

      out.lines.each do |l|
        (p,v) = l.chomp.split(" => ")
        n = "#{p}@#{v}"
        version = MystroVolley::Version.find_by_name(n)

        info "#{sender} (#{compute}): #{n} (#{version})"
        if compute && version
          install = MystroVolley::Install.create(compute: compute, version: version)
          install.updated_at = Time.now
          install.save
        end
      end
    end
    true
  end
end
