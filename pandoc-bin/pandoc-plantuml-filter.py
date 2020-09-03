#!/usr/bin/env python

"""
Pandoc filter to process code blocks with class "plantuml" into
plant-generated images.
Needs `plantuml.jar` from http://plantuml.com/.
"""
import json
import os
import subprocess
import sys
from time import sleep

from pandocfilters import get_filename4code, get_caption, get_extension
from pandocfilters import toJSONFilter, Para, Image


def printToFile(*vals):
    with open("log.txt", "a") as f:
        for val in vals:
            val = json.dumps(val)
            f.write(val)
            f.write("\n")
        f.write("\n")


PLANTUML_BIN = os.environ.get('PLANTUML_BIN', 'plantuml')


def rel_mkdir_symlink(src, dest):
    dest_dir = os.path.dirname(dest)
    if not os.path.exists(dest_dir):
        os.makedirs(dest_dir)

    if os.path.exists(dest):
        os.remove(dest)

    src = os.path.relpath(src, dest_dir)
    os.symlink(src, dest)


def plantuml(key, value, format_, _):
    # printToFile("key", key, "value", value)

    if key == 'CodeBlock':
        [[ident, classes, keyvals], code] = value

        if "plantuml" in classes:
            caption, typef, keyvals = get_caption(keyvals)

            filename = get_filename4code("plantuml", code)
            filetype = get_extension(format_, "svg", html="svg", latex="svg")

            src = filename + '.uml'
            dest = filename + '.' + filetype

            # Generate image only once
            if not os.path.isfile(dest):
                txt = code.encode(sys.getfilesystemencoding())
                if not txt.startswith(b"@start"):
                    txt = b"@startuml\n" + txt + b"\n@enduml\n"
                with open(src, "wb") as f:
                    f.write(txt)
                counter = 0
                while counter < 5 and not os.path.isfile(src):
                    sleep(0.2)

                # printToFile("src", src)
                # printToFile(PLANTUML_BIN.split())
                subprocess.check_call(PLANTUML_BIN.split() +
                                      ["-t" + filetype, src])
                sys.stderr.write('Created image ' + dest + '\n')

            # Update symlink each run
            for ind, keyval in enumerate(keyvals):
                if keyval[0] == 'plantuml-filename':
                    link = keyval[1]
                    keyvals.pop(ind)
                    rel_mkdir_symlink(dest, link)
                    dest = link
                    break

            return Para([Image([ident, [], keyvals], caption, [dest, typef])])


def main():
    toJSONFilter(plantuml)


if __name__ == "__main__":
    main()
