# Valt

Do you ever use multiple VIM configs on the same box (say.. for pairing?).

Wouldn't it be nice if you could switch configurations with a short command?

Enter [Valt](http://github.com/zph/valt).  

Valt lets you store different user <code>.vim</code> and <code>.vimrc</code> files under profiles and quickly install them with a single command.

To get started

    valt init
    valt install zph https://github.com/zph/zph # dotfiles project with .vim and .vimrc in them
    valt install marksim https://github.com/marksim/.dotfiles
    valt use zph
    # do your VIM session with ZPH's config
    valt use marksim
    # do your VIM session with marksim's config
    vim 
    # use user level ~/.vim and ~/.vimrc

And you're done.


## Installation

Install it yourself as:

    $ gem install valt

## Usage

#### Initialize

    valt init
      #TODO: init structure
      # create ~/.valtrc
      # create ~/.valt.d
      # fill basic hooks in ~/.valt.d

#### Install

    valt install <profile>
      # cp -R ~<profile>/.vim ~/.valt.d/<profile>
      # cp -R ~<profile>/.vimrc ~/.valt.d/<profile>

    valt install <profile> <directory>
      # cp -R <directory> ~/.valt.d/<profile>/<directory>

    valt install <profile> <git-repo-url>
      # git clone <git-repo-url>
      # valt install <profile> -- > 
      # remove/cleanup git repo 

#### Use

    valt # uses profile from ~/.valtrc

    valt use <profile>


#### Discover

    valt list # show available profiles

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
