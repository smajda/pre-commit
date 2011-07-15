class IpdbSetTrace

  attr_accessor :staged_files, :error_message

  def self.call(quiet=false)
    check = new
    check.staged_files = Utils.staged_files('.')

    result = check.run
    if !quiet && !result
      puts check.error_message
    end
    result
  end

  def run
    return true if staged_files.empty?
    if detected_bad_code?
      @error_message = "pre-commit: ipdb.set_trace found:\n"
      @error_message += instances_of_ipdb_violations
      false
    else
      true
    end
  end

  def detected_bad_code?
    system("grep -qe \"ipdb\\.set_trace\" #{staged_files}")
  end

  def instances_of_ipdb_violations
    `grep -nHe \"ipdb\\.set_trace\" #{staged_files}`
  end

end
