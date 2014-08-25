#!/bin/sh

vfs_dir=/var/lib/docker/vfs/dir
tag=test20140825

# Check to see if we can see the status of the vfs directory
ls $vfs_dir >/dev/null 2>/dev/null

if [ ! $? -eq 0 ]
then
    echo "Error: Unable to show you the status of $vfs_dir"
    echo "Are you root?"
    echo ""
    echo "By default, only root has permissions to read that directory."
    echo "You can also run the build and check the status manually:"
    echo
    echo "ls $vfs_dir | wc -l"
    echo "docker ps -aq | wc -l"
    echo "docker images -aq | wc -l"
    echo ""
    echo "docker build -t $tag ."
    echo ""
    exit 254
fi

display_count() {
    vfs_count=`ls -l $vfs_dir | wc -l`
    dps_count=`docker ps -aq | wc -l`
    image_count=`docker images -aq| wc -l`

    echo "$@ [ ls vfs            | wc -l ]: $vfs_count"
    echo "$@ [ docker ps -aq     | wc -l ]: $dps_count"
    echo "$@ [ docker images -aq | wc -l ]: $image_count"
}

build_test() {
    echo "Running [$@]"
    docker build -t $tag .  >/dev/null 2>/dev/null

    if [ ! $? -eq 0 ]
    then
        echo ""
        echo "--------"
        echo "WARNING!"
        echo "--------"
        echo "Build Failed!"
        exit 255
    fi
    docker rmi $tag >/dev/null 2>/dev/null
}

display_count "Before"

build_test "Build 1"
display_count "Build 1"

build_test "Build 2"
display_count "Build 2"

build_test "Build 3"
display_count "Build 3"

