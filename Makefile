cc:=gcc

BUILD_TYPE ?= debug

BUILD_DIR:=build
SRC_DIR:=app
INCLUDE_DIR:=include
LIB_DIR:=lib
TEST_DIR:=test

TRAY_SRC_FILES:=$(wildcard $(SRC_DIR)/tray/*.c)
GANTRY_SRC_FILES:=$(wildcard $(SRC_DIR)/gantry/*.c)

LIB_FILES:=$(wildcard $(LIB_DIR)/**/*.c)
TEST_FILES:=$(wildcard $(TEST_DIR)/*.c)

ifeq ($(BUILD_TYPE), debug)
	CFLAGS:=-g -Wall -Wextra -Werror -I$(INCLUDE_DIR)
else ifeq ($(BUILD_TYPE), release)
	CFLAGS:=-O3 -Wall -Wextra -Werror -I$(INCLUDE_DIR)
else
	$(error "Invalid build type")
endif

TRAY_BINARY:=tray
TEST_BINARY:=test

run: build-tray
	./$(BUILD_DIR)/tray/$(TRAY_BINARY)-$(BUILD_TYPE)

build-dir:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/test
	mkdir -p $(BUILD_DIR)/tray
	mkdir -p $(BUILD_DIR)/gantry

build-tray: build-dir
	$(cc) $(CFLAGS) $(TRAY_SRC_FILES) $(LIB_FILES) -o $(BUILD_DIR)/tray/$(TRAY_BINARY)-$(BUILD_TYPE)

build-test: build-dir
	$(cc) $(CFLAGS) $(TEST_FILES) $(LIB_FILES) -o $(BUILD_DIR)/test/$(TEST_BINARY)-$(BUILD_TYPE)

test: build-test
	./$(BUILD_DIR)/test/$(TEST_BINARY)-$(BUILD_TYPE)

clean:
	rm -rf $(BUILD_DIR)
