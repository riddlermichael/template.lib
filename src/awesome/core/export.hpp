#pragma once

#include <awesome/core/compiler.hpp>

// Generic helper definitions for shared library support
#if defined(AW_COMPILER_MSVC)
	#define AW_DECL_IMPORT __declspec(dllimport)
	#define AW_DECL_EXPORT __declspec(dllexport)
	#define AW_DECL_HIDDEN
#elif defined(AW_COMPILER_GCC_LIKE)
	#define AW_DECL_IMPORT __attribute__((visibility("default")))
	#define AW_DECL_EXPORT __attribute__((visibility("default")))
	#define AW_DECL_HIDDEN __attribute__((visibility("hidden")))
#else
	#define AW_DECL_IMPORT
	#define AW_DECL_EXPORT
	#define AW_DECL_HIDDEN
#endif

// Now we use the generic helper definitions above to define AW_EXPORT and AW_HIDDEN.
// AW_EXPORT is used for the public API symbols;
// it either DLL imports or DLL exports (or does nothing for static build).
// AW_HIDDEN is used for non-api symbols.
#ifdef AW_STATIC
	#define AW_EXPORT
	#define AW_HIDDEN
#else
	#ifndef AW_EXPORT
		#ifdef AW_EXPORTS
			#define AW_EXPORT AW_DECL_EXPORT
		#else
			#define AW_EXPORT AW_DECL_IMPORT
		#endif
	#endif
	#define AW_HIDDEN AW_DECL_HIDDEN
#endif
