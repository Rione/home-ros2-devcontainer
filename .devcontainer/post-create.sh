#!/bin/sh

[ -f .envrc ] || cp .envrc.example .envrc

# rosdep update
# rosdep install --from-path src/ -yi --rosdistro humble
