SUB_DIR = ${shell ls -l | grep ^d | awk '{if($$9 != "build") print $$9 }'}
SRC_FILE = ${wildcard *.c}
SRC_FILE += ${wildcard *.cpp}
SRC_FILE += ${wildcard *.s}
#SRC_FILE = ${shell ls *.c}
#OBJ_FILE = ${SRC_FILE:.c=.o}
TMP = ${patsubst %.c, %.o, ${SRC_FILE}}
TMP += ${patsubst %.cpp, %.o, ${SRC_FILE}}
TMP += ${patsubst %.s, %.o, ${SRC_FILE}}
OBJ_FILE = $(filter %.o, $(TMP))

all: ${SUB_DIR} ${OBJ_FILE}


${SUB_DIR}:ECHO
	-make -C $@

%.o:%.cpp
	${CPP} ${CXXFLAGS} -c "$^" -o "${BUILD_DIR}/$@"

%.o:%.c
	${CC} ${CFLAGS}    -c "$^" -o "${BUILD_DIR}/$@"

%.o:%.s
	${AS} ${ASFLAGS}   -c "$^" -o "${BUILD_DIR}/$@"


ECHO:
	@echo ${SUB_DIR}
clean:
	-cd ${BUILD_DIR}&&rm *

.PHONY: all
