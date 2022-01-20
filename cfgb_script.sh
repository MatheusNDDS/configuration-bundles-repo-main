#!/bin/bash
clear
echo $0
u=$(whoami) ; if [ $u != root ]; then echo 'Error: this command needs run with sudo: 
Ex: sudo command/script ' ; exit ; fi

if [ $1 = setup ]; then
if [  $2 =   ] ; then echo 'Error: Enter your repository URL after setup ' ; exit ; fi ;
sudo cp -r "$(pwd)/cfgb_script.sh" /bin/cfgb
sudo mkdir /usr/share/cfgb ; sudo mkdir /usr/share/cfgb/bundles ; 
sudo echo $2 > /usr/share/cfgb/repo
echo C.F.G.B Manager instaled
exit
fi
if [ $1 = update ]; then sudo cp -r "$(pwd)/cfgb_script.sh" /bin/cfgb ; echo C.F.G.B Manager Updated ; exit ; fi

#Global variables
glb="export" ; $glb name=cfgb ; $glb cp="sudo cp -r";$glb rm="sudo rm -rf";$glb prt="echo -e" ; $glb pdir=/usr/share/$name ; $glb id=$2 ; $glb mkd='sudo mkdir' ; $glb bnd_dir=$pdir/bundles

#Setup
repo=$(cat $pdir/repo)
cd $bnd_dir ; 

#pkg install function
pkg_install () { 
echo -=- [${pkgm[0]}]: Installing Packages -=-;
echo '-=- Atualizando '${pkmg[0]}' -=-'
sudo ${pkgm[0]} ${pkgm[2]} -y ;
sudo ${pkgm[0]} ${pkgm[3]} -y ;
for i in $(cat $bnd_dir/$id/packages) ; do echo -=$i=- ; sudo ${pkgm[0]} ${pkgm[1]} $i -y ; done
echo -=- [$name]: Cooking Directories -=- ; } ;
export -f pkg_install

$prt '[Configuration Bundles Manager] by -=Matheus Dias=-
~Making desktop setups most simple possible!~
'
#getting a bundle
if [ $1 = -i ]; then
echo '-=- ['$name']: Download Bundle -=-
Repository: '$repo''
wget -q $repo/$2.tar.gz ;
echo 'tar: ['$(ls $bnd_dir/ )'] -Ok
'

#unpacking a bundle
echo '-=- ['$2']: Unpacking Bundle -=-'
$mkd $2/ ; tar -xf $2.tar.gz -C $2/ ; $rm $2.tar.gz
echo files: [$(ls -c $bnd_dir/$2)] -Ok
fi


#Cooking directories recipes
$prt '-=- ['$2']: Cooking Bundle -=-'
cd $bnd_dir/$2/ ; bash recipe
echo '-=- '$2' Instaled -=-' ; 
$rm $bnd_dir/*
