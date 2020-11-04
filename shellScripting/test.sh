echo hello world
echo -e "line1\tline2"
echo -e "line1\nline2"

#variables

a=10
b=1.05
echo a= $a
echo b= ${b}cm


read -p "Enter fruit name ": fruit

case $fruit in
 orange)
  echo "orange is available"
  ;;
 apple)
  echo "apple is no more"
  ;;
esac