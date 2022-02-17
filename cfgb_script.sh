#!/bin/bash
clear
msg=(
'Error: this command needs run with sudo: \n Ex: sudo command/script '
'Error: Enter your repository URL after setup'
)

u=$(whoami) ; if [ $u != root ]; then echo 'Error: this command needs run with sudo: 
Ex: sudo command/script' ; exit ; fi

if [ $1 = setup ]; then
if [ $2 = "" ] ; then echo  ; exit ; fi ;
sudo cp -r "$(pwd)/cfgb_script.sh" /bin/cfgb
sudo mkdir /usr/share/cfgb ; sudo mkdir /usr/share/cfgb/bundles ;

#setting configs
sudo echo -e "export repo=$3
export h=/home/$2" > /usr/share/cfgb/cfg ;
echo C.F.G.B Manager instaled
exit
fi
#if [ $1 = update ]; then sudo cp -r "$(pwd)/cfgb_script.sh" /bin/cfgb ; echo C.F.G.B Manager Updated ; exit ; fi

#Global variables
glb="export" ; $glb name=cfgb ; $glb cp="sudo cp -r";$glb rm="sudo rm -rf";$glb prt="echo -e" ; $glb pdir=/usr/share/$name ; $glb id=$2 ; $glb mkd='sudo mkdir' ; $glb bnd_dir=$pdir/bundles

#Setup
cfg=$(cat $pdir/cfg); $cfg ; cd $bnd_dir ;

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
#args=($2 $3 $4 $5 $6) ; for a in ${args[@]} ; do sudo cfgb -i $a ; done
if [ $1 = -i ]; then 
args=($2 $3 $4 $5 $6) ; for a in ${args[@]} ; do
#getting a bundle
echo '-=- ['$name']: Download Bundle -=-
Repository: '$repo''
wget $repo/$a.tar.gz ;
echo 'tar: ['$(ls $bnd_dir/ )'] -Ok
'
#unpacking a bundle
echo '-=- ['$a']: Unpacking Bundle -=-'
$mkd $a/ ; tar -xf $a.tar.gz -C $a/ ; $rm $a.tar.gz
echo files: [$(ls -c $bnd_dir/$a)] -Ok

#Cooking directories recipes
$prt '-=- ['$a']: Cooking Bundle -=-'
cd $bnd_dir/$a/ ; bash recipe
echo '-=- '$a' Instaled -=-' ;  done ;
fi

$rm $bnd_dir/*
