#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Find and replace utility based on ripgrep and sed."""

import click
import os
import subprocess
import platform
from multiprocessing.pool import ThreadPool
from typing import List

def find_files(replace_what : str, workdir : str) -> List[str]:
    cmd = [ 'rg', '-l', '--hidden', '-g', '!.git', replace_what ]

    # Run ripgrep to find files containing the string
    result = subprocess.run(cmd, stdout=subprocess.PIPE, text=True,
                            cwd=workdir)
    files = result.stdout.splitlines()
    return files

def replace_in_file(file : str, replace_what : str, replace_to : str) -> None:
    esc_replace_what = replace_what.replace('/', '\\/')
    esc_replace_to = replace_to.replace('/', '\\/')

    # The MacOS/BSD sed command requires an empty string after -i
    # (the backup extension option). GNU/Linux sed does not require this.
    if platform.system() == 'Darwin':
        cmd = ['sed', '-i', '', f's/{esc_replace_what}/{esc_replace_to}/g', file]
    else:
        # Expect GNU/Linux sed
        cmd = ['sed', '-i', f's/{esc_replace_what}/{esc_replace_to}/g', file]
    subprocess.run(cmd)

@click.command()
@click.argument('replace_what', type=str)
@click.argument('replace_to', type=str)
@click.option('--workdir', '-w', type=click.Path(exists=True),
              default=os.getcwd(), help='Working directory to search in.')
@click.option('--dry-run', '-d', is_flag=True,
              help='Perform a dry run without making changes.')
def find_replace(replace_what : str, replace_to : str, workdir : str,
                 dry_run : bool) -> None:
    """Find and replace utility based on ripgrep and sed.

    Args:

        - replace_what (str): String to be replaced.

        - replace_to (str): String to replace with.
    """

    files = find_files(replace_what, workdir)

    tp = ThreadPool()
    for file in files:
        if dry_run:
            print(f". {file} [skipped]")
            continue
        print(f". {file}")
        tp.apply_async(replace_in_file, (file, replace_what, replace_to))
    tp.close()
    tp.join()

if __name__ == '__main__':
    find_replace()

