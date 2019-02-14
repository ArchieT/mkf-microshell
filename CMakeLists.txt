cmake_minimum_required(VERSION 3.9)
project(mkf-microshell)
#TODO: set C standard

set(SOURCE_FILES
	main.c
	input.c
	)

file(GLOB KWS_DAT_FILES "*.kws.dat")
list(TRANSFORM KWS_DAT_FILES REPLACE "\.dat$" "" OUTPUT_VARIABLE KWS_NAMES_W_SUFFIX)

foreach(kws-name ${KWS_NAMES_W_SUFFIX})
	add_custom_command(
		COMMAND ./kws.pl < ${kws-name}.dat > ${kws-name}.h
		DEPENDS kws.pl ${kws-name}.dat
		OUTPUT ${kws-name}.h
		COMMENT "Doing ${kws-name}."
		)
endforeach(kws-name)

# list(TRANSFORM KWS_DAT_FILES REPLACE "dat" "h" OUTPUT_VARIABLE KWS_HEADER_FILES)
list(TRANSFORM KWS_NAMES_W_SUFFIX APPEND ".h" OUTPUT_VARIABLE KWS_HEADER_FILES)

set(HEADER_FILES
	helpfulcontrolsequences.h
	input.h
	${KWS_HEADER_FILES}
	)

set(SOURCES
	${SOURCE_FILES}
	${HEADER_FILES}
	${KWS_DAT_FILES}
	)

add_executable(${PROJECT_NAME} ${SOURCE_FILES})
add_custom_target(headers_${PROJECT_NAME} DEPENDS ${HEADER_FILES})
add_dependencies(${PROJECT_NAME} headers_${PROJECT_NAME})
