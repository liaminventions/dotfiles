chmod +x *
for filename in executable_*; do 
    [ -f "$filename" ] || continue
    mv "$filename" "${filename//executable_/}"

done
