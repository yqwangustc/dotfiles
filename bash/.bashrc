[ -n "$PS1" ] && source ~/.bash_profile

# A function to launch ipython notebooks
function ifbpynb { pushd ~/python; /usr/local/bin/ifbpy notebook --profile=nbserver; popd; }
. "$HOME/.cargo/env"
