OUTPUT = output

SRC = 'src/**/*.purs'
LIB = 'bower_components/purescript-*/src/**/*.purs'
TESTS = 'test/**/*.purs'

DEFAULT_PURS_ARGS = $(SRC) $(LIB)

NODEMON=node_modules/.bin/nodemon

build: $(OUTPUT)
	purs compile $(DEFAULT_PURS_ARGS) -o $(OUTPUT)/lib

$(OUTPUT):
	mkdir -p $@

ctags:
	purs docs --format ctags $(SRC) $(LIB) > tags

run-tests:
	purs compile $(TESTS) $(DEFAULT_PURS_ARGS) -o $(OUTPUT)/tests
	@NODE_PATH=$(OUTPUT)/tests node -e "require('Test.Main').main();"

$(NODEMON):
	npm install nodemon@1.2

watch-tests: $(NODEMON)
	$(NODEMON) --watch src --watch tests -e purs compile --exec make run-tests
