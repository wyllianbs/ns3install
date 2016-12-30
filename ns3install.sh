#!/bin/bash

# This is a simple and easy interactive script for NS3 installation.
#
# Federal University of Santa Catarina - UFSC
# (c) Prof. Wyllian Bezerra da Silva <wyllianbs@gmail.com>,
#
# Check out README.md for more details available at URL:
# https://github.com/wyllianbs/ns3install


#---------------------------------------------------------------------------->>*START*<<--------------------------------------------------------------------//
sudo -p "$(tput setaf 2) ::: Please enter sudo password$(tput blink): $(tput sgr 0)" whoami 1>/dev/null ; 

if [ -f /etc/debian_version ]; then
  echo "This OS is based on Debian/Ubuntu distro!"
  echo "Cheching and install full dependencies..."
 
  sudo apt install  python-pip ;
  sudo pip install python-config;
  sudo apt install python-dev valgrind python-pygraphviz nscd  libsqlite3-dev  python-pygccxml build-essential libc6-dev libgsl0-dev  python-zope.location  python3-zope.location  python-openscap   libgcrypt20-dev libboost-all-dev gcc g++ python qt4-dev-tools libqt4-dev mercurial bzr  cmake libc6-dev libc6-dev-i386 g++-multilib gdb gsl-bin  libgsl0ldbl flex bison libfl-dev tcpdump sqlite sqlite3 libsqlite3-dev libxml2 libxml2-dev libgtk2.0-0 libgtk2.0-dev vtun lxc  doxygen graphviz imagemagick texlive texlive-extra-utils texlive-latex-extra texlive-font-utils texlive-lang-portuguese dvipng  python-sphinx dia  python-kiwi python-pygoocanvas libgoocanvas-dev ipython libboost-signals-dev libboost-filesystem-dev openmpi-bin openmpi-common openmpi-doc libopenmpi-dev cvs ;
    
elif [ -f /etc/redhat-release ]; then
    echo "This OS is based on RedHat distro!"
    echo "Cheching and install full dependencies..."
    
    dnf install gcc gcc-c++ python python-devel mercurial bzr gsl gsl-devel gtk2 gtk2-devel gdb valgrind doxygen graphviz ImageMagick python-sphinx dia texlive texlive-latex flex bison tcpdump sqlite sqlite-devel libxml2 libxml2-devel uncrustify openmpi openmpi-devel boost-devel redhat-rpm-config goocanvas-devel graphviz graphviz-devel python-setuptools python-kiwi pygoocanvas ipython easy_install pygraphviz qt4-devel cmake glibc-devel.i686 glibc-devel.x86_64 patch autoconf cvs 
    
else
    echo "This distro isn't based on Debian or RedHat distros!"
    echo "Check the dependencies before installing the NS3."
fi


echo -e "\n::: Input:"; 

read -e -p "$(tput setaf 2)User$(tput blink): $(tput sgr 0)" -i $USER user ;

read -e -p "$(tput setaf 2)NS3 path installation directory$(tput blink): $(tput sgr 0)" -i "/usr/local/ns3" NS_Path;

read -e -p "$(tput setaf 2)URL NS3 file$(tput blink): $(tput sgr 0)" -i "https://www.nsnam.org/release/ns-allinone-3.26.tar.bz2" URLfile; 

file=$(echo "${URLfile##*/}"); 

NSallinonedir=$(echo "${file%.*.*}");

NSversion=$(echo "${NSallinonedir##*-}"); 
NSdir=ns-$NSversion; 

echo -e "\n::: Creating \"$NS_Path\" directory..."; 
sudo mkdir $NS_Path; 

echo -e "\n::: Adding user \"$user\" to group \"staff\"..."; 
sudo usermod -a -G staff $user

echo -e "\n::: Changing permitions on the \"NS3\" directory to rwx..."; 
sudo chmod -R ugo=rwx $NS_Path

echo -e "\n::: Accessing the \"$NS_Path\" directory..."; 
cd $NS_Path; 

echo -e "\n::: Downloading the NS3 version: \"$NSallinonedir\"..."; 
wget $URLfile ; 

echo -e "\n::: Extracting file: \"$file\"..."; 
tar xvjf $file; 

echo -e "\n::: Deleting "$file" file..."; 
rm -rf $file; 

echo -e "\n::: Accessing the path: \"$NS_Path/$NSallinonedir\"..."; 
cd $NS_Path/$NSallinonedir; 

echo -e "\n::: Getting the path NetAnim..."; 
netanimfullpath=$(find $NS_Path/$NSallinonedir -type d -name 'netanim-*');
netanimdirtmp=$(echo "${netanimfullpath##*/}"); # NetAnimDir=netanim-3.107;
read -e -p "$(tput setaf 2)NetAnim$(tput blink): $(tput sgr 0)" -i $netanimdirtmp NetAnimDir ;

echo -e "\n::: Building the NS3 [version $NSallinonedir]..."; 
./build.py --enable-examples --enable-tests; 


echo -e "\n::: Accessing the directory: \"$NSdir\"..."; 
cd $NSdir; 

echo -e "\n::: Testing processing..."; 
./test.py; 


echo -e "\n::: Adding environment variables on bashfile: \"$HOME/.bashrc\"..."; 
echo -e '

## --------------------------------------------------
##------ NS3 + WAF + NetAnim
NS_Path='$NS_Path'
NSdir='$NSdir'
NetAnimDir='$NetAnimDir'
NSallinonedir='$NSallinonedir'

waf=$NS_Path/$NSallinonedir/$NSdir/
NetAnim=$NS_Path/$NSallinonedir/$NetAnimDir/
PATH=$PATH:$waf:$NetAnim

## run waf with output at dir:
alias wafo='\''waf --cwd=$PWD --run '\''

## run waf with output at dir + animation:
alias wafvo='\''waf --cwd=$PWD --visualize --run '\''

## --------------------------------------------------

' >> /home/$user/.bashrc; 

echo -e "\n::: Accessing directory: \"$HOME\" "; 
cd $HOME; 

echo -e "\n::: Update bash environment..."; 
bash; 

echo -e "\n::: NS3 ready! Use:                                            
                                                                          waf   [options]
     waf + output at the same current working directory path:             wafo  [options]
     waf + output at the current working directory pathy + visualization: wafvo [options] \n";

#----------------------------------------------------------------------->>!END<<--------------------------------------------------------------------//