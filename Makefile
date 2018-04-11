.PHONY: test

PKG_PATH = github.com/exavolt/go-xmpplib
DEP_IMAGE ?= go-xmpplib-dep
TESTER_IMAGE ?= go-xmpplib-tester

test:
	docker build -t $(DEP_IMAGE) -f dep.dockerfile .
	docker run --rm \
		-v $(CURDIR):/go/src/$(PKG_PATH) \
		--workdir /go/src/$(PKG_PATH) \
		$(DEP_IMAGE) ensure -update
	docker build -t $(TESTER_IMAGE) -f tester.dockerfile .
	docker run --rm \
		-v $(CURDIR):/go/src/$(PKG_PATH) \
		--workdir /go/src/$(PKG_PATH) \
		$(TESTER_IMAGE) test -v ./...