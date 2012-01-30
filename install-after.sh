#!/bin/sh
#
# install-after.sh -- Custom installation
#
# The script will receive one argument: relative path to
# installation root directory. Script is called like:
#
#    $ install-after.sh .inst
#
# This script is run after [install] command.

PATH="/sbin:/usr/sbin/:/bin:/usr/bin:/usr/X11R6/bin"
LC_ALL="C"

Cmd()
{
    echo "$@"
    [ "$test" ] && return
    "$@"
}

Main()
{
    root=${1:-".inst"}

    if [ "$root"  ] && [ -d $root ]; then

        root=$(echo $root | sed 's,/$,,')  # Delete trailing slash
    	docdir=$(cd $root/usr/share/doc/[a-z]*[0-9] && pwd)

    	[ "$docdir" ] || return 0

        echo ">> Copying example scripts"

	dest=$docdir/examples

	Cmd install -d -m 755 $dest
        tar --dereference -cf - script* | tar -C $dest -xf -

    fi
}

Main "$@"

# End of file
