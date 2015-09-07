#!/bin/sh
git clone git://github.com/tokuhirom/plenv.git ~/.plenv
echo 'export PATH=$HOME/.plenv/bin:$PATH' >> ~/.zshrc.local
echo 'eval "$(plenv init -)"' >> ~/.zshrc.local
git clone git://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/
