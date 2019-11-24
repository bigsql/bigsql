#!/bin/bash
#

archiveDir="/opt/builds/"
baseDir="`pwd`/.."
workDir="gis`date +%Y%m%d_%H%M`"
PGHOME=""

osArch=`getconf LONG_BIT`
 
sharedLibs="$baseDir/shared/linux_$osArch/lib"
sharedBins="$baseDir/shared/linux_$osArch/bin"
includePath="$baseDir/shared/linux_$osArch/include"

pgBuildVersion=0
pgVersion=""

postgisSourceDir=""
postgisFullVersion=""
postgisMajorVersion=""
postgisMinorVersion=""
postgisMicroVersion=""
postgisSourceTar=""
postgisBuildDir=""

xml2Lib="/opt/gis-tools/libxml2"
geosLib="/opt/gis-tools/geos"
gdalLib="/opt/gis-tools/gdal"
projLib="/opt/gis-tools/proj4"

sourceTarPassed=0
archiveLocationPassed=0
buildVersionPassed=0
buildSpatial=0
buildNumber=1

# This function prints the script usage/help
function printUsage {

echo "

Usage:

`basename $0` [OPTIONS]

Required Options:
	-a      Target build location, the final tar.bz2 would be placed here
        -t      Postgis Source tar ball.
        -p      PostgreSQL HOME
	-n      Build Number (Default to 1)
";

}


# Verify if the Postgis tarball is valid
function checkPostgisTar {
	echo "Verifying PostGIS source tarball .... "

	cd $baseDir
	mkdir -p $workDir
	cd $baseDir/$workDir

	postgisSourceDir=`dirname $(tar -tf $postgisSourceTar | grep "README.postgis")`
	
	tar -xf $postgisSourceTar

	cd $postgisSourceDir

	isPostgisConfigure=`./configure --help | grep "geos" | wc -l`

	if [[ $isPostgisConfigure -ne 1 ]]; then
		echo "$postgisSourceTar is not a valid Postgis source tarball .... "
		return 1
	else
		postgisMajorVersion=`cat Version.config | grep MAJOR | awk 'BEGIN {FS = "=" } ; {print $2}'`
		postgisMinorVersion=`cat Version.config | grep MINOR | awk 'BEGIN {FS = "=" } ; {print $2}'`
		postgisMicroVersion=`cat Version.config | grep MICRO | awk 'BEGIN {FS = "=" } ; {print $2}'`
		postgisFullVersion="$postgisMajorVersion.$postgisMinorVersion.$postgisMicroVersion"
		echo "Postgis $postgisFullVersion source tarball .... OK "

		#postgisBuildDir="postgis22-2.2.2-linux64-pg95-linux64"
		pgVersion=`$PGHOME/bin/pg_config --version | awk '{print $2}'`
		postgisBuildDir="postgis${postgisMajorVersion}${postgisMinorVersion}-pg`echo $pgVersion | awk -F '.' '{print $1$2}'`-${postgisFullVersion}-$buildNumber-linux64"
	fi
}



# This function builds PostGIS and adds to the build
function buildPostgis {
	echo "Building Postgis ...."

	buildLocation="$baseDir/$workDir/$postgisBuildDir"
	mkdir -p $buildLocation
	#Prepare the target directory
	mkdir -p $buildLocation/bin
	mkdir -p $buildLocation/lib
	mkdir -p $buildLocation/lib/postgresql
	cp -r $PGHOME/include $buildLocation/
	cp $PGHOME/bin/pg_config $buildLocation/bin/
	cp $PGHOME/lib/libpq.* $buildLocation/lib/
	cp $PGHOME/lib/libssl.so.1.0.0 $buildLocation/lib/
	cp $PGHOME/lib/libcrypto.so.1.0.0 $buildLocation/lib/
	cp -r $PGHOME/lib/postgresql/pgxs $buildLocation/lib/postgresql/

	mkdir -p $baseDir/$workDir/logs	
	
	if [[ ! -e $baseDir/$workDir/$postgisSourceDir ]]; then
		echo "Unable to build Postgis, source directory not found, check logs .... "
		return 1
	fi

	cd $baseDir/$workDir/$postgisSourceDir

	LD_RUN_PATH=$PGHOME/lib
	export LD_LIBRARY_PATH=$sharedLibs:$PGHOME/lib

	./configure --prefix=$buildLocation --with-pgconfig=$buildLocation/bin/pg_config --with-geosconfig=$geosLib/bin/geos-config --with-projdir=$projLib --with-xml2config=$xml2Lib/bin/xml2-config --with-gdalconfig=$gdalLib/bin/gdal-config LDFLAGS=-Wl,-rpath,'$$ORIGIN'/../lib/ > $baseDir/$workDir/logs/postgis_configure.log 2>&1

        if [[ $? -ne 0 ]]; then
                echo "Postgis configure failed, check config.log for details ...."
                return 1
        fi

	make > $baseDir/$workDir/logs/postgis_make.log 2>&1

        if [[ $? -ne 0 ]]; then
                echo "Postgis make failed, check logs ...."
                return 1
        fi
	#rm -rf $buildLocation/lib
	#rm -rf $buildLocation/include
	
	make install >  $baseDir/$workDir/logs/postgis_install.log 2>&1

	if [[ $? -ne 0 ]]; then
       		echo "Failed to install Postgis, check logs .... "
	else
        	echo "Postgis built & installed successfully .... "
	fi

	#rm -rf $buildLocation/bin/pg_config
	#rm -rf $buildLocation/lib/postgresql/pgxs
	#rm -rf $buildLocation/lib/libcrypto.so.1.0.0
	#rm -rf $buildLocation/lib/libssl.so.1.0.0
	#rm -rf $buildLocation/lib/libpq.*
	unset LD_LIBRARY_PATH
}

