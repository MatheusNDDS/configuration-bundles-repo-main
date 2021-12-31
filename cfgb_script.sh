#!/bin/bash

if [ $1 = setup ]; then
sudo cp -r "$(pwd)/cfgb_script.sh" /bin/cfgb
echo C.F.G.B Manager instalado
exit
fi

#Global variables
glb="export" ; $glb name=cfgb ; $glb cp=" sudo cp -r";$glb rm=" sudo rm -rf";$glb prt="echo -e" ; $glb pdir=/usr/share/$name ; $glb id=$2

#default repository
repomain=https://github.com/MatheusNDDS/configuration-bundles-repo-main/raw/main

if [ -d $pdir ]; then
$prt
else
mkdir $pdir
fi ; cd $pdir ; $rm $pdir/* 

#pkg install function
pkg_install () { 
echo -=- [${pkgm[0]}]: Installing Packages -=-;
sudo ${pkgm[0]} ${pkgm[2]} ;
sudo ${pkgm[0]} ${pkgm[3]} ;
for i in $(cat $pdir/$id/packages) ; do echo -=$i=- ; sudo ${pkgm[0]} ${pkgm[1]} $i -y ; done
echo -=- [$name]: Cooking Directories -=- ; } ;
export -f pkg_install

#setup
$prt '[Configuration Bundles Manager] by -=Matheus Dias=-
~Making desktop setups most simple possible!~
'
#getting a bundle
if [ $1 = -i ]; then
echo '-=- ['$name']: Download Bundle -=-
Repository: '$repomain''
wget -q $repomain/$2.tar.gz
echo 'tar: ['$(ls $pdir/ )'] -Ok
'

#unpacking a bundle
echo '-=- ['$2']: Unpacking Bundle -=-'
mkdir $2/ ; tar -xf $2.tar.gz -C $2/ ; $rm $2.tar.gz
echo files: [$(ls -c $pdir/$2)] -Ok
fi


#Cooking directories recipes
$prt '-=- ['$2']: Cooking Bundle -=-'
cd $pdir/$2/ ; bash recipe
