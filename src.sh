#!/bin/bash
###
VERSION=$(head -1 VERSION)
FULL_VERSION=$(tail -1 VERSION)

###
function checkout(){
    $1 $2
#    (cd $2; omak check || exit 1; omake clean)
}
echo '### creating start... ###'
echo $VERSION
echo $FULL_VERSION

dir=habc-$VERSION

echo '### cleanup ###'
rm -rf habc-*
mkdir $dir

echo '### checkout(xml) ###'
checkout 'svn export http://www.libspark.org/svn/ocaml/abc2xml/trunk' ${dir}/xml

echo '### checkout(core) ###'
checkout 'git clone git@github.com:mzp/scheme-abc.git --depth=0' scm
cp -r scm ${dir}
rm -rf ${dir}/scm/.git

echo '### copy driver ###'
sed "s/<Version>/${FULL_VERSION}/" habc > ${dir}/habc
cp extra/* ${dir}

echo '### install check ###'
DIST=$PWD/test-dist
rm -rf $DIST
(cd $dir;omake install PREFIX=${DIST}; omake clean)
ls ${DIST}/bin/habc     || exit 1
ls ${DIST}/bin/habc-xml || exit 1
ls ${DIST}/bin/habc-scm || exit 1

echo '### tagging ###'
Tag="v${VERSION}"
svn copy http://www.libspark.org/svn/ocaml/abc2xml/trunk http://www.libspark.org/svn/ocaml/abc2xml/tags/${Tag} -m "Release $Tag"
(cd scm; git tag ${Tag}; git push --tags)
rm -rf scm

echo '### package ###'
tar cvjf ${dir}-src.tar.bz2 ${dir}
