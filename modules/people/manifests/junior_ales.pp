class people::junior_ales {

  package {[ "vim", "tree", "archey" ]:}

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
