cmake_minimum_required(VERSION 3.16)
project(blobby VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find Qt6 components
find_package(Qt6 REQUIRED COMPONENTS Core Qml Gui Quick ShaderTools)

set(CMAKE_AUTOMOC ON)

# Define the shared library target
add_library(blobby SHARED
    src/plugin.h
    src/plugin.cpp
    src/blobgroup.h
    src/blobgroup.cpp
    src/blobshape.h
    src/blobshape.cpp
    src/blobrect.h
    src/blobrect.cpp
    src/blobinvertedrect.h
    src/blobinvertedrect.cpp
    src/blobmaterial.h
    src/blobmaterial.cpp
)

# Link against Qt6 libraries
target_link_libraries(blobby PRIVATE Qt6::Core Qt6::Qml Qt6::Gui Qt6::Quick)

# Set prefix for the library to ensure it compiles to libblobby.so
set_target_properties(blobby PROPERTIES
    PREFIX "lib"
)

# Compile GLSL shaders to .qsb (Qt Shader Baker)
qt_add_shaders(blobby "blob_shaders"
    BATCHABLE OPTIMIZED NOHLSL NOMSL
    GLSL "300es,330"
    PREFIX "/"
    FILES
        src/shaders/blob.frag
        src/shaders/blob.vert
)

# Post-build hook: Deploy the library and qmldir to a local import folder
add_custom_command(TARGET blobby POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/imports/Blobby
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:blobby> ${CMAKE_BINARY_DIR}/imports/Blobby/
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/src/qmldir ${CMAKE_BINARY_DIR}/imports/Blobby/
    COMMENT "Deploying plugin to build/imports/Blobby"
)
