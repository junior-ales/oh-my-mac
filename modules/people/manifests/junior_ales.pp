class people::junior_ales {

  include iterm2::stable
  include iterm2::colors::solarized_dark
  include iterm2::colors::solarized_light

  # Mac OS configuration
  include osx::global::enable_standard_function_keys
  include osx::global::tap_to_click
  include osx::dock::autohide
  include osx::software_update
  include osx::keyboard::capslock_to_control

  osx::dock::hot_corner { 'Start Screen Saver':
    position => 'Top Right',
    action => 'Start Screen Saver',
  }

  $home     = "/Users/${::boxen_user}"
  $dotfiles = "${home}/Project/dotfiles"

  file { "${home}/bin": ensure => "directory", }

  repository { $dotfiles:
    source  => "junior-ales/dotfiles",
    require => File["${home}/bin"],
  }

  repository { "${home}/.vim/bundle/Vundle.vim":
    source  => "gmarik/Vundle.vim",
    require => File["${home}/.vimrc"],
  }

  exec { "install vundle packages":
    command => "vim +PluginInstall +qall!",
    require => Repository["${home}/.vim/bundle/Vundle.vim"],
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
    target => "${dotfiles}/scripts/customFunctions.bash",
    require => Repository["${dotfiles}"],
  }

  file { "${home}/Project/oh-my-mac":
    ensure => link,
    mode   => "0644",
    target => $boxen::config::repodir,
    require => Repository["${dotfiles}"],
  }
}
