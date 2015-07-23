OUTPUT = output

SRC = 'src/**/*.purs'
LIB = 'bower_components/purescript-*/src/**/*.purs'
LIB_FFI = 'bower_components/purescript-*/src/**/*.js'
TESTS = 'test/**/*.purs'

DEFAULT_PSC_ARGS = $(SRC) $(LIB) --ffi $(LIB_FFI)

NODEMON=node_modules/.bin/nodemon

build: $(OUTPUT)
	psc $(DEFAULT_PSC_ARGS) -o $(OUTPUT)/lib

$(OUTPUT):
	mkdir -p $@

ctags:
	psc-docs --format ctags $(SRC) $(LIB) > tags

run-tests:
	psc $(TESTS) $(DEFAULT_PSC_ARGS) -o $(OUTPUT)/tests
	@NODE_PATH=$(OUTPUT)/tests node -e "require('Test.Main').main();"

$(NODEMON):
	npm install nodemon@1.2

watch-tests: $(NODEMON)
	$(NODEMON) --watch src --watch tests -e purs --exec make run-tests
