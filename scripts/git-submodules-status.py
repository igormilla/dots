#!/usr/bin/env python
import subprocess
import argparse

parser = argparse.ArgumentParser(description='Better git submodule status')
parser.add_argument("--status", help="print srtatus of submodules", action="store_true")
parser.add_argument("--short", help="don't print unchanged submodules", action="store_true")
args = parser.parse_args()

class colors:
    MAGENTA = '\033[95m'
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    ENDC = '\033[0m'

def cprint(color, line):
    print color + line + colors.ENDC

def has_changes(folder):
    cmd = "git -C " + folder + " status --short | wc -l"
    ps = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    output = ps.communicate()[0]
    return int(output.strip()) > 0

def submodule_status(folder):
    cmd = cmd = ["git", "-C", folder, "status", "--short"]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    for line in proc.stdout.readlines():
        print "  " + line.rstrip()

cmd = ["git", "submodule", "status"]
proc = subprocess.Popen(cmd, stdout=subprocess.PIPE)
for line in proc.stdout.readlines():
    line = line.rstrip()
    if not line.startswith('-'):
        submodule = line.split()[1]
        if has_changes(submodule):
            line = line[:0] + '*' + line[1:]
            cprint(colors.MAGENTA, line)
            if args.status:
                submodule_status(submodule)
        elif line.startswith('+'):
            cprint(colors.GREEN, line)
        else:
            if not args.short:
                print line
    else:
        cprint(colors.RED, line)



