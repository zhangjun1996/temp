PREFIX 	= 
CC 	= $(PREFIX)gcc
CPP	= $(PREFIX)g++
AS 	= $(PREFIX)gcc
AR 	= $(PREFIX)ar
LINK 	= $(PREFIX)gcc
SIZE 	= $(PREFIX)size
OBJDUMP = $(PREFIX)objdump
OBJCPY 	= $(PREFIX)objcopy

DEVICE 	= 
CFLAGS 	= $(DEVICE) 
CXXFLAGS= $(DEVICE)  
AFLAGS 	= $(DEVICE)  
LFLAGS 	= $(DEVICE) -Wl,--gcsections,_map=${TARGET}.map

CPATH 	= 
LPATH 	= 
BUILD   = debug

ifeq '$(BUILD)'  'debug'
	CFLAGS +=  -O0 -gdwarf-2
	CXXFLAGS += -O0
	AFLAGS +=  -gdwarf-2
else
	CFLAGS +=  -O2
	CXXFLAGS += -O2
endif

ROOT_DIR = ${shell pwd}
SUB_DIR = ${shell ls -l "${ROOT_DIR}" | grep ^d | awk '{if($$9 != "build") print $$9 }'}
BUILD_DIR = build
TARGET = test
export CC CPP AS AR LINK SIZE OBJDUMP OBJCPY DEVICE CFLAGS CXXFLAGS ASFLAGS LFLAGS BUILD ROOT_DIR BUILD_DIR

SRC_FILE = ${wildcard *.c}
SRC_FILE += ${wildcard *.cpp}
SRC_FILE += ${wildcard *.s}
#SRC_FILE = ${shell ls *.c}
#OBJ_FILE = ${SRC_FILE:.c=.o}
TMP = ${patsubst %.c, %.o, ${SRC_FILE}}
TMP += ${patsubst %.cpp, %.o, ${SRC_FILE}}
TMP += ${patsubst %.s, %.o, ${SRC_FILE}}
OBJ_FILE = $(filter %.o, $(TMP))


# Attempt to create a output directory.
$(shell [ -d ${BUILD_DIR} ]  || mkdir -p ${BUILD_DIR})
# Verify if it was successful.
BUILD_DIR := $(shell cd $(BUILD_DIR) && /bin/pwd)
$(if $(BUILD_DIR),,$(error output directory "$(saved-output)" does not exist))

all: $(TARGET)


$(SUB_DIR):ECHO
	-make -C "${ROOT_DIR}/$@"

%.o:%.cpp
	${CPP} ${CXXFLAGS} -c "$^" -o "${BUILD_DIR}/$@"

%.o:%.c
	${CC} ${CFLAGS}    -c "$^" -o "${BUILD_DIR}/$@"

%.o:%.s
	${AS} ${ASFLAGS}   -c "$^" -o "${BUILD_DIR}/$@"

$(TARGET): $(SUB_DIR) $(OBJ_FILE)
	cd "${BUILD_DIR}"  && ${CC} ${LFLAGS} $(filter %.o, $(shell  ls "$(BUILD_DIR)")) -o "$(TARGET)" \
		&& ${SIZE}  -d "$(TARGET)"

ECHO:
	@echo ${SUB_DIR}

clean:
	-cd ${BUILD_DIR}&&rm *

.PHONY: all
