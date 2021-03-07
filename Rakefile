require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob("spec/**/*_spec.rb")
  t.rspec_opts = "--color --format documentation --tty"
end

task default: :spec
