#!/usr/bin/env python3

from i3ipc import Connection
import sys

def next():
    workspaces = i3.get_workspaces()
    next = 1
    for ws in workspaces:
        if next < ws.num:
            break
        else:
            next+=1
    return next

if __name__ == "__main__":
    i3 = Connection()
    if len(sys.argv) > 1 and sys.argv[1] == "move":
        i3.command("move container to workspace number %d" % next() )
    else:
        i3.command( "workspace number %d new" % next() )
