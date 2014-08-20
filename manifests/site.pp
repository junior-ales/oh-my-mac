require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  include git
  include hub

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  include nodejs::v0_10
  ruby::version { '2.1.2': }

  include brewcask

  package { 'adium'                      : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'google-drive'               : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'vlc'                        : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'virtualbox'                 : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'gimp'                       : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'rdio'                       : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'caffeine'                   : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'intellij-idea'              : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'iterm2'                     : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'limechat'                   : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'evernote'                   : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'send-to-kindle'             : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'vagrant'                    : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'sqlite-database-browser'    : provider => 'brewcask', install_options => "--appdir=/Applications" }
  package { 'skitch'                     : provider => 'brewcask', install_options => "--appdir=/Applications" }

  package { [  'vim', 'tree', 'archey', 'leiningen', 'gradle', 'ack', 'findutils', 'gnu-tar', 'maven' ]: }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}
