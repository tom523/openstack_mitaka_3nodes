file=$1
cp $file{,.bak}
sed -i '/^#/d' $file
sed -i '/^$/d' $file
