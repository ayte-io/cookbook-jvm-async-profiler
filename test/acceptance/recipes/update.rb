include_recipe 'ayte-jvm-async-profiler-acceptance::default'

%i[1.5 1.3].each do |version|
  jvm_async_profiler '/usr/local/share/jvm-async-profiler' do
    version version
    launcher '/usr/local/bin/jvm-async-profiler'
  end
end
