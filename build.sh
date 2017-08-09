#!/bin/bash

if [ ! -e devdocs ]; then
    git clone https://github.com/Thibaut/devdocs.git
fi

docker build -t devdocs .

