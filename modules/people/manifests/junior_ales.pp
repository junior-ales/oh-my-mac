class people::junior_ales {

  include iterm2::colors::solarized_dark
  include chrome
  include vlc
  include virtualbox
  include gimp
  include libreoffice
  include rdio
  include vundle
  include caffeine

  class { 'intellij':
      edition => 'ultimate',
      version => '13.1.1'
  }

  package {[ "vim", "tree", "archey", "leiningen" ]:}

  $home     = "/Users/${::boxen_user}"
  $dotfiles = "${home}/Project/dotfiles"

  repository { $dotfiles:
    source  => "junior-ales/dotfiles",
  }

  file { "${home}/.vimrc":
    ensure => link,
    mode   => "0644",
    target => "${dotfiles}/.vimrc",
    require => Repository["${dotfiles}"],
  }

  file { "${home}/.bash_profile":
    ensure => link,
    mode   => "0644",
    target => "${dotfiles}/.bash_profile",
    require => Repository["${dotfiles}"],
  }

  file { "${home}/.gitconfig":
    ensure => link,
    mode   => "0644",
    target => "${dotfiles}/.gitconfig",
    require => Repository["${dotfiles}"],
  }

  file { "${home}/bin/customFunctions.bash":
    ensure => link,
    mode   => "0754",
    content => "${dotfiles}/scripts/customFunctions.bash",
    require => Repository["${dotfiles}"],
  }
}
