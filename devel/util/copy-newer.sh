oldOutFile=$1
newOutDir=$2

find out -type f -newer out/$oldOutFile -exec cp -p {} apg_history/$newOutDir/. \;
