# # "cmake-lists": swiftguard, "author": alessandromanzini
# swiftguard lib specific logic here.
#

# ========================================
# TARGET CONFIGURATION
# ========================================

# target names
set( OBJECT_TARGET ${PROJECT_NAME}_object )
set( STATIC_TARGET ${PROJECT_NAME}_static )
set( SHARED_TARGET ${PROJECT_NAME}_shared )

# source and include directories
set( SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src )
set( INC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include )

# create object lib for single compile static/shared linking
file( GLOB_RECURSE SOURCE_FILES ${SRC_DIR}/*.cpp )
add_library( ${OBJECT_TARGET} OBJECT ${SOURCE_FILES} )

# set object target compile options
include( target_compile_options_strict )
target_compile_options_strict( ${OBJECT_TARGET} )

# set object target directories
target_include_directories( ${OBJECT_TARGET}
                            PUBLIC $<BUILD_INTERFACE:${INC_DIR}> $<INSTALL_INTERFACE:include>
                            PRIVATE ${SRC_DIR} )

# set object target precompile headers
target_precompile_headers( ${OBJECT_TARGET} PRIVATE ${INC_DIR}/${PROJECT_NAME}/pch.hpp )

# add distribution targets
include( add_library_distribution_targets )
add_library_distribution_targets( ${STATIC_TARGET} ${SHARED_TARGET} ${OBJECT_TARGET} ${PROJECT_NAME} )


# ========================================
# UMBRELLA HEADER
# ========================================
include( generate_umbrella_header )
generate_umbrella_header( ${PROJECT_NAME} ${INC_DIR} ${INC_DIR}/${PROJECT_NAME} )


# ========================================
# EXTERNAL DEPENDENCIES
# ========================================

# GLM (math library)
#include( fetch_glm_macro )
#fetch_glm()

# SDL2 (graphics/input)
#include( fetch_sdl2_macro )
#fetch_sdl2()
