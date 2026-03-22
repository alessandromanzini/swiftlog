function( generate_umbrella_header UMBRELLA_HEADER_NAME INCLUDE_DIRECTORY OUTPUT_DIRECTORY )

    # ========================================
    # ARGUMENT VALIDATION
    # ========================================

    get_filename_component( EXTENSION ${UMBRELLA_HEADER_NAME} EXT )
    if( NOT ${EXTENSION} STREQUAL "" )
        message( FATAL_ERROR "UMBRELLA_HEADER_NAME must not contain an extension (${UMBRELLA_HEADER_NAME})!" )
    endif()

    if( NOT IS_ABSOLUTE ${INCLUDE_DIRECTORY} )
        message( FATAL_ERROR "INCLUDE_DIRECTORY must be an absolute path (${INCLUDE_DIRECTORY})!" )
    endif()


    # ========================================
    # HEADER GENERATION
    # ========================================

    string( TOUPPER ${UMBRELLA_HEADER_NAME} HEADER_GUARD )
    string( APPEND HEADER_GUARD _HPP )
    set( UMBRELLA_HEADER_FILE ${UMBRELLA_HEADER_NAME}.hpp )

    # make include guard begin and comment for clarity
    set( CONTENT "// UMBRELLA HEADER: auto-generated in cmake from globbed headers..." )
    list( APPEND CONTENT "\n" )
    list( APPEND CONTENT "\n#ifndef ${HEADER_GUARD}" )
    list( APPEND CONTENT "\n#define ${HEADER_GUARD}" )
    list( APPEND CONTENT "\n\n" )

    # glob all header files and append them to content
    file( GLOB_RECURSE INCLUDE_FILE_PATHS ${INCLUDE_DIRECTORY}/*.hpp )
    list( FILTER INCLUDE_FILE_PATHS EXCLUDE REGEX ".*${UMBRELLA_HEADER_FILE}$" )

    foreach( INCLUDE_FILE_PATH ${INCLUDE_FILE_PATHS} )
        file( RELATIVE_PATH PATH ${INCLUDE_DIRECTORY} ${INCLUDE_FILE_PATH} )
        list( APPEND CONTENT "\n#include \"${PATH}\"" )
    endforeach()

    # finalize include guard
    list( APPEND CONTENT "\n\n" )
    list( APPEND CONTENT "\n#endif //!${HEADER_GUARD}" )

    cmake_path( APPEND OUTPUT_DIRECTORY ${UMBRELLA_HEADER_FILE} OUTPUT_VARIABLE OUTPUT_FILE_PATH )
    file( WRITE ${OUTPUT_FILE_PATH} ${CONTENT} )

endfunction()