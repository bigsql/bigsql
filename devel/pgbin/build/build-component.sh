#!/bin/bash

# set -x

source ./versions.sh
buildOS=$OS
buildNumber=1

baseDir="`pwd`/.."
workDir="comp`date +%Y%m%d_%H%M`"
PGHOME=""

componentShortVersion=""
componentFullVersion=""
buildNumber=0

targetDir="/opt/pgbin-build/build"
sharedLibs="/opt/pgbin-build/pgbin/shared"

# Get PG Version from the provided pgBin directory
function getPGVersion {
	if [[ ! -f "$pgBin/bin/pg_config" ]]; then
		echo "pg_config is required for building components"
		echo "No such file or firectory : $pgBin/bin/pg_config "
		return 1
	fi
	pgFullVersion=`$pgBin/bin/pg_config --version | awk '{print $2}'`

        if [[ "${pgFullVersion/rc}" =~ 12.* ]]; then
                pgShortVersion="12"
        elif [[ "${pgFullVersion/rc}" =~ 11.* ]]; then
                pgShortVersion="11"
        elif [[ "${pgFullVersion/rc}" =~ 10.* ]]; then
                pgShortVersion="10"
	elif [[ "${pgFullVersion/rc}" == "$pgFullVersion" ]]; then
		pgShortVersion="`echo $pgFullVersion | awk -F '.' '{print $1$2}'`"
        else
                pgShortVersion="`echo $pgFullVersion | awk -F '.' '{print $1$2}'`"
                pgShortVersion="`echo ${pgShortVersion:0:2}`"
        fi

	#pgShortVersion=`echo $pgFullVersion | awk -F '.' '{print$1$2}'`
}


function prepComponentBuildDir {
	buildLocation=$1
	rm -rf $buildLocation
	mkdir -p $buildLocation
	mkdir -p $buildLocation/bin
        mkdir -p $buildLocation/share
	mkdir -p $buildLocation/lib/postgresql/pgxs
	cp $PGHOME/bin/pg_config $buildLocation/bin/
	cp -r $PGHOME/include $buildLocation/
	cp -r $PGHOME/lib/postgresql/pgxs/* $buildLocation/lib/postgresql/pgxs/
	cp $PGHOME/lib/libpq* $buildLocation/lib/
	cp $PGHOME/lib/libssl.so* $buildLocation/lib/
	cp $PGHOME/lib/libpgport.a $buildLocation/lib/
	cp $PGHOME/lib/libpgcommon.a $buildLocation/lib/
	cp $PGHOME/lib/libcrypto.so* $buildLocation/lib/
        cp $PGHOME/lib/postgresql/plpgsql.so $buildLocation/lib/postgresql/

	if [[ $buildCassandra == "true" && ! ${buildLocation/cassandra} == "$buildLocation" ]]; then
		cp "$sharedLibs/linux_64/lib/libcassandra.so.2" $buildLocation/lib/
		cp "$sharedLibs/linux_64/lib/libuv.so.1" $buildLocation/lib/
	fi

	if [[ $buildTDSFDW == "true" && ! ${buildLocation/tds} == "$buildLocation" ]]; then
		cp "$sharedLibs/$buildOS/lib/libsybdb.so.5" $buildLocation/lib/
		cp "$sharedLibs/$buildOS/bin/tsql" $buildLocation/bin/
	fi
	
	if [[ $buildPlr == "true" && ! ${buildLocation/plr} == "$buildLocation" ]]; then
		cp "$sharedLibs/$buildOS/R323/lib64/R/lib/libR.so" $buildLocation/lib/
		cp "$sharedLibs/$buildOS/R323/lib64/R/lib/libRblas.so" $buildLocation/lib/
	fi

}


function cleanUpComponentDir {
	cd $1
	rm -rf bin/pg_config
	rm -rf lib/postgresql/plpgsql.so
	rm -rf include
	rm -rf lib/postgresql/pgxs
	rm -rf lib/libpgport.a
	rm -rf lib/libpgcommon.a

	if [[ ! "$(ls -A bin)" ]]; then
		rm -rf bin
	fi
}

function  packageComponent {
	bundle="$targetDir/$workDir/$componentBundle.tar.bz2"
	echo "$bundle"

	cd "$baseDir/$workDir/build/"
	tar -cjf "$componentBundle.tar.bz2" $componentBundle
	rm -rf "$targetDir/$workDir"
	mkdir -p "$targetDir/$workDir"
	mv "$componentBundle.tar.bz2" "$targetDir/$workDir/"

	if [ "$copyBin" == "true" ]; then
		cp -pv $bundle $IN/postgres/$compDir/.
	fi

}


function updateSharedLibs {

	if [[ -d bin ]]; then
		cd $buildLocation/bin
		for file in `dir -d *` ; do
			chrpath -r "\${ORIGIN}/../lib" "$file" >> $baseDir/$workDir/logs/libPath.log 2>&1
        	done
        fi

        cd $buildLocation/lib
	for file in `dir -d *so*` ; do
                chrpath -r "\${ORIGIN}/../lib" "$file" >> $baseDir/$workDir/logs/libPath.log 2>&1
        done

        if [[ -d "$buildLocation/lib/postgresql" ]]; then
                cd $buildLocation/lib/postgresql
		for file in `dir -d *so* 2>/dev/null` ; do
			ls -sh $file
             		chrpath -r "\${ORIGIN}/../../lib" "$file" >> $baseDir/$workDir/logs/libPath.log 2>&1
		done
        fi
}


function buildPgBouncerComponent {

	componentName="bouncer$bouncerShortVersion-pg$pgShortVersion-$bouncerFullVersion-$bouncerBuildV-$buildOS"
	mkdir -p "$baseDir/$workDir/logs"
	cd "$baseDir/$workDir"
	mkdir bouncer && tar -xf $bouncerSource --strip-components=1 -C bouncer
	cd bouncer

	buildLocation="$baseDir/$workDir/build/$componentName"

	prepComponentBuildDir $buildLocation


	PATH=$buildLocation/bin:$PATH

	USE_PGXS=1 make > $baseDir/$workDir/logs/bouncer_make.log 2>&1
	if [[ $? -eq 0 ]]; then
		 USE_PGXS=1 make install > $baseDir/$workDir/logs/bouncer_install.log 2>&1
		if [[ $? -ne 0 ]]; then
			echo "pgBouncer install failed, check logs for details."
		fi
	else
		echo "pgBouncer Make failed, check logs for details."
		return 1
	fi

	componentBundle=$componentName
	cleanUpComponentDir $buildLocation
	updateSharedLibs
	packageComponent $componentBundle
}

function buildTDSFDWComponent {

	componentName="tds_fdw$tdsFDWShortVersion-pg$pgShortVersion-$tdsFDWFullVersion-$tdsFDWBuildV-$buildOS"
	mkdir -p "$baseDir/$workDir/logs"
	cd "$baseDir/$workDir"
	mkdir tds_fdw && tar -xf $tdsFDWSource --strip-components=1 -C tds_fdw
	cd tds_fdw

	buildLocation="$baseDir/$workDir/build/$componentName"

	prepComponentBuildDir $buildLocation


	PATH=$buildLocation/bin:$PATH
	USE_PGXS=1 make > $baseDir/$workDir/logs/tdsfdw_make.log 2>&1
	if [[ $? -eq 0 ]]; then
		 USE_PGXS=1 make install > $baseDir/$workDir/logs/tds_install.log 2>&1
		if [[ $? -ne 0 ]]; then
			echo "TDS FDW install failed, check logs for details."
		fi
	else
		echo "TDS FDW Make failed, check logs for details."
		return 1
	fi

	componentBundle=$componentName
	cleanUpComponentDir $buildLocation
	updateSharedLibs
	packageComponent $componentBundle
}

function buildTSQLComponent {

	componentName="pgtsql$pgTSQLShortV-pg$pgShortVersion-$pgTSQLFullV-$pgTSQLBuildV-$buildOS"
	mkdir -p "$baseDir/$workDir/logs"
	cd "$baseDir/$workDir"
	mkdir pgtsql && tar -xf $tsqlSource --strip-components=1 -C pgtsql
	cd pgtsql

	buildLocation="$baseDir/$workDir/build/$componentName"

	prepComponentBuildDir $buildLocation


	PATH=$buildLocation/bin:$PATH
	USE_PGXS=1 make > $baseDir/$workDir/logs/pgtsql_make.log 2>&1
	if [[ $? -eq 0 ]]; then
		 USE_PGXS=1 make install > $baseDir/$workDir/logs/pgtsql_install.log 2>&1
		if [[ $? -ne 0 ]]; then
			echo "TSQL install failed, check logs for details."
		fi
	else
		echo "TSQL Make failed, check logs for details."
		return 1
	fi

	componentBundle=$componentName
	cleanUpComponentDir $buildLocation
	updateSharedLibs
	packageComponent $componentBundle
}

function buildOracleFDWComponent {

	componentName="oraclefdw$oFDWShortVersion-pg$pgShortVersion-$oFDWFullVersion-$oFDWBuildV-$buildOS"
	mkdir -p "$baseDir/$workDir/logs"
	cd "$baseDir/$workDir"
	mkdir oraclefdw && tar -xf $oracleFDWSource --strip-components=1 -C oraclefdw
	cd oraclefdw

	buildLocation="$baseDir/$workDir/build/$componentName"

	prepComponentBuildDir $buildLocation


	PATH=$buildLocation/bin:$PATH
	USE_PGXS=1 make > $baseDir/$workDir/logs/oraclefdw_make.log 2>&1
	if [[ $? -eq 0 ]]; then
		 USE_PGXS=1 make install > $baseDir/$workDir/logs/oraclefdw_install.log 2>&1
		if [[ $? -ne 0 ]]; then
			echo "Oracle FDW install failed, check logs for details."
		fi
	else
		echo "Oracle FDW Make failed, check logs for details."
		return 1
	fi

	componentBundle=$componentName
	cleanUpComponentDir $buildLocation
	updateSharedLibs
	packageComponent $componentBundle
}


function buildSetUserComponent {

	componentName="setuser$setUserShortVersion-pg$pgShortVersion-$setUserFullVersion-$setUserBuildV-$buildOS"
	mkdir -p "$baseDir/$workDir/logs"
	cd "$baseDir/$workDir"
	mkdir setuser && tar -xf $setUserSource --strip-components=1 -C setuser
	cd setuser

	buildLocation="$baseDir/$workDir/build/$componentName"

	prepComponentBuildDir $buildLocation

	PATH=$buildLocation/bin:$PATH
	USE_PGXS=1 make > $baseDir/$workDir/logs/setuser_make.log 2>&1
	if [[ $? -eq 0 ]]; then
		 USE_PGXS=1 make install > $baseDir/$workDir/logs/setuser_install.log 2>&1
		if [[ $? -ne 0 ]]; then
			echo "SetUser install failed, check logs for details."
		fi
	else
		echo "SetUser Make failed, check logs for details."
		return 1
	fi

	componentBundle=$componentName
	cleanUpComponentDir $buildLocation
	updateSharedLibs
	packageComponent $componentBundle
}


function buildComp {
	comp="$1"
        ##echo "#        comp: $comp"
        shortV="$2"
        ##echo "#      shortV: $shortV"
        fullV="$3"
        ##echo "#       fullV: $fullV"
        buildV="$4"
        ##echo "#      buildV: $buildV"
        src="$5"
        ##echo "#         src: $src"

        componentName="$comp$shortV-pg$pgShortVersion-$fullV-$buildV-$buildOS"
        ##echo "#      compNm: $componentName"
        mkdir -p "$baseDir/$workDir/logs"
        cd "$baseDir/$workDir"
	rm -rf $comp
        mkdir $comp  && tar -xf $src --strip-components=1 -C $comp
        cd $comp

        buildLocation="$baseDir/$workDir/build/$componentName"

        prepComponentBuildDir $buildLocation


        PATH=$buildLocation/bin:$PATH
        log_dir="$baseDir/$workDir/logs"
        echo "#     log_dir: $log_dir"
        make_log="$log_dir/$comp-make.log"
        echo "#    make_log: $make_log"
        install_log="$log_dir/$comp-install.log"
        echo "# install_log: $install_log"

        if [ "$comp" == "presto_fdw" ]; then
           buildLib=$buildLocation/lib
           ln -s $JAVA_HOME/jre/lib/amd64/server/libjvm.so $buildLib/libjvm.so
        fi

        USE_PGXS=1 make > $make_log 2>&1
        if [[ $? -eq 0 ]]; then
                USE_PGXS=1 sudo make install > $install_log 2>&1
                if [[ $? -ne 0 ]]; then
                        echo " "
                        echo "ERROR: Install failed, check install_log"
                        #tail -10 $install_log
                        echo ""
                fi
        else
                echo " "
                echo "ERROR: Make failed, check make_log"
                echo " "
                #tail -10 $make_log
                return 1
        fi

        componentBundle=$componentName
        cleanUpComponentDir $buildLocation
        updateSharedLibs
        packageComponent $componentBundle
}


function buildPGAgentComponent {

        componentName="pgagent$pgAgentShortVersion-pg$pgShortVersion-$pgAgentFullVersion-$pgAgentBuildV-$buildOS"
        mkdir -p "$baseDir/$workDir/logs"
        cd "$baseDir/$workDir"
        mkdir pgagent  && tar -xf $pgAgentSource --strip-components=1 -C pgagent
        cd pgagent

        buildLocation="$baseDir/$workDir/build/$componentName"

        prepComponentBuildDir $buildLocation


        PATH=$buildLocation/bin:$PATH
        log_dir="$baseDir/$workDir/logs"
        make_log="$log_dir/pgagent_make.log"
        install_log="$log_dir/pgagent_install.log"
        ls -l
        ccmake .
        USE_PGXS=1 make > $make_log 2>&1
        if [[ $? -ne 0 ]]; then
                echo " "
                echo "pgagent Make failed, check logs for details."
                echo " "
                cat $make_log
                return 1
        fi

        componentBundle=$componentName
        cleanUpComponentDir $buildLocation
        packageComponent $componentBundle
}


function buildCronComponent {

        componentName="cron$cronShortVersion-pg$pgShortVersion-$cronFullVersion-$cronBuildV-$buildOS"
        mkdir -p "$baseDir/$workDir/logs"
        cd "$baseDir/$workDir"
        mkdir cron  && tar -xf $cronSource --strip-components=1 -C cron
        cd cron

        buildLocation="$baseDir/$workDir/build/$componentName"

        prepComponentBuildDir $buildLocation


        PATH=$buildLocation/bin:$PATH
        USE_PGXS=1 make > $baseDir/$workDir/logs/cron_make.log 2>&1
        if [[ $? -eq 0 ]]; then
                 USE_PGXS=1 make install > $baseDir/$workDir/logs/cron_install.log 2>&1
                if [[ $? -ne 0 ]]; then
                        echo "cron install failed, check logs for details."
                fi
        else
                echo "cron Make failed, check logs for details."
                return 1
        fi

        componentBundle=$componentName
        cleanUpComponentDir $buildLocation
        updateSharedLibs
        packageComponent $componentBundle
}


function buildPgMpComponent {

        componentName="pgmp$pgmpShortVersion-pg$pgShortVersion-$pgmpFullVersion-$pgmpBuildV-$buildOS"
        mkdir -p "$baseDir/$workDir/logs"
        cd "$baseDir/$workDir"
        mkdir pgmp  && tar -xf $pgmpSource --strip-components=1 -C pgmp
        cd pgmp

        buildLocation="$baseDir/$workDir/build/$componentName"

        prepComponentBuildDir $buildLocation


        PATH=$buildLocation/bin:$PATH
        make > $baseDir/$workDir/logs/pgmp_make.log 2>&1
        if [[ $? -eq 0 ]]; then
                make docs    > $baseDir/$workDir/logs/pgmp_docs.log 2>&1
                if [[ $? -ne 0 ]]; then
                        echo "pgmp docs failed, check logs for details."
                fi
        else
                echo "pgmp Make failed, check logs for details."
                return 1
        fi
        if [[ $? -eq 0 ]]; then
                make install > $baseDir/$workDir/logs/pgmp_install.log 2>&1
                if [[ $? -ne 0 ]]; then
                        echo "pgmp install failed, check logs for details."
                fi
        else
                echo "pgmp Make failed, check logs for details."
                return 1
        fi

        componentBundle=$componentName
        cleanUpComponentDir $buildLocation
        updateSharedLibs
        packageComponent $componentBundle
}


function buildMySQLFDWComponent {

	componentName="mysql_fdw$mysqlFDWShortVersion-pg$pgShortVersion-$mysqlFDWFullVersion-$mysqlFDWBuildV-$buildOS"
	mkdir -p "$baseDir/$workDir/logs"
	cd "$baseDir/$workDir"
	mkdir mysql_fdw && tar -xf $mysqlFDWSource --strip-components=1 -C mysql_fdw
	cd mysql_fdw

	buildLocation="$baseDir/$workDir/build/$componentName"

	prepComponentBuildDir $buildLocation

	PATH=$buildLocation/bin:/opt/pgbin-build/pgbin/shared/linux_64/mysql/bin:$PATH
	USE_PGXS=1 make > $baseDir/$workDir/logs/mysqlfdw_make.log 2>&1
	if [[ $? -eq 0 ]]; then
		 USE_PGXS=1 make install > $baseDir/$workDir/logs/mysqlfdw_install.log 2>&1
		if [[ $? -ne 0 ]]; then
			echo "MySQL FDW install failed, check logs for details."
		fi
	else
		echo "MySQL FDW Make failed, check logs for details."
		return 1
	fi

	componentBundle=$componentName
	cleanUpComponentDir $buildLocation
	updateSharedLibs
	packageComponent $componentBundle
}

function buildPlRComponent {

	componentName="plr$plRShortVersion-pg$pgShortVersion-$plRFullVersion-$plRBuildV-$buildOS"
	mkdir -p "$baseDir/$workDir/logs"
	cd "$baseDir/$workDir"
	mkdir plr && tar -xf $plrSource --strip-components=1 -C plr
	cd plr

	buildLocation="$baseDir/$workDir/build/$componentName"

	prepComponentBuildDir $buildLocation
	export R_HOME=/opt/pgbin-build/pgbin/shared/linux_64/R323/lib64/R
	PATH=$buildLocation/bin:$PATH
	USE_PGXS=1 make > $baseDir/$workDir/logs/plr_make.log 2>&1
	if [[ $? -eq 0 ]]; then
		 USE_PGXS=1 make install > $baseDir/$workDir/logs/plr_install.log 2>&1
		if [[ $? -ne 0 ]]; then
			echo "MySQL FDW install failed, check logs for details."
		fi
	else
		echo "MySQL FDW Make failed, check logs for details."
		return 1
	fi

	componentBundle=$componentName
	cleanUpComponentDir $buildLocation
	updateSharedLibs
	packageComponent $componentBundle
}

function buildPlJavaComponent {

	componentName="pljava$plJavaShortV-pg$pgShortV-$plJavaFullV-$plJavaBuildV-$buildOS"
	mkdir -p "$baseDir/$workDir/logs"
	cd "$baseDir/$workDir"
	mkdir pljava && tar -xf $plJavaSource --strip-components=1 -C pljava
	cd pljava

	buildLocation="$baseDir/$workDir/build/$componentName"

	prepComponentBuildDir $buildLocation

	PATH=/opt/pgbin-build/pgbin/shared/maven/bin:$buildLocation/bin:$PATH
	mvn clean install > $baseDir/$workDir/logs/pljava_make.log 2>&1
#	if [[ $? -eq 0 ]]; then
#		java -jar "pljava-packaging/target/pljava-pg`echo $pgFullVersion | awk -F '.' '{print $1"."$2}'`-amd64-Linux-gpp.jar" > $baseDir/$workDir/logs/pljava_install.log 2>&1 > $baseDir/$workDir/logs/pljava_install.log 2>&1
#		if [[ $? -ne 0 ]]; then
#			echo "Pl/Java install failed, check logs for details."
#		fi
#	else
#                mkdir -p pljava-packaging/target
#                cp "/tmp/pljava-pg`echo $pgFullVersion | awk -F '.' '{print $1}'`-amd64-Linux-gpp.jar" pljava-packaging/target/
#                java -jar "pljava-packaging/target/pljava-pg`echo $pgFullVersion | awk -F '.' '{print $1}'`-amd64-Linux-gpp.jar" > $baseDir/$workDir/logs/pljava_install.log 2>&1
#                #echo "Pl/Java Make failed, check logs for details."
#                #return 1
#	fi

	componentBundle=$componentName
	cleanUpComponentDir $buildLocation
	updateSharedLibs
	packageComponent $componentBundle
}


function buildBackgroundComponent {

        componentName="background$backgroundShortVersion-pg$pgShortVersion-$backgroundFullVersion-$backgroundBuildV-$buildOS"
        mkdir -p "$baseDir/$workDir/logs"
        cd "$baseDir/$workDir"
        mkdir background && tar -xf $backgroundSource --strip-components=1 -C background
        cd background

        buildLocation="$baseDir/$workDir/build/$componentName"

        prepComponentBuildDir $buildLocation


        PATH=$buildLocation/bin:$PATH
        USE_PGXS=1 make > $baseDir/$workDir/logs/background_make.log 2>&1
        if [[ $? -eq 0 ]]; then
                 USE_PGXS=1 make install > $baseDir/$workDir/logs/background_install.log 2>&1
                if [[ $? -ne 0 ]]; then
                        echo "Background install failed, check logs for details."
                fi
        else
                echo "Background Make failed, check logs for details."
                return 1
        fi

        componentBundle=$componentName
        cleanUpComponentDir $buildLocation
        updateSharedLibs
        packageComponent $componentBundle
}


function buildCstoreFDWComponent {

        componentName="cstore_fdw$cstoreFDWShortVersion-pg$pgShortVersion-$cstoreFDWFullVersion-$cstoreFDWBuildV-$buildOS"
        mkdir -p "$baseDir/$workDir/logs"
        cd "$baseDir/$workDir"
        mkdir cstore_fdw && tar -xf $cstoreFDWSource --strip-components=1 -C cstore_fdw
        cd cstore_fdw

        buildLocation="$baseDir/$workDir/build/$componentName"

        prepComponentBuildDir $buildLocation


        PATH=$buildLocation/bin:$PATH:/opt/pgbin-build/pgbin/shared/linux_64/bin
        make_log=$baseDir/$workDir/logs/cstore_make.log
        USE_PGXS=1 make > $make_log 2>&1
        if [[ $? -eq 0 ]]; then
                 USE_PGXS=1 make install > $baseDir/$workDir/logs/cstore_install.log 2>&1
                if [[ $? -ne 0 ]]; then
                        echo "CSTORE FDW install failed, check logs for details."
                fi
        else
                echo "CSTORE FDW Make failed, check logs for details."
                cat $make_log
                return 1
        fi

        componentBundle=$componentName
        cleanUpComponentDir $buildLocation
        updateSharedLibs
        packageComponent $componentBundle
}

function buildParquetFDWComponent {

        componentName="parquet_fdw$parquetFDWShortVersion-pg$pgShortVersion-$parquetFDWFullVersion-$parquetFDWBuildV-$buildOS"
        echo " $componentName"
        mkdir -p "$baseDir/$workDir/logs"
        cd "$baseDir/$workDir"
        mkdir parquet_fdw && tar -xf $parquetFDWSource --strip-components=1 -C parquet_fdw
        cd parquet_fdw

        buildLocation="$baseDir/$workDir/build/$componentName"

        prepComponentBuildDir $buildLocation


        PATH=$buildLocation/bin:$PATH:/opt/pgbin-build/pgbin/shared/linux_64/bin
        make_log=$baseDir/$workDir/logs/parquet_make.log
        export CPPFLAGS="$CPPFLAGS -std=c++11"
        USE_PGXS=1 make > $make_log 2>&1
        if [[ $? -eq 0 ]]; then
                 USE_PGXS=1 make install > $baseDir/$workDir/logs/parquet_install.log 2>&1
                if [[ $? -ne 0 ]]; then
                        echo "PARQUET FDW install failed, check logs for details."
                fi
        else
                echo "PARQUET FDW Make failed, check logs for details."
                cat $make_log
                return 1
        fi

        componentBundle=$componentName
        cleanUpComponentDir $buildLocation
        updateSharedLibs
        packageComponent $componentBundle
}


function buildTimeScaleDBComponent {

        componentName="timescaledb-pg$pgShortVersion-$timescaledbFullV-$timescaledbBuildV-$buildOS"
        mkdir -p "$baseDir/$workDir/logs"
        cd "$baseDir/$workDir"
        mkdir timescaledb && tar -xf $timescaleDBSource --strip-components=1 -C timescaledb
        cd timescaledb

        buildLocation="$baseDir/$workDir/build/$componentName"

        prepComponentBuildDir $buildLocation

        PATH=/opt/pgbin-build/pgbin/bin:$buildLocation/bin:$PATH

	bootstrap_log=$baseDir/$workDir/logs/timescaledb_bootstrap.log
	./bootstrap -DAPACHE_ONLY=1 -DREGRESS_CHECKS=OFF > $bootstrap_log 2>&1
        if [[ $? -ne 0 ]]; then
                echo "timescaledb Bootstrap failed, check logs for details."
                echo "  $bootstrap_log"
                return 1
        fi

	cd build
        make_log=$baseDir/$workDir/logs/timescaledb_make.log
        USE_PGXS=1 make -d > $make_log 2>&1
        if [[ $? -eq 0 ]]; then
                USE_PGXS=1 make install > $baseDir/$workDir/logs/timescaledb_install.log 2>&1
                if [[ $? -ne 0 ]]; then
                        echo "timescaledb install failed, check logs for details."
                fi
        else
                echo "timescaledb Make failed, check logs for details."
                echo "  $make_log"
                return 1
        fi

        componentBundle=$componentName
        cleanUpComponentDir $buildLocation
        updateSharedLibs
        packageComponent $componentBundle
}

TEMP=`getopt -l copy-bin,no-copy-bin,with-pgver:,with-pgbin:,build-hypopg:,build-postgis:,build-pgbouncer:,build-presto_fdw:,build-cassandra_fdw:,build-pgtsql:,build-tds-fdw:,build-mongo-fdw:,build-mysql-fdw:,build-oraclefdw:,build-orafce:,build-audit:,build-set-user:,build-partman:,build-pldebugger:,build-plr:,build-pljava:,build-plv8:,build-plprofiler:,build-background:,build-bulkload:,build-cstore-fdw:,build-parquet-fdw:,build-repack:,build-pglogical:,build-hintplan:,build-timescaledb:,build-pgagent:,build-cron:,build-pgmp:,build-fixeddecimal:,build-anon,build-ddlx:,build-http:,build-number: -- "$@"`

if [ $? != 0 ] ; then
	echo "Required parameters missing, Terminating..."
	exit 1
fi

copyBin=false
compDir="$8"

while true; do
  case "$1" in
    --with-pgver ) pgVer=$2; shift; shift; ;;
    --with-pgbin ) pgBinPassed=true; pgBin=$2; shift; shift; ;;
    --target-dir ) targetDirPassed=true; targetDir=$2; shift; shift; ;;
    --build-postgis ) buildPostGIS=true; Source=$2; shift; shift ;;
    --build-bouncer ) buildBouncer=true; Source=$2; shift; shift; ;;
    --build-presto_fdw ) buildAthena=true; Source=$2; shift; shift ;;
    --build-cassandra_fdw ) buildCassandra=true; Source=$2; shift; shift ;;
    --build-pgtsql ) buildTSQL=true; tsqlSource=$2; shift; shift ;;
    --build-tds-fdw ) buildTDSFDW=true; tdsFDWSource=$2; shift; shift ;;
    --build-mongo-fdw ) buildMongoFDW=true mongoFDWSource=$2; shift; shift ;;
    --build-mysql-fdw ) buildMySQLFDW=true; mysqlFDWSource=$2; shift; shift ;;
    --build-oraclefdw ) buildOracleFDW=true; Source=$2; shift; shift ;;
    --build-orafce ) buildOrafce=true; Source=$2; shift; shift ;;
    --build-audit ) buildAudit=true; Source=$2; shift; shift ;;
    --build-set-user ) buildSetUser=true; setUserSource=$2; shift; shift ;;
    --build-walg ) buildWalg=true; Source=$2; shift; shift ;;
    --build-hypopg ) buildHypopg=true; Source=$2; shift; shift ;;
    --build-pldebugger ) buildPLDebugger=true; Source=$2; shift; shift ;;
    --build-partman ) buildPartman=true; Source=$2; shift; shift ;;
    --build-plr ) buildPlr=true; plrSource=$2; shift; shift ;;
    --build-plv8 ) buildPlV8=true; Source=$2; shift; shift ;;
    --build-pljava ) buildPlJava=true; Source=$2; shift; shift ;;
    --build-plprofiler ) buildPlProfiler=true; plProfilerSource=$2; shift; shift ;;
    --build-background ) buildBackground=true; backgroundSource=$2; shift; shift ;;
    --build-bulkload ) buildBulkLoad=true; Source=$2; shift; shift ;;
    --build-cstore-fdw ) buildCstoreFDW=true; cstoreFDWSource=$2; shift; shift ;;
    --build-parquet-fdw ) buildParquetFDW=true; parquetFDWSource=$2; shift; shift ;;
    --build-repack ) buildRepack=true; Source=$2; shift; shift ;;
    --build-pglogical ) buildPgLogical=true; Source=$2; shift; shift ;;
    --build-hintplan ) buildHintPlan=true; Source=$2; shift; shift ;;
    --build-timescaledb ) buildTimeScaleDB=true; timescaleDBSource=$2; shift; shift ;;
    --build-pgagent ) buildPGAgent=true; pgAgentSource=$2; shift; shift ;;
    --build-cron ) buildCron=true; cronSource=$2; shift; shift ;;
    --build-pgmp ) buildPgMp=true; pgmpSource=$2; shift; shift ;;
    --build-fixeddecimal ) buildFD=true; Source=$2; shift; shift ;;
    --build-anon ) buildAnon=true; Source=$2; shift; shift ;;
    --build-ddlx ) buildDdlx=true; Source=$2; shift; shift ;;
    --build-http ) buildHttp=true; Source=$2; shift; shift ;;
    --build-number ) buildNumber=$2; shift; shift ;;
    --copy-bin ) copyBin=true; shift; shift; ;;
    --no-copy-bin ) copyBin=false; shift; shift; ;;
    -- ) shift; break ;;
    -* ) echo "Invalid Option Passed"; exit 1; ;;
    * ) break ;;
  esac
done

if [[ $pgBinPassed != "true" ]]; then
	echo "Please provide a valid PostgreSQL version to build ..."
	exit 1
fi

getPGVersion

PGHOME=$pgBin

if [[ $buildCassandra == "true" ]]; then
	buildComp cassandra_fdw "$cassShortV" "$cassFullV" "$cassBuildV" "$Source"
fi

if [[ $buildAthena == "true" ]]; then
	buildComp presto_fdw "$prestoShortV" "$prestoFullV" "$prestoBuildV" "$Source"
fi

if [[ $buildOrafce == "true" ]]; then
	buildComp orafce "$orafceShortV" "$orafceFullV" "$orafceBuildV" "$Source"
fi

if [[ $buildTDSFDW == "true" ]]; then
	buildTDSFDWComponent
fi

if [[ $buildOracleFDW == "true" ]]; then
	buildComp oraclefdw "$oFDWShortVersion" "$oFDWFullVersion" "$oFDWBuildV" "$Source"
fi

if [[ $buildPostGIS ==  "true" ]]; then
	if [ "$pgShortVersion" == "11" ]; then
		buildComp postgis "$postgisShortV" "$postgisFull25V" "$postgisBuildV" "$Source"
	else
		buildComp postgis "$postgisShortV" "$postgisFull30V" "$postgisBuildV" "$Source"
	fi
fi

if [[ $buildAudit == "true" ]]; then
	if [ "$pgShortVersion" == "11" ]; then
		buildComp audit "$auditShortV" "$auditFull11V" "$auditBuildV" "$Source"
	else
		buildComp audit "$auditShortV" "$auditFull12V" "$auditBuildV" "$Source"
	fi
fi

if [[ $buildSetUser == "true" ]]; then
	buildSetUserComponent
fi

if [ "$buildHypopg" == "true" ]; then
	buildComp hypopg "$hypopgShortV" "$hypopgFullV" "$hypopgBuildV" "$Source"
fi

if [ "$buildWalg" == "true" ]; then
	buildComp wal_g "$walgShortV" "$walgFullV" "$walgBuildV" "$Source"
fi

if [[ $buildRepack == "true" ]]; then
	buildComp repack  "$repackShortV" "$repackFullV" "$repackBuildV" "$Source"
fi

if [[ $buildPgLogical == "true" ]]; then
	buildComp pglogical  "$pgLogicalShortV" "$pgLogicalFullV" "$pgLogicalBuildV" "$Source"
fi

if [[ $buildPLDebugger == "true" ]]; then
	buildComp pldebugger  "$debugShortV" "$debugFullV" "$debugBuildV" "$Source"
fi

if [[ $buildPartman == "true" ]]; then
    buildComp partman "$partmanShortV" "$partmanFullV" "$partmanBuildV" "$Source"
fi

if [[ $buildMySQLFDW == "true" ]]; then
	buildMySQLFDWComponent
fi

if [[ $buildPlr == "true" ]]; then
	buildPlRComponent
fi

if [[ $buildPlJava == "true" ]]; then
    buildComp pljava  "$pljavaShortV" "$pljavaFullV" "$pljavaBuildV" "$Source"
##	buildPlJavaComponent
fi

if [[ $buildPlV8 == "true" ]]; then
    buildComp plv8  "$plv8ShortV" "$plv8FullV" "$plv8BuildV" "$Source"
fi
if [[ $buildTSQL == "true" ]]; then
	buildTSQLComponent
fi
if [[ $buildPlProfiler == "true" ]]; then
	buildPlProfilerComponent
fi
if [[ $buildBackground == "true" ]]; then
        buildBackgroundComponent
fi
if [[ $buildBulkLoad == "true" ]]; then
        buildComp bulkload "$bulkloadShortV" "$bulkloadFullV" "$bulkloadBuildV" "$Source"
fi
if [[ $buildCstoreFDW == "true" ]]; then
	buildCstoreFDWComponent
fi
if [[ $buildParquetFDW == "true" ]]; then
	buildParquetFDWComponent
fi
if [[ $buildHintPlan == "true" ]]; then
        buildComp hintplan "$hintplanShortV" "$hintplanFullV" "$hintplanBuildV" "$Source"
fi
if [[ $buildTimeScaleDB == "true" ]]; then
        buildTimeScaleDBComponent
fi
if [[ $buildPGAgent == "true" ]]; then
        buildPGAgentComponent
fi
if [[ $buildCron == "true" ]]; then
        buildCronComponent
fi
if [[ $buildPgMp == "true" ]]; then
        buildPgMpComponent
fi
if [[ $buildBouncer == "true" ]]; then
        buildComp bouncer      "$ShortV"   "$fullV"   "$BuildV"   "$Source"
fi
if [[ $buildFD == "true" ]]; then
	buildComp fixeddecimal "$fdShortV" "$fdFullV" "$fdBuildV" "$Source"
fi
if [[ $buildAnon == "true" ]]; then
	buildComp anon "$anonShortV" "$anonFullV" "$anonBuildV" "$Source"
fi
if [[ $buildDdlx == "true" ]]; then
	buildComp ddlx "$ddlxShortV" "$ddlxFullV" "$ddlxBuildV" "$Source"
fi
if [[ $buildHttp == "true" ]]; then
	buildComp http "$httpShortV" "$httpFullV" "$httpBuildV" "$Source"
fi

destDir=`date +%Y-%m-%d`
fullDestDir=/opt/pgbin-builds/$destDir
#ssh build@$pgcentral "mkdir -p $fullDestDir"
#scp $targetDir/$workDir/$componentBundle.tar.bz2 build@$pgcentral:$fullDestDir/

exit 0

