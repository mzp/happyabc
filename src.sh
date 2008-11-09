#!/bin/bash
###
VERSION=$(head -1 VERSION)
FULL_VERSION=$(tail -1 VERSION)

###
function checkout(){
    $1 $2
    cd $2
#    omake check || exit 1
#    omake clean
    cd -
}
echo $VERSION
echo $FULL_VERSION

dir=habc-$VERSION

echo '### cleanup ###'
rm -rf habc-*
mkdir $dir

echo '### checkout(xml) ###'
checkout 'svn export http://www.libspark.org/svn/ocaml/abc2xml/trunk' ${dir}/xml || exit 1

echo '### checkout(core) ###'
checkout 'git clone git@github.com:mzp/scheme-abc.git --depth=0' ${dir}/scm || exit 1
rm -rf ${dir}/core/.git

echo '### copy driver ###'
sed "s/<Version>/${FULL_VERSION}/" habc > ${dir}/habc
cp extra/* ${dir}

tar cvjf ${dir}.tar.bz2 ${dir}