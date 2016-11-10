require 'json'

module CodeclimateBatch
  class << self
    # Start TestReporter with appropriate settings.
    # Note that Code Climate only accepts reports from the default branch (usually master, but can be changed)
    # but records coverage on all PRs and displays their coverage difference

    def unify(coverage_files)
      ([{}] + coverage_files).reduce { |hash, path| hash.merge(load(path)) }
    end

    private

    # Return the default branch. Most of the time it's master, but can be overridden
    # by setting DEFAULT_BRANCH in the environment.
    def default_branch
      ENV['DEFAULT_BRANCH'] || 'master'
    end

    # Check if we are running on Travis CI.
    def travis?
      ENV['TRAVIS']
    end

    def load(file)
      JSON.load(File.read(file))
    end
  end
end
