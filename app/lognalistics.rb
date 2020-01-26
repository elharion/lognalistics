class Lognalistics
  def self.call(log_file = nil, options = {})
    log_file = log_file || File.open("webserver.log")
    log_data = log_file.read

    log_entries = log_data.each_line.with_object([]) do |entry_line, entries|
      path, ip = entry_line.split(" ")
      entries.push({ path: path, ip: ip })
    end

    if options.eql? :views
      log_entries.each.with_object(Hash.new(0)) do |entry, view_counter|
        view_counter[entry[:path]] += 1
      end.sort_by { |_path, count| -count }
    else
      unique_entries = log_entries.uniq { |path, ip| "#{path}-ip" }

      unique_entries.each.with_object(Hash.new(0)) do |entry, view_counter|
        view_counter[entry[:path]] += 1
      end.sort_by { |_path, count| -count }
    end
  end
end
