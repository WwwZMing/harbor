export VERSION = $(shell cat version)

all: dep patch

dep:
	git submodule update --init --recursive
	git submodule update --force --remote
	git submodule foreach -q --recursive 'git reset --hard && git checkout ${VERSION}'

patch:
	cd harbor && sh -c "curl https://github.com/goharbor/harbor/compare/$(VERSION)...morlay:harbor:release-2.3.0.patch | git apply -v"

