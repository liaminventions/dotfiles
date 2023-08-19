#!/bin/bash

wget https://gist.githubusercontent.com/Eiyeron/7986703/raw/6c20dc72ada837397589419909158d75df5ba5e7/LLT.c
gcc -o llt LLT.c -lm
./llt | sox -traw -r8000 -b8 -e unsigned-integer - -tpulseaudio gain -6
