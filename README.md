# Oh my Mac

This is a [Boxen](http://boxen.github.com/) project and the intent of it is to have my mac in any other mac I come to use.

### Instructions to replicate in a new mac

*  Install Command Line Tools;
*  Add the ssh key of the new mac to github;
*  Clone junior-ales/oh-my-mac to /opt/boxen/repo;
*  Set a high value for sudo timeout ___(why? how? keep reading)___;
*  Run /opt/boxen/repo/scripts/boxen;


#### Setting a high value for sudo timeout

__Why?__

This boxen script relys on brew cask to install the majority of its applications. As downloading the .dmg usually takes some time, when the sudo timeout is short brew cask doesn't have the credentials to install the downloaded app by the time it's locally available.

For sure that's not a great solution. Feel free to solve this, I'm eager for better ways to solve this.

__How?__

*  `sudo visudo` will open a file
*  Find `Defaults        env_reset` and change it to this:
*  `Defaults        env_reset,timestamp_timeout=30` where 30 is the amount of time in minutes

It's highly recommended to undo these changes as soon as boxen finishes its setup



