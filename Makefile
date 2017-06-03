.RECIPEPREFIX +=

all: build

build:
    ./build.sh

rebuild:
    ./build.sh --rebuild

test: rebuild
    ./test.sh

test-changed:
    git diff --name-only master... \
    | cut -d "/" -f1 \
    | uniq \
    | xargs -n1 -I {} sh -c 'test -f {}/Dockerfile && make test RAFFLER={} || true'

raffle:
    ./raffle.sh ${NAMES}

clean:
    docker rmi $(docker images | grep _raffler | awk '{ print $1 }')
