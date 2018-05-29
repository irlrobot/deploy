Gem::Specification.new do |spec|
    spec.name = 'dtot'
    spec.version = '1.0.0'
    spec.date = '2018-05-28'
    spec.summary = 'Do This On That'
    spec.description = 'Do This On That (dtot) sequentially runs commands on one or more hosts in the specified order.'
    spec.authors = ['Josh Campbell']
    spec.email = 'josh@userdel.com'
    spec.files = ['bin/dtot', 'LICENSE.txt', 'README.md']
    spec.executables = ['dtot']
    spec.homepage = 'https://github.com/irlrobot/dothisonthat'
    spec.license = 'MIT'
    spec.required_ruby_version = '>= 2.0.0'
    spec.add_runtime_dependency 'net-ssh', '~> 4.2'
  end