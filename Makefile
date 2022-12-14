CC            = gcc
CXX           = g++
DEFINES       = -DQT_CORE_LIB -DQT_SHARED
CFLAGS        = -pipe -g -Wall -W -D_REENTRANT $(DEFINES)
CXXFLAGS      = -pipe -g -Wall -W -D_REENTRANT $(DEFINES)
INCPATH       = -I/usr/share/qt/mkspecs/linux-g++ -I. -I/usr/include/QtCore -I/usr/include -I/usr/include -I/usr/include/libxml2 -I/usr/include/GL -I.
LINK          = g++
LFLAGS        = -Wl,-O1,--sort-common,--as-needed,-z,relro,--hash-style=gnu
LIBS          = $(SUBLIBS)  -L/usr/lib -lfreeimage /usr/lib/libGL.so /usr/lib/libSDL.so -lGLEW -lQtCore -lpthread 
AR            = ar cqs
RANLIB        = 
QMAKE         = /usr/bin/qmake
TAR           = tar -cf
COMPRESS      = gzip -9f
COPY          = cp -f
SED           = sed
COPY_FILE     = $(COPY)
COPY_DIR      = $(COPY) -r
STRIP         = strip
INSTALL_FILE  = install -m 644 -p
INSTALL_DIR   = $(COPY_DIR)
INSTALL_PROGRAM = install -m 755 -p
DEL_FILE      = rm -f
SYMLINK       = ln -f -s
DEL_DIR       = rmdir
MOVE          = mv -f
CHK_DIR_EXISTS= test -d
MKDIR         = mkdir -p

####### Output directory

OBJECTS_DIR   = ./

####### Files

SOURCES       = main.cpp \
		fileIO.cpp \
		renderer.cpp \
		sprite.cpp \
		shaders.cpp 
OBJECTS       = main.o \
		fileIO.o \
		renderer.o \
		sprite.o \
		shaders.o
DIST          = /usr/share/qt/mkspecs/common/unix.conf \
		/usr/share/qt/mkspecs/common/linux.conf \
		/usr/share/qt/mkspecs/common/gcc-base.conf \
		/usr/share/qt/mkspecs/common/gcc-base-unix.conf \
		/usr/share/qt/mkspecs/common/g++-base.conf \
		/usr/share/qt/mkspecs/common/g++-unix.conf \
		/usr/share/qt/mkspecs/qconfig.pri \
		/usr/share/qt/mkspecs/modules/qt_phonon.pri \
		/usr/share/qt/mkspecs/modules/qt_webkit_version.pri \
		/usr/share/qt/mkspecs/features/qt_functions.prf \
		/usr/share/qt/mkspecs/features/qt_config.prf \
		/usr/share/qt/mkspecs/features/exclusive_builds.prf \
		/usr/share/qt/mkspecs/features/default_pre.prf \
		/usr/share/qt/mkspecs/features/debug.prf \
		/usr/share/qt/mkspecs/features/default_post.prf \
		/usr/share/qt/mkspecs/features/link_pkgconfig.prf \
		/usr/share/qt/mkspecs/features/declarative_debug.prf \
		/usr/share/qt/mkspecs/features/unix/gdb_dwarf_index.prf \
		/usr/share/qt/mkspecs/features/warn_on.prf \
		/usr/share/qt/mkspecs/features/qt.prf \
		/usr/share/qt/mkspecs/features/unix/thread.prf \
		/usr/share/qt/mkspecs/features/moc.prf \
		/usr/share/qt/mkspecs/features/resources.prf \
		/usr/share/qt/mkspecs/features/uic.prf \
		/usr/share/qt/mkspecs/features/yacc.prf \
		/usr/share/qt/mkspecs/features/lex.prf \
		/usr/share/qt/mkspecs/features/include_source_dir.prf \
		devtest.pro
QMAKE_TARGET  = devtest
DESTDIR       = 
TARGET        = devtest

first: all
####### Implicit rules

.SUFFIXES: .o .c .cpp .cc .cxx .C

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.cc.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.cxx.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.C.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.c.o:
	$(CC) -c $(CFLAGS) $(INCPATH) -o "$@" "$<"

####### Build rules

all: Makefile $(TARGET)

$(TARGET):  $(OBJECTS)  
	$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJCOMP) $(LIBS)
	{ test -n "$(DESTDIR)" && DESTDIR="$(DESTDIR)" || DESTDIR=.; } && test $$(gdb --version | sed -e 's,[^0-9]\+\([0-9]\)\.\([0-9]\).*,\1\2,;q') -gt 72 && gdb --nx --batch --quiet -ex 'set confirm off' -ex "save gdb-index $$DESTDIR" -ex quit '$(TARGET)' && test -f $(TARGET).gdb-index && objcopy --add-section '.gdb_index=$(TARGET).gdb-index' --set-section-flags '.gdb_index=readonly' '$(TARGET)' '$(TARGET)' && rm -f $(TARGET).gdb-index || true

Makefile: devtest.pro  /usr/share/qt/mkspecs/linux-g++/qmake.conf /usr/share/qt/mkspecs/common/unix.conf \
		/usr/share/qt/mkspecs/common/linux.conf \
		/usr/share/qt/mkspecs/common/gcc-base.conf \
		/usr/share/qt/mkspecs/common/gcc-base-unix.conf \
		/usr/share/qt/mkspecs/common/g++-base.conf \
		/usr/share/qt/mkspecs/common/g++-unix.conf \
		/usr/share/qt/mkspecs/qconfig.pri \
		/usr/share/qt/mkspecs/modules/qt_phonon.pri \
		/usr/share/qt/mkspecs/modules/qt_webkit_version.pri \
		/usr/share/qt/mkspecs/features/qt_functions.prf \
		/usr/share/qt/mkspecs/features/qt_config.prf \
		/usr/share/qt/mkspecs/features/exclusive_builds.prf \
		/usr/share/qt/mkspecs/features/default_pre.prf \
		/usr/share/qt/mkspecs/features/debug.prf \
		/usr/share/qt/mkspecs/features/default_post.prf \
		/usr/share/qt/mkspecs/features/link_pkgconfig.prf \
		/usr/share/qt/mkspecs/features/declarative_debug.prf \
		/usr/share/qt/mkspecs/features/unix/gdb_dwarf_index.prf \
		/usr/share/qt/mkspecs/features/warn_on.prf \
		/usr/share/qt/mkspecs/features/qt.prf \
		/usr/share/qt/mkspecs/features/unix/thread.prf \
		/usr/share/qt/mkspecs/features/moc.prf \
		/usr/share/qt/mkspecs/features/resources.prf \
		/usr/share/qt/mkspecs/features/uic.prf \
		/usr/share/qt/mkspecs/features/yacc.prf \
		/usr/share/qt/mkspecs/features/lex.prf \
		/usr/share/qt/mkspecs/features/include_source_dir.prf \
		/usr/lib/libQtCore.prl
	$(QMAKE) -spec /usr/share/qt/mkspecs/linux-g++ CONFIG+=debug CONFIG+=declarative_debug -o Makefile devtest.pro
/usr/share/qt/mkspecs/common/unix.conf:
/usr/share/qt/mkspecs/common/linux.conf:
/usr/share/qt/mkspecs/common/gcc-base.conf:
/usr/share/qt/mkspecs/common/gcc-base-unix.conf:
/usr/share/qt/mkspecs/common/g++-base.conf:
/usr/share/qt/mkspecs/common/g++-unix.conf:
/usr/share/qt/mkspecs/qconfig.pri:
/usr/share/qt/mkspecs/modules/qt_phonon.pri:
/usr/share/qt/mkspecs/modules/qt_webkit_version.pri:
/usr/share/qt/mkspecs/features/qt_functions.prf:
/usr/share/qt/mkspecs/features/qt_config.prf:
/usr/share/qt/mkspecs/features/exclusive_builds.prf:
/usr/share/qt/mkspecs/features/default_pre.prf:
/usr/share/qt/mkspecs/features/debug.prf:
/usr/share/qt/mkspecs/features/default_post.prf:
/usr/share/qt/mkspecs/features/link_pkgconfig.prf:
/usr/share/qt/mkspecs/features/declarative_debug.prf:
/usr/share/qt/mkspecs/features/unix/gdb_dwarf_index.prf:
/usr/share/qt/mkspecs/features/warn_on.prf:
/usr/share/qt/mkspecs/features/qt.prf:
/usr/share/qt/mkspecs/features/unix/thread.prf:
/usr/share/qt/mkspecs/features/moc.prf:
/usr/share/qt/mkspecs/features/resources.prf:
/usr/share/qt/mkspecs/features/uic.prf:
/usr/share/qt/mkspecs/features/yacc.prf:
/usr/share/qt/mkspecs/features/lex.prf:
/usr/share/qt/mkspecs/features/include_source_dir.prf:
/usr/lib/libQtCore.prl:
qmake:  FORCE
	@$(QMAKE) -spec /usr/share/qt/mkspecs/linux-g++ CONFIG+=debug CONFIG+=declarative_debug -o Makefile devtest.pro

