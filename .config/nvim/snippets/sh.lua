return {
    s("shebang", {
        t({"#!/bin/bash", "# -*- coding: utf-8 -*-", ""}),
    }),
    s("scriptdir", {
        t({"SCRIPT_DIR=$( cd -- \"$( dirname -- \"${BASH_SOURCE[0]}\" )\" &> /dev/null && pwd )"})
    }),
}
