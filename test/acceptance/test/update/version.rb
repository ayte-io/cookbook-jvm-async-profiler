describe bash('/usr/local/bin/jvm-async-profiler') do
  its('stdout') { should_not match '--version' }
end
