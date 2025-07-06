VERSION = $(shell cat version)
# 增加一行备注
dep:
	git submodule update --init
	git submodule update --force --remote
	git submodule foreach -q --recursive 'git reset --hard && git checkout ${VERSION}'

patch: dep
	cd harbor && bash ../.hack/patch.sh

tools-install:
	go install github.com/octohelm/cuemod/cmd/cuem@latest

apply:
	cuem k apply ./components/harbor

uninstall:
	cuem k delete ./components/harbor
