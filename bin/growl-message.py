#!/usr/bin/env python
import sys
import subprocess


def notify(message, title):
    cmd = "growlnotify -m '%s' -t '%s' >> /dev/null 2>&1" % (message, title)
    subprocess.call(cmd, shell=True)


def main(message, title):
    if message.startswith('#'):
        return

    if 'thurloat:' in message:
        # Someone talking to me in the room
        who, where = title.split(' ')
        notify(message, '%s in %s' % (who, where))
        return

    elif message.startswith('thurloat :'):
        # Someone talking to me in a private message
        who, _ = title.split(' ')
        notify(message, '%s said' % who)
        return

    elif 'thurloat' in message:
        notify(message, 'thurloat mentioned')
        return
    else:
        return


if __name__ == '__main__':
    if len(sys.argv) == 3:
        main(sys.argv[1], sys.argv[2])

