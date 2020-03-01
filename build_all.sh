#!/bin/bash

source ./env.sh
rc=$?
if [ ! "$rc" == "0" ]; then
  echo "YIKES - no env.sh found"
  exit 1
fi;

majorV="$1"
if [ "$majorV" == "95" ]; then
  minorV=$P95
elif [ "$majorV" == "96" ]; then
  minorV=$P96
elif [ "$majorV" == "10" ]; then
  minorV=$P10
elif [ "$majorV" == "11" ]; then
  minorV=$P11
elif [ "$majorV" == "12" ]; then
  minorV=$P12
elif [ "$majorV" == "all" ]; then
  minorV=all
else
  echo "ERROR: pg must be 95, 96, 10, 11, 12 or all"
  exit 1
fi

if [ ! "$2" == "" ]; then
  outDir="$2"
fi

if [ "$OUT" == "" ]; then
  echo "ERROR: Environment is not set..."
  exit 1
fi


buildALL () {
  bigV=$1
  fullV=$2
  echo ""
  echo "################## BUILD_ALL $bigV $fullV ###################"

  if [ "$bigV" == "all" ]; then
    buildONE $outDir "95" $P95
    buildONE $outDir "96" $P96
    buildONE $outDir "10" $P10
    buildONE $outDir "11" $P11
    buildONE $outDir "12" $P12
  else
    buildONE $outDir $bigV $fullV 
  fi
  
}


buildONE () {
  vPlat=$1
  vBig=$2
  vFull=$3

  if [ "$4" == "false" ]; then
    return
  fi
  parms="-X $vPlat -c $bundle -N $vFull -p $vBig -b"
  echo ""
  echo "### BUILD_ONE $parms ###"
  ./build.sh $parms
  rc=`echo $?`
  if [ $rc -ne 0 ]; then
    exit $rc
  fi
}


echo "############### Build Package Manager ###################"
rm -f $OUT/hub-$hubV*
rm -f $OUT/$bundle-$api-$hubV*
./build.sh -X posix -c $bundle-$api -N $hubV

buildALL $majorV $minorV

echo ""
exit 0
