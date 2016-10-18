.RECIPEPREFIX +=

all: build

build:
    ./build.sh

rebuild:
    ./build.sh --rebuild

test: rebuild
    ./test.sh

test-changed:
    git diff --name-only master... | xargs -n1 -I {} find {} -type f | xargs -n1 dirname | grep -vE '\.\.?' | grep -vE '.+/.+' | sort | uniq | xargs -n1 -I {} sh -c 'make test RAFFLER={}'

raffle:
    ./raffle.sh ${NAMES}

clean:
    docker rmi $(docker images | grep _raffler | awk '{ print $1 }')
