cmake_minimum_required(VERSION 3.16)

# Change the same of the project
project(MyCppProject VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Defines out dir depending on the selected compilation
get_filename_component(COMPILER_NAME ${CMAKE_CXX_COMPILER} NAME)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/delivery/${CMAKE_BUILD_TYPE}/${COMPILER_NAME}/${CMAKE_SYSTEM_PROCESSOR})

message(STATUS "COMILER_NAME: ${COMPILER_NAME}")
message(STATUS "CMAKE_SYSTEM_PROCESSOR: ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "CMAKE_RUNTIME_OUTPUT_DIRECTORY: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")

#-------------------------
#---    DEPENDENCIES   ---
#-------------------------

include(FetchContent)

message(STATUS "Fetching catchorg/Catch2 from github...")
FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG v3.8.1
)

FetchContent_MakeAvailable(Catch2)

message(STATUS "Fetching gabime/spdlog from github...")
FetchContent_Declare(
  spdlog
  GIT_REPOSITORY https://github.com/gabime/spdlog.git
  GIT_TAG v1.15.3
)

FetchContent_MakeAvailable(spdlog)

#-------------------------
#---      YOUR_APP     ---
#-------------------------

add_executable(${PROJECT_NAME} 
    src/testclass.cpp    
    src/main.cpp
)

set(
    -Wall                   # Tous les warnings classiques
    -Wextra                 # Encore plus de warnings
    -Wpedantic              # Respect strict du standard C++
    -Werror                 # Tous les warnings = erreurs
    -Wshadow                # Avertit sur les redéfinitions de variables
    -Wconversion            # Conversion implicite potentiellement dangereuse
    -Wsign-conversion       # Conversions implicites entre signés/non-signés
    -Wcast-align            # Alignement mémoire suspect
    -Wnull-dereference      # Déréférencement possible de nullptr
    -Wdouble-promotion      # float → double implicite
    -Wformat=2              # Vérifie les formats printf/scanf
    -Wmissing-declarations  # Déclarations manquantes (utile en C)
    -Wnon-virtual-dtor      # Classes avec héritage sans destructeur virtuel
    -Woverloaded-virtual    # Masquage de méthode virtuelle
    -Wold-style-cast        # Cast en C style (dangereux)
    -Wunused-parameter      # Paramètre non utilisé dans une fonction
    -fstrict-aliasing       # Active l'aliasing strict
    -fno-common             # Empêche les symboles dupliqués (ancienne norme C)
)

if (CMAKE_CXX_COMPILER_ID MATCHES "GNU") #GCC
    list(APPEND STRICT_WARNINGS
        -Wlogical-op            # Erreurs logiques (ex : `if (a & b)` au lieu de `if (a && b)`)
        -Wduplicated-branches   # Branches dupliquées dans if/else
        -Wduplicated-cond       # Conditions dupliquées
        -Wuseless-cast          # Casts inutiles
    )
endif()

target_compile_options(${PROJECT_NAME} PRIVATE
    ${STRICT_WARNINGS}
)

target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/include)

target_link_libraries(${PROJECT_NAME} PRIVATE spdlog::spdlog)

#-------------------------
#---     TestFiles     ---
#-------------------------
enable_testing()

function(add_test_target target_name)
    # Le reste des arguments sont les fichiers sources
    set(options "")
    set(oneValueArgs "")
    set(multiValueArgs SOURCES)
    cmake_parse_arguments(TEST "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    add_executable(${target_name} ${TEST_SOURCES})

    target_link_libraries(${target_name}
        PRIVATE
        Catch2::Catch2WithMain
    )

    target_include_directories(${target_name}
        PRIVATE
        ${CMAKE_SOURCE_DIR}/include
    )

    target_compile_options(${target_name} PRIVATE ${STRICT_WARNINGS})
endfunction()

add_test_target(catch2_test
    SOURCES
        testfiles/unit_tests/src/test_catch2.cpp
)