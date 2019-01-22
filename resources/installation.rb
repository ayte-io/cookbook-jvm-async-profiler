resource_name :jvm_async_profiler_installation

attribute :path, [String, Symbol], name_attribute: true
attribute :version, [String, Symbol], default: '1.5'

action_class do
  def architecture
    architecture = node['kernel']['machine']
    case architecture
    when 'x86_64'
      :x64
    when /arm/
      :arm
    else
      raise "Current architecture (#{architecture}) is not supported, " \
        'expected ARM or x86_64'
    end
  end

  def os
    os = node['os']
    case os
    when 'linux'
      'linux'
    when 'darwin'
      'macos'
    else
      raise "Current OS (#{os}) is not supported, expected Linux or MacOS"
    end
  end

  def source_uri
    version = new_resource.version
    'https://github.com/jvm-profiling-tools/async-profiler/releases/download/' \
      "v#{version}/async-profiler-#{version}-#{os}-#{architecture}.tar.gz"
  end
end

action :create do
  cache_path = Chef::Config[:file_cache_path]
  archive_name = "#{new_resource.version}.tar.gz"
  artifact_directory = ::File.join(cache_path, 'ayte', 'jvm-async-profiler')
  artifact_path = ::File.join(artifact_directory, archive_name)

  directory artifact_directory do
    recursive true
  end

  # noinspection RubyResolve
  remote_file artifact_path do
    source source_uri
    not_if { ::File.exist?(artifact_path) }
  end

  canary_file = ::File.join(new_resource.path, 'VERSION')
  version = new_resource.version
  if ::File.exist?(canary_file) && ::File.read(canary_file).strip != version
    directory new_resource.path do
      recursive true
      action :delete
    end
  end

  # noinspection RubyResolve
  tar_extract artifact_path do
    target_dir new_resource.path
    creates ::File.join(new_resource.path, 'profiler.sh')
    action :extract_local
  end

  file canary_file do
    content "#{version}\n"
  end
end

action :remove do
  directory new_resource.path do
    recursive true
    action :delete
  end
end