dist: 
	@$(CHK_DIR_EXISTS) .tmp/devtest1.0.0 || $(MKDIR) .tmp/devtest1.0.0 
	$(COPY_FILE) --parents $(SOURCES) $(DIST) .tmp/devtest1.0.0/ && $(COPY_FILE) --parents fileIO.h renderer.h sprite.h shaders.h .tmp/devtest1.0.0/ && $(COPY_FILE) --parents main.cpp fileIO.cpp renderer.cpp sprite.cpp shaders.cpp .tmp/devtest1.0.0/ && (cd `dirname .tmp/devtest1.0.0` && $(TAR) devtest1.0.0.tar devtest1.0.0 && $(COMPRESS) devtest1.0.0.tar) && $(MOVE) `dirname .tmp/devtest1.0.0`/devtest1.0.0.tar.gz . && $(DEL_FILE) -r .tmp/devtest1.0.0


clean:compiler_clean 
	-$(DEL_FILE) $(OBJECTS)
	-$(DEL_FILE) *~ core *.core


####### Sub-libraries

distclean: clean
	-$(DEL_FILE) $(TARGET) 
	-$(DEL_FILE) Makefile


check: first

mocclean: compiler_moc_header_clean compiler_moc_source_clean

mocables: compiler_moc_header_make_all compiler_moc_source_make_all

compiler_moc_header_make_all:
compiler_moc_header_clean:
compiler_rcc_make_all:
compiler_rcc_clean:
compiler_image_collection_make_all: qmake_image_collection.cpp
compiler_image_collection_clean:
	-$(DEL_FILE) qmake_image_collection.cpp
compiler_moc_source_make_all:
compiler_moc_source_clean:
compiler_uic_make_all:
compiler_uic_clean:
compiler_yacc_decl_make_all:
compiler_yacc_decl_clean:
compiler_yacc_impl_make_all:
compiler_yacc_impl_clean:
compiler_lex_make_all:
compiler_lex_clean:
compiler_clean: 

####### Compile

main.o: main.cpp /usr/include/SDL/SDL.h \
		/usr/include/SDL/SDL_main.h \
		/usr/include/SDL/SDL_stdinc.h \
		/usr/include/SDL/SDL_config.h \
		/usr/include/SDL/SDL_platform.h \
		/usr/include/sys/types.h \
		/usr/include/features.h \
		/usr/include/sys/cdefs.h \
		/usr/include/bits/wordsize.h \
		/usr/include/gnu/stubs.h \
		/usr/include/gnu/stubs-32.h \
		/usr/include/gnu/stubs-64.h \
		/usr/include/bits/types.h \
		/usr/include/bits/typesizes.h \
		/usr/include/time.h \
		/usr/include/bits/time.h \
		/usr/include/bits/timex.h \
		/usr/include/xlocale.h \
		/usr/include/endian.h \
		/usr/include/bits/endian.h \
		/usr/include/bits/byteswap.h \
		/usr/include/sys/select.h \
		/usr/include/bits/select.h \
		/usr/include/bits/sigset.h \
		/usr/include/bits/select2.h \
		/usr/include/sys/sysmacros.h \
		/usr/include/bits/pthreadtypes.h \
		/usr/include/stdio.h \
		/usr/include/libio.h \
		/usr/include/_G_config.h \
		/usr/include/wchar.h \
		/usr/include/bits/wchar.h \
		/usr/include/wctype.h \
		/usr/include/bits/wchar2.h \
		/usr/include/bits/wchar-ldbl.h \
		/usr/include/gconv.h \
		/usr/include/bits/stdio-lock.h \
		/usr/include/bits/libc-lock.h \
		/usr/include/pthread.h \
		/usr/include/sched.h \
		/usr/include/bits/sched.h \
		/usr/include/bits/setjmp.h \
		/usr/include/bits/libio-ldbl.h \
		/usr/include/bits/stdio_lim.h \
		/usr/include/bits/sys_errlist.h \
		/usr/include/getopt.h \
		/usr/include/ctype.h \
		/usr/include/bits/stdio.h \
		/usr/include/bits/stdio2.h \
		/usr/include/bits/stdio-ldbl.h \
		/usr/include/stdlib.h \
		/usr/include/bits/waitflags.h \
		/usr/include/bits/waitstatus.h \
		/usr/include/alloca.h \
		/usr/include/bits/stdlib.h \
		/usr/include/bits/stdlib-ldbl.h \
		/usr/include/malloc.h \
		/usr/include/memory.h \
		/usr/include/string.h \
		/usr/include/bits/string.h \
		/usr/include/bits/string2.h \
		/usr/include/bits/string3.h \
		/usr/include/strings.h \
		/usr/include/inttypes.h \
		/usr/include/stdint.h \
		/usr/include/iconv.h \
		/usr/include/SDL/begin_code.h \
		/usr/include/SDL/close_code.h \
		/usr/include/SDL/SDL_audio.h \
		/usr/include/SDL/SDL_error.h \
		/usr/include/SDL/SDL_endian.h \
		/usr/include/SDL/SDL_mutex.h \
		/usr/include/SDL/SDL_thread.h \
		/usr/include/SDL/SDL_rwops.h \
		/usr/include/SDL/SDL_cdrom.h \
		/usr/include/SDL/SDL_cpuinfo.h \
		/usr/include/SDL/SDL_events.h \
		/usr/include/SDL/SDL_active.h \
		/usr/include/SDL/SDL_keyboard.h \
		/usr/include/SDL/SDL_keysym.h \
		/usr/include/SDL/SDL_mouse.h \
		/usr/include/SDL/SDL_video.h \
		/usr/include/SDL/SDL_joystick.h \
		/usr/include/SDL/SDL_quit.h \
		/usr/include/SDL/SDL_loadso.h \
		/usr/include/SDL/SDL_timer.h \
		/usr/include/SDL/SDL_version.h \
		/usr/include/GL/glew.h \
		/usr/include/GL/glu.h \
		/usr/include/GL/glu_mangle.h \
		/usr/include/GL/gl.h \
		/usr/include/GL/gl_mangle.h \
		/usr/include/GL/glext.h \
		fileIO.h \
		/usr/include/FreeImage.h \
		renderer.h \
		shaders.h \
		sprite.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o main.o main.cpp

fileIO.o: fileIO.cpp fileIO.h \
		/usr/include/string.h \
		/usr/include/features.h \
		/usr/include/sys/cdefs.h \
		/usr/include/bits/wordsize.h \
		/usr/include/gnu/stubs.h \
		/usr/include/gnu/stubs-32.h \
		/usr/include/gnu/stubs-64.h \
		/usr/include/xlocale.h \
		/usr/include/bits/string.h \
		/usr/include/bits/string2.h \
		/usr/include/endian.h \
		/usr/include/bits/endian.h \
		/usr/include/bits/byteswap.h \
		/usr/include/bits/types.h \
		/usr/include/bits/typesizes.h \
		/usr/include/stdlib.h \
		/usr/include/bits/waitflags.h \
		/usr/include/bits/waitstatus.h \
		/usr/include/sys/types.h \
		/usr/include/time.h \
		/usr/include/bits/time.h \
		/usr/include/bits/timex.h \
		/usr/include/sys/select.h \
		/usr/include/bits/select.h \
		/usr/include/bits/sigset.h \
		/usr/include/bits/select2.h \
		/usr/include/sys/sysmacros.h \
		/usr/include/bits/pthreadtypes.h \
		/usr/include/alloca.h \
		/usr/include/bits/stdlib.h \
		/usr/include/bits/stdlib-ldbl.h \
		/usr/include/bits/string3.h \
		/usr/include/stdio.h \
		/usr/include/libio.h \
		/usr/include/_G_config.h \
		/usr/include/wchar.h \
		/usr/include/bits/wchar.h \
		/usr/include/wctype.h \
		/usr/include/bits/wchar2.h \
		/usr/include/bits/wchar-ldbl.h \
		/usr/include/gconv.h \
		/usr/include/bits/stdio-lock.h \
		/usr/include/bits/libc-lock.h \
		/usr/include/pthread.h \
		/usr/include/sched.h \
		/usr/include/bits/sched.h \
		/usr/include/bits/setjmp.h \
		/usr/include/bits/libio-ldbl.h \
		/usr/include/bits/stdio_lim.h \
		/usr/include/bits/sys_errlist.h \
		/usr/include/getopt.h \
		/usr/include/ctype.h \
		/usr/include/bits/stdio.h \
		/usr/include/bits/stdio2.h \
		/usr/include/bits/stdio-ldbl.h \
		/usr/include/GL/glew.h \
		/usr/include/inttypes.h \
		/usr/include/stdint.h \
		/usr/include/GL/glu.h \
		/usr/include/GL/glu_mangle.h \
		/usr/include/GL/gl.h \
		/usr/include/GL/gl_mangle.h \
		/usr/include/GL/glext.h \
		/usr/include/FreeImage.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o fileIO.o fileIO.cpp

renderer.o: renderer.cpp renderer.h \
		/usr/include/GL/glew.h \
		/usr/include/inttypes.h \
		/usr/include/features.h \
		/usr/include/sys/cdefs.h \
		/usr/include/bits/wordsize.h \
		/usr/include/gnu/stubs.h \
		/usr/include/gnu/stubs-32.h \
		/usr/include/gnu/stubs-64.h \
		/usr/include/stdint.h \
		/usr/include/bits/wchar.h \
		/usr/include/GL/glu.h \
		/usr/include/GL/glu_mangle.h \
		/usr/include/GL/gl.h \
		/usr/include/GL/gl_mangle.h \
		/usr/include/stdlib.h \
		/usr/include/bits/waitflags.h \
		/usr/include/bits/waitstatus.h \
		/usr/include/endian.h \
		/usr/include/bits/endian.h \
		/usr/include/bits/byteswap.h \
		/usr/include/xlocale.h \
		/usr/include/sys/types.h \
		/usr/include/bits/types.h \
		/usr/include/bits/typesizes.h \
		/usr/include/time.h \
		/usr/include/bits/time.h \
		/usr/include/bits/timex.h \
		/usr/include/sys/select.h \
		/usr/include/bits/select.h \
		/usr/include/bits/sigset.h \
		/usr/include/bits/select2.h \
		/usr/include/sys/sysmacros.h \
		/usr/include/bits/pthreadtypes.h \
		/usr/include/alloca.h \
		/usr/include/bits/stdlib.h \
		/usr/include/bits/stdlib-ldbl.h \
		/usr/include/GL/glext.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o renderer.o renderer.cpp

