set(EXAMPLE_HEADERS)
set(EXAMPLE_SOURCES main.cpp)
set(EXAMPLE_LINK_LIBRARIES ${Boost_FILESYSTEM_LIBRARY})

common_application(example)