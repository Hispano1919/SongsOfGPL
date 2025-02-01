
Help()
{
    echo
    echo "Build .dll or .so for this operating system and cpu architecture."
    echo " -d     compile DataContainerGenerator"
    echo " -g     compile LuaDLLGenerator"
    echo " -c     clean build folder afterwards"
    echo " -u     update DataContainer repository"
    echo
}

Clean=false
Update=false
COMPILE_LUA=false
COMPILE_DCON=false

#check for optional rebuilding options
while getopts ":hbcr" option; do
    case $option in
        h) # display Help
            Help
            exit;;
        b) # build generators
            Lua=true
            DCon=true;;
        c) # clean builder folder
            Clean=true;;
        r) # update DataContainer repo
            Repo=true;;
        \?) # Invalid option
            echo "Error: Invalid option $OPTARG"
            Help
            exit;;
    esac
done

Arch="$(uname -p)"

# check for generators
if ! [ -f "./build/Linux/$Arch/LuaDLLGenerator" ]; then
    echo "LuaDLLGenerator not found!"
    COMPILE_LUA=true
fi
if ! [ -f "./build/Linux/$Arch/DataContainerGenerator" ]; then
    echo "DataContainerGenerator not found!"
    COMPILE_DCON=true
fi

Build=$COMPILE_DCON||$COMPILE_LUA
echo "$Build"
# check for datacontainer repo
if $Build && ! [ -d "./build/DataContainer/.git" ]; then
    echo "DataContainer repository not found!"
    Repo=true
fi

# clean and redownload repository
if $Repo; then
    echo "Fetching DataContainer repository..."
    ./update-data-container.sh
fi

python3 codegen/build.py $COMPILE_LUA $COMPILE_DCON true true

if $Clean; then
    echo "Removing build files..."
    rm -rf ./build
fi