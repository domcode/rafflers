.RECIPEPREFIX +=

all: build

build:
    ./build.sh

rebuild:
    ./build.sh --rebuild

test: rebuild
    ./test.sh ${RAFFLER}

raffle:
    ./raffle.sh ${NAMES}

clean:
    docker rmi $(docker images | grep _raffler | awk '{ print $1 }')
