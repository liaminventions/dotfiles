#!/bin/sh
furnace -loglevel error -console -view pattern $(kdialog --getopenfilename ~/music/fur/ '*.fur')
