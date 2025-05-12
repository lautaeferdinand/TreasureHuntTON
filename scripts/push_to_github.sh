#!/bin/bash

cd "$(dirname "$0")/.."
git add .
git commit -m "Perbarui proyek TreasureHuntTON - $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main
