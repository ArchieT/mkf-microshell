TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
        main.c \
    input.c

HEADERS += \
    helpfulcontrolsequences.h \
    input.h

KWS = builtincmd.kws.dat

kws.input = KWS
kws.output = ${QMAKE_FILE_BASE}.h
kws.clean = ${QMAKE_FILE_OUT}
kws.depends = kws.pl
kws.commands = ./kws.pl < ${QMAKE_FILE_NAME} > ${QMAKE_FILE_OUT}
kws.dependency_type = TYPE_C
kws.variable_out = HEADERS
kws.config += no_link
kws.config += target_predeps

QMAKE_EXTRA_COMPILERS += kws

DISTFILES += \
    builtincmd.kws.dat \
    kws.pl
