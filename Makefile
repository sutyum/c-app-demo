cc:=gcc

BUILD_TYPE ?= debug

BUILD_DIR:=build
SRC_DIR:=src
INCLUDE_DIR:=include
LIB_DIR:=lib
TEST_DIR:=test

SRC_FILES:=$(wildcard $(SRC_DIR)/*.c)
LIB_FILES:=$(wildcard $(LIB_DIR)/*.c)
TEST_FILES:=$(wildcard $(TEST_DIR)/*.c)

ifeq ($(BUILD_TYPE), debug)
	CFLAGS:=-g -Wall -Wextra -Werror -I$(INCLUDE_DIR)
else ifeq ($(BUILD_TYPE), release)
	CFLAGS:=-O3 -Wall -Wextra -Werror -I$(INCLUDE_DIR)
else
	$(error "Invalid build type")
endif

FIRMWARE_BINARY:=rail
TEST_BINARY:=test

run: build
	./$(BUILD_DIR)/$(FIRMWARE_BINARY)-$(BUILD_TYPE)

build-dir:
	mkdir -p $(BUILD_DIR)

build: build-dir
	$(cc) $(CFLAGS) $(SRC_FILES) $(LIB_FILES) -o $(BUILD_DIR)/$(FIRMWARE_BINARY)-$(BUILD_TYPE)

build-test: build-dir
	$(cc) $(CFLAGS) $(TEST_FILES) $(LIB_FILES) -o $(BUILD_DIR)/$(TEST_BINARY)-$(BUILD_TYPE)

test: build-test
	./$(BUILD_DIR)/$(TEST_BINARY)-$(BUILD_TYPE)