# This function adds the required libs to the build
function copySharedLibs {
	
	echo "Adding shared libs to the new build ...."

	cp $projLib/lib/libproj.so.9 $buildLocation/lib/
	cp $geosLib/lib/libgeos_c.so.1 $buildLocation/lib/
	cp $geosLib/lib/libgeos-3.5.0.so $buildLocation/lib/
	cp $gdalLib/lib/libgdal.so.1 $buildLocation/lib/
	cp $xml2Lib/lib/libxml2.so* $buildLocation/lib/
}

# This function updates the library linking paths for libs and binaries
function updateSharedLibPaths {
	cd $buildLocation/bin

	for file in `dir -d *` ; do
		chrpath -r "\${ORIGIN}/../lib" "$file" >> $baseDir/$workDir/logs/libPath.log 2>&1
	done

	cd $buildLocation/lib
	
	for file in `dir -d *so*` ; do
		chrpath -r "\${ORIGIN}/../lib" "$file" >> $baseDir/$workDir/logs/libPath.log 2>&1 
	done

	if [[ -d "$buildLocation/lib/postgresql" ]]; then	
		cd $buildLocation/lib/postgresql

        	for file in `dir -d *.so` ; do
                	chrpath -r "\${ORIGIN}/../../lib" "$file" >> $baseDir/$workDir/logs/libPath.log 2>&1
        	done
	fi
	
}


# Creates the final bundle
function createPostGISBundle {
	cd $baseDir/$workDir
	postgisTar="postgis${postgisMajorVersion}${postgisMinorVersion}-pg`echo $pgVersion | awk -F '.' '{print $1$2}'`-$postgisFullVersion-$buildNumber-linux64"

	tar -cjf "$postgisTar.tar.bz2" $postgisTar >> $baseDir/$workDir/logs/tar.log 2>&1
	
	if [[ $? -ne 0 ]]; then
		echo "Unable to create tar for $PGHOME, check logs .... "
	else
		mkdir -p $archiveDir/$workDir
		mv "$postgisTar.tar.bz2" $archiveDir/$workDir/
		echo "PostGIS $postgisFullVersion packaged for PG $pgVersion ...."
	fi

	if [[ $? -eq 0 ]]; then
        	destDir=`date +%Y-%m-%d`
        	ssh build@10.0.1.118 "mkdir -p /opt/pgbin-builds/$destDir"
        	scp "$archiveDir/$workDir/$postgisTar.tar.bz2" build@10.0.1.118:/opt/pgbin-builds/$destDir/
        	exit 0
	else   
        	exit 1
	fi
}

if [[ $# -lt 1 ]]; then
	printUsage
	exit 1
fi

	while getopts "t:a:p:n:vh" opt; do
		case $opt in
			t)
				if [[ $OPTARG = -* ]]; then
        				((OPTIND--))
        				continue
      				fi
				postgisSourceTar=$OPTARG
				sourceTarPassed=1
				buildSpatial=1
			;;
			a)
				if [[ $OPTARG = -* ]]; then
					((OPTIND--))
				fi
				archiveDir=$OPTARG
				archiveLocationPassed=1
			;;
			p)
                                if [[ $OPTARG = -* ]]; then
                                        ((OPTIND--))
                                        continue
                                fi

				PGHOME=$OPTARG
				pgHomePassed=1
			;;
			n)
				if [[ $OPTARG = -* ]]; then
					((OPTIND--))
					continue
				fi
				buildNumber=$OPTARG
			;;
			h)
				printUsage
			;;
			v)
				printRevisionInfo
			;;
			\?)
				printUsage
				echo "Invalid Option Specified, exiting ...." 
				exit 1
		esac
	done



if [[ $archiveLocationPassed -eq 0 ]]; then
	echo " "
	echo "Archive location required, this is where the final tar.bz2 would be placed"
	printUsage
	exit 1
fi

if [[ $sourceTarPassed -eq 0 ]]; then
	echo "PostGIS Source tarball is required for the build ....."
	echo " "	
	printUsage
	exit 1
else
	
	if [[ $buildSpatial -eq 1 ]]; then 
		checkPostgisTar
		if [[ $? -eq 0 ]]; then
			buildPostgis
			if [[ $? -ne 0 ]]; then
				echo "Postgis Build failed ..."
				exit 1
			fi
		else
			echo "Can't build Postgis"
		fi
	fi 

	copySharedLibs
	updateSharedLibPaths

	createPostGISBundle
fi
