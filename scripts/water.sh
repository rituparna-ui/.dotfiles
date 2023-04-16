# echo "Hello Ritu !"
op=$(curl -s http://yerkee.com/api/fortune/computers | jq '.fortune')
echo "Hello Ritu !"
dunstify "Water !!!" "$op"
