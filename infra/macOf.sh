hostname=${1:?hostname}
# from: https://serverfault.com/questions/299556/how-to-generate-a-random-mac-address-from-the-linux-command-line
echo "$hostname"|md5sum|sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02:\1:\2:\3:\4:\5/'
