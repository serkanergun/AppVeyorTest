set(EXAMPLE_HEADERS)
set(EXAMPLE_SOURCES main.cpp)
set(EXAMPLE_LINK_LIBRARIES ${Boost_FILESYSTEM_LIBRARY} ${Boost_SYSTEM_LIBRARY} AssImp)

common_application(example)