#ifndef EXPORT_HPP
#define EXPORT_HPP


#ifdef SWIFTGUARD_SHARED

    #ifdef _MSC_VER
        #ifdef SWIFTGUARD_BUILD_LIB
         #define SWIFTGUARD_API __declspec(dllexport)
        #else
         #define SWIFTGUARD_API __declspec(dllimport)
        #endif
    #else
        #define SWIFTGUARD_API __attribute__((__visibility__("default")))
    #endif

#elifndef SWIFTGUARD_STATIC

    #define SWIFTGUARD_API

#else

static_assert( false, "API definition must be defined!" );

#endif


#endif //!EXPORT_HPP
