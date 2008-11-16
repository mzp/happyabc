#!/bin/bash
### Gloabl Settings
VERSION=$(head -1 VERSION)
FULL_VERSION=$(tail -1 VERSION)
Tag="v${VERSION}"

### Util function
function checkout(){
    $1 $2
#    (cd $2; omake check || exit 1; omake clean)
}

function status(){
    echo "#### $1 ####"
}

### setting
status 'Version'
dir=habc-$VERSION
echo 'version:' $VERSION
echo 'full-version:' $FULL_VERSION
echo 'dir-name:' $dir
echo 'tag:' $Tag

status 'cleanup'
rm -rf habc-*
mkdir $dir

status 'checkout(xml)'
checkout 'svn export http://www.libspark.org/svn/ocaml/abc2xml/trunk' ${dir}/xml

status 'checkout(scm)'
checkout 'git clone git@github.com:mzp/scheme-abc.git --depth=0' scm
cp -r scm ${dir}
rm -rf ${dir}/scm/.git

status 'copy driver'
(cd $dir; omake clean)
cp -rv driver ${dir}
sed "s/<VERSION>/${FULL_VERSION}/" driver/main.ml > ${dir}/driver/main.ml
cp -rv extra/* ${dir}

status 'install check'
DIST=$PWD/test-dist
rm -rf $DIST
(cd $dir;omake install PREFIX=${DIST}; omake clean)
ls ${DIST}/bin/habc     || exit 1
ls ${DIST}/bin/habc-xml || exit 1
ls ${DIST}/bin/habc-scm || exit 1

status 'tagging'

#svn copy http://www.libspark.org/svn/ocaml/abc2xml/trunk http://www.libspark.org/svn/ocaml/abc2xml/tags/${Tag} -m "Release $Tag"
# (cd scm; git tag ${Tag}; git push --tags)
# rm -rf scm

status 'package'
tar cvjf ${dir}-src.tar.bz2 ${dir}