sprite.o: sprite.cpp sprite.h \
		shaders.h \
		/usr/include/GL/glew.h \
		/usr/include/inttypes.h \
		/usr/include/features.h \
		/usr/include/sys/cdefs.h \
		/usr/include/bits/wordsize.h \
		/usr/include/gnu/stubs.h \
		/usr/include/gnu/stubs-32.h \
		/usr/include/gnu/stubs-64.h \
		/usr/include/stdint.h \
		/usr/include/bits/wchar.h \
		/usr/include/GL/glu.h \
		/usr/include/GL/glu_mangle.h \
		/usr/include/GL/gl.h \
		/usr/include/GL/gl_mangle.h \
		/usr/include/stdlib.h \
		/usr/include/bits/waitflags.h \
		/usr/include/bits/waitstatus.h \
		/usr/include/endian.h \
		/usr/include/bits/endian.h \
		/usr/include/bits/byteswap.h \
		/usr/include/xlocale.h \
		/usr/include/sys/types.h \
		/usr/include/bits/types.h \
		/usr/include/bits/typesizes.h \
		/usr/include/time.h \
		/usr/include/bits/time.h \
		/usr/include/bits/timex.h \
		/usr/include/sys/select.h \
		/usr/include/bits/select.h \
		/usr/include/bits/sigset.h \
		/usr/include/bits/select2.h \
		/usr/include/sys/sysmacros.h \
		/usr/include/bits/pthreadtypes.h \
		/usr/include/alloca.h \
		/usr/include/bits/stdlib.h \
		/usr/include/bits/stdlib-ldbl.h \
		/usr/include/GL/glext.h \
		/usr/include/string.h \
		/usr/include/bits/string.h \
		/usr/include/bits/string2.h \
		/usr/include/bits/string3.h \
		fileIO.h \
		/usr/include/stdio.h \
		/usr/include/libio.h \
		/usr/include/_G_config.h \
		/usr/include/wchar.h \
		/usr/include/wctype.h \
		/usr/include/bits/wchar2.h \
		/usr/include/bits/wchar-ldbl.h \
		/usr/include/gconv.h \
		/usr/include/bits/stdio-lock.h \
		/usr/include/bits/libc-lock.h \
		/usr/include/pthread.h \
		/usr/include/sched.h \
		/usr/include/bits/sched.h \
		/usr/include/bits/setjmp.h \
		/usr/include/bits/libio-ldbl.h \
		/usr/include/bits/stdio_lim.h \
		/usr/include/bits/sys_errlist.h \
		/usr/include/getopt.h \
		/usr/include/ctype.h \
		/usr/include/bits/stdio.h \
		/usr/include/bits/stdio2.h \
		/usr/include/bits/stdio-ldbl.h \
		/usr/include/FreeImage.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o sprite.o sprite.cpp

shaders.o: shaders.cpp shaders.h \
		/usr/include/GL/glew.h \
		/usr/include/inttypes.h \
		/usr/include/features.h \
		/usr/include/sys/cdefs.h \
		/usr/include/bits/wordsize.h \
		/usr/include/gnu/stubs.h \
		/usr/include/gnu/stubs-32.h \
		/usr/include/gnu/stubs-64.h \
		/usr/include/stdint.h \
		/usr/include/bits/wchar.h \
		/usr/include/GL/glu.h \
		/usr/include/GL/glu_mangle.h \
		/usr/include/GL/gl.h \
		/usr/include/GL/gl_mangle.h \
		/usr/include/stdlib.h \
		/usr/include/bits/waitflags.h \
		/usr/include/bits/waitstatus.h \
		/usr/include/endian.h \
		/usr/include/bits/endian.h \
		/usr/include/bits/byteswap.h \
		/usr/include/xlocale.h \
		/usr/include/sys/types.h \
		/usr/include/bits/types.h \
		/usr/include/bits/typesizes.h \
		/usr/include/time.h \
		/usr/include/bits/time.h \
		/usr/include/bits/timex.h \
		/usr/include/sys/select.h \
		/usr/include/bits/select.h \
		/usr/include/bits/sigset.h \
		/usr/include/bits/select2.h \
		/usr/include/sys/sysmacros.h \
		/usr/include/bits/pthreadtypes.h \
		/usr/include/alloca.h \
		/usr/include/bits/stdlib.h \
		/usr/include/bits/stdlib-ldbl.h \
		/usr/include/GL/glext.h \
		/usr/include/string.h \
		/usr/include/bits/string.h \
		/usr/include/bits/string2.h \
		/usr/include/bits/string3.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o shaders.o shaders.cpp

####### Install

install:   FORCE

uninstall:   FORCE

FORCE:

