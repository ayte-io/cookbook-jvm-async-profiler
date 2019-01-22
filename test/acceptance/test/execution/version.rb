describe bash('/usr/local/bin/jvm-async-profiler -v') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match '1.5' }
end
