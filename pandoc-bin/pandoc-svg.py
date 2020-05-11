#! /usr/bin/env python
"""
Pandoc filter to convert svg files to pdf as suggested at:
https://github.com/jgm/pandoc/issues/265#issuecomment-27317316
"""
import json
from time import sleep

__author__ = "Jerome Robert"

import mimetypes
import subprocess
import os
import sys
from pandocfilters import toJSONFilter, Image


def printToFile(*vals):
    with open("log.txt", "a") as f:
        for val in vals:
            val = json.dumps(val)
            f.write(val)
            f.write("\n")
        f.write("\n")


fmt_to_option = {
    "latex": ("--export-pdf", "pdf"),
    "beamer": ("--export-pdf", "pdf"),
    # use PNG because EMF and WMF break transparency
    "docx": ("--export-png", "png"),
    # because of IE
    "html": ("--export-png", "png")
}


def svg_to_any(key, value, fmt, meta):
    if key == 'Image':
        # printToFile("key", key, "value", value)
        # # printToFile(value)
        if len(value) == 2:
            # before pandoc 1.16
            alt, [src, title] = value
            attrs = None
        else:
            attrs, alt, [src, title] = value
        mimet, _ = mimetypes.guess_type(src)
        option = fmt_to_option.get(fmt)
        # # printToFile(mimet)
        if mimet == 'image/svg+xml' and option:
            base_name, _ = os.path.splitext(src)
            eps_name = base_name + "." + option[1]
            try:
                mtime = os.path.getmtime(eps_name)
            except OSError:
                mtime = -1
            # printToFile("mtime", src, mtime, os.path.getmtime(src))
            if mtime < os.path.getmtime(src):
                cmd_line = ['inkscape', option[0], eps_name, src]
                # cmd_line = ['rsvg-convert', '--format', option[0], '-o', eps_name, src]
                # printToFile("Running %s\n" % " ".join(cmd_line))
                sys.stderr.write("Running %s\n" % " ".join(cmd_line))
                subprocess.call(cmd_line, stdout=sys.stderr.fileno())
                counter = 0
                while counter < 5 and not os.path.isfile(eps_name):
                    sleep(0.2)

            # printToFile("attrs", attrs, alt, [eps_name, title])
            if attrs:
                return Image(attrs, alt, [eps_name, title])
            else:
                return Image(alt, [eps_name, title])


if __name__ == "__main__":
    # printToFile("main")
    toJSONFilter(svg_to_any)
