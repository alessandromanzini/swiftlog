#ifndef MONGOOSE_CBRIDGE_HPP
#define MONGOOSE_CBRIDGE_HPP

#include <mongoose/pch.hpp>


#if defined(_MSC_VER)
    #define DEBUG_BREAK() __debugbreak()
#elif defined(__clang__) || defined(__GNUC__)
    #define DEBUG_BREAK() __builtin_debugtrap()
#else
    #include <csignal>
    #define DEBUG_BREAK() std::raise(SIGTRAP)
#endif


namespace mongoose::cbridge
{
}


#endif //!MONGOOSE_CBRIDGE_HPP
