function catkin_here {
    local startdir
    local go
    local count
    local end
    startdir=$(pwd)
    go=1
    while [ $go == 1 ]
    do
	count=$(pwd | grep -c '/src/')
	end=$(pwd | grep -c src$)
	if [ $count == 0 ] && [ $end == 0 ]
	then
	    go=0
	else
	    cd ..
	fi
    done
    catkin_make
    cd $startdir
}

function catkin_here_clean {
    local startdir
    local go
    local count
    local end
    startdir=$(pwd)
    go=1
    while [ $go == 1 ]
    do
	count=$(pwd | grep -c '/src/')
	end=$(pwd | grep -c src$)
	if [ $count == 0 ] && [ $end == 0 ]
	then
	    go=0
	else
	    cd ..
	fi
    done
    rm -r build/ devel/
    catkin_make
    cd $startdir
}
