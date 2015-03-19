## Adapted from Jon Olmsted's setup at Princeton
## https://github.com/olmjo/tigress-scripts/blob/master/setup/setup.sh

#!/bin/bash
. /etc/profile.d/modules.sh

##
## Functions
##

useVer() {
    echo -e "* Using $1 version $2."
}

ansYN() {
    echo -e "Please answer yes or no."
    }


## Banner ============================================================
echo -e "------------------------------"
echo -e "ENGAGING Setup for R-based HPC"
echo -e "------------------------------"
echo -e ""
## ===================================================================

## ===================================================================
## Set Vars 1
LOCATION=$(hostname)
RMPIVERS=0.6-3

## ===================================================================
## Set Vars 2
export OMPIVERS=1.8.3
## We can set this up to use different version of OpenMPI for different 
## servers

## ===================================================================
## Disclose Version
echo ""
useVer OpenMPI ${OMPIVERS}
useVer Rmpi ${RMPIVERS}
echo ""

## ===================================================================
while true; do
    read -p "\
@ Do you need to add modules to .bashrc? (Select Yes for first time users)
[y/n]" yn
    case $yn in
        [Yy]* )
	    echo -e "\nmodule use /cm/shared/modulefiles/engaging" >> ~/.bashrc
	    echo -e "module add R/3.1.1" >> ~/.bashrc
	    echo -e "module add openmpi/1.8.3" >> ~/.bashrc
	    source ~/.bashrc
            break;;

        [Nn]* ) break;;
        * ) ansYN ;;
    esac
done
echo ""

while true; do
    read -p "\
@ Do you need to download Rmpi?
[y/n]" yn
    case $yn in
        [Yy]* )
            mkdir ~/R_LIBS
            wget http://www.stats.uwo.ca/faculty/yu/Rmpi/download/linux/Rmpi_${RMPIVERS}.tar.gz -O rmpi.tar.gz -P ~/R_LIBS;
            break;;

        [Nn]* ) break;;
        * ) ansYN ;;
    esac
done
echo ""

while true; do
    read -p "\
@ Do you need to install Rmpi?
[y/n]" yn
    case $yn in
        [Yy]* )
	    source ~/.bashrc
            R CMD INSTALL -l ~/R_LIBS rmpi.tar.gz --configure-args=--with-mpi=/cm/shared/engaging/openmpi/${OMPIVERS}
            break;;

        [Nn]* )
            break;;
        * ) ansYN ;;
    esac
done
echo ""

while true; do
    read -p "\
@ Do you need to install misc. HPC R packages?
[y/n]" yn
    case $yn in
<<<<<<< HEAD
        [Yy]* )         
	    source ~/.bashrc
=======
        [Yy]* )          
            source ~/.bashrc
            module use /cm/shared/modulefiles/engaging
>>>>>>> d846dbcfefc5f86500b596f617bdcf082e0b140a
            Rscript install_misc.R;
            break;;
        [Nn]* )
            break;;
        * ) ansYN ;;
    esac
done
echo ""

