.RECIPEPREFIX +=

all: build

build:
    ./build.sh

rebuild:
    ./build.sh --rebuild

test: rebuild
    ./test.sh

raffle:
    ./raffle.sh ${NAMES}

clean:
    docker rmi $(docker images | grep _raffler | awk '{ print $1 }')
