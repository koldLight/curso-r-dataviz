#!/bin/sh

# Fail if something returns an error
set -e

# Render the quarto book
quarto render --to html

# Copy to server
scp -r _book/* luzfrias:/apps/rdataviz/
