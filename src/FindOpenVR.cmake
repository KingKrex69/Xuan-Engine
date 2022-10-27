
set(OPENVR_ROOT_DIR
	"${OPENVR_ROOT_DIR}"
	CACHE
	PATH
	"Directory to search for OpenVR SDK")

set(OPENVR_HEADERS_ROOT_DIR
	"${OPENVR_HEADERS_ROOT_DIR}"
	CACHE
	PATH
	"Directory to search for private OpenVR headers")

set(_root_dirs)
if(OPENVR_ROOT_DIR)
	set(_root_dirs "${OPENVR_ROOT_DIR}" "${OPENVR_HEADERS_ROOT_DIR}" "${OPENVR_ROOT_DIR}/public")
endif()

# todo fails for universal builds
set(_dll_suffix)
if(${CMAKE_SIZEOF_VOID_P} EQUAL 8)
	set(_bitness 64)
	if(WIN32)
		set(_dll_suffix _x64)
	endif()
else()
	set(_bitness 32)
endif()

# Test platform

set(_platform)
if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
	set(_platform_base osx)
	# SteamVR only supports 32-bit on OS X
	set(OPENVR_PLATFORM osx32)
else()
	if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
		set(_platform_base linux)
		# TODO Massive hack!
		add_definitions(-DGNUC -DPOSIX -DCOMPILER_GCC -D_LINUX -DLINUX -DPOSIX -D_POSIX)
	elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
		set(_platform_base win)
	endif()
	set(OPENVR_PLATFORM ${_platform_base}${_bitness})
	set(_libpath lib/${OPENVR_PLATFORM})
endif()

find_path(OPENVR_INCLUDE_DIR
	NAMES
	openvr_driver.h
	HINTS
	"${_libdir}"
	"${_libdir}/.."
	"${_libdir}/../.."
	PATHS
	${_root_dirs}
	PATH_SUFFIXES
	headers
	public/headers
	steam
	public/steam)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenVR
	DEFAULT_MSG
	OPENVR_INCLUDE_DIR)

if(OPENVR_FOUND)
	list(APPEND OPENVR_INCLUDE_DIRS ${OPENVR_INCLUDE_DIR})
	mark_as_advanced(OPENVR_ROOT_DIR)
endif()

mark_as_advanced(OPENVR_INCLUDE_DIR)