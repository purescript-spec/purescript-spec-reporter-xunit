OUTPUT = output

SRC = $(shell find src -type f -name '*.purs')
LIB = $(shell find bower_components/purescript-*/src -type f -name '*.purs')

TESTS = $(shell find tests -type f -name '*.purs')

NODEMON=node_modules/.bin/nodemon

build: $(OUTPUT)
	psc-make -o output/lib $(SRC) $(LIB)

$(OUTPUT):
	mkdir -p $@

docs:
	psc-docs $(SRC) > API.md

ctags:
	psc-docs --format ctags $(SRC) $(LIB) > tags

run-tests:
	psc-make -o $(OUTPUT)/tests $(TESTS) $(SRC) $(LIB)
	@NODE_PATH=$(OUTPUT)/tests node -e "require('Main').main();"

$(NODEMON):
	npm install nodemon@1.2

watch-tests: $(NODEMON)
	$(NODEMON) --watch src --watch tests -e purs --exec make run-tests
