#!/usr/bin/env python3

from i3ipc import Connection
import sys

def next():
    workspaces = i3.get_workspaces()
    next = 1
    for ws in sorted(workspaces, key=lambda w: w.num):
        if next < ws.num:
            break
        else:
            next+=1
    return next

i3 = Connection()

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "move":
        new = next()
        i3.command("move container workspace number %d" % new )
        # TODO: rename old workspace too!
        i3.command("workspace number %d" % new )
    else:
        i3.command( "workspace number %d new" % next() )
