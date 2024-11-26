#include "Awesome.hpp"

#include <iostream>

#include <awesome/version.hpp>

using namespace awesome;

void Awesome::hello() {
	std::cout << "Awesome library" << std::endl;
	std::cout << "Version " << AW_VERSION_STR << ", ";
	char const* buildType =
#ifdef AW_STATIC
	    "static"
#else
	    "dynamic"
#endif
	    ;
	std::cout << buildType << " build" << std::endl;
}
