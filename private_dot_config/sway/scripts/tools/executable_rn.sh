shopt -s globstar dotglob failglob

for filename in ./**/executable_*; do 
    [ -f "$filename" ] || continue
    chmod +x "$filename"
    mv "$filename" "${filename//executable_/}"
done
