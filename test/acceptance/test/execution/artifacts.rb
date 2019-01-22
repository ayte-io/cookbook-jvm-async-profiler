describe file('/tmp/result') do
  it { should exist }
  its('content') { should match /\d+/ }
end

describe file('/tmp/graph.svg') do
  it { should exist }
  its('size') { should be > 4096 }
end
