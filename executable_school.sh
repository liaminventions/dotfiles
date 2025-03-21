librewolf
sleep 0.2
for i in `cat ~/subjects/urls.txt`
do 
    librewolf $i >/dev/null
    sleep 0.1
done
