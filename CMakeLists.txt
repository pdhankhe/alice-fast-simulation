set(MODULE_NAME "AnalysisCode")

# Minimum version of CMake
#CMAKE_MINIMUM_REQUIRED(VERSION 3.11.0 FATAL_ERROR)

project(${MODULE_NAME})

#SET(CMAKE_CXX_STANDARD 11)
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

# Install directories
#SET(INSTALL_BIN_DIR ${CMAKE_INSTALL_PREFIX}/bin)
#SET(INSTALL_MACRO_DIR ${CMAKE_INSTALL_PREFIX}/macro)
SET(INSTALL_INC_DIR ${CMAKE_INSTALL_PREFIX}/include)
SET(INSTALL_LIB_DIR ${CMAKE_INSTALL_PREFIX}/lib)

# Source directories
SET(IMP_SRC_DIR ${CMAKE_SOURCE_DIR})
SET(INC_SRC_DIR ${CMAKE_SOURCE_DIR})

# Library name
SET(LIBRARY_NAME ${MODULE_NAME})

# Required source files to build the library.
set(SRCS
    ${IMP_SRC_DIR}/AliAnalysisTaskHFJets.cxx
    ${IMP_SRC_DIR}/AliGenEvtGen_dev.cxx
    ${IMP_SRC_DIR}/AliGenExtFile_dev.cxx
    ${IMP_SRC_DIR}/AliGenPythia_dev.cxx
    ${IMP_SRC_DIR}/AliGenReaderHepMC_dev.cxx
    ${IMP_SRC_DIR}/AliPythia6_dev.cxx
    ${IMP_SRC_DIR}/AliPythia8_dev.cxx
    ${IMP_SRC_DIR}/AliPythiaBase_dev.cxx
    ${IMP_SRC_DIR}/OnTheFlySimulationGenerator.cxx
    ${IMP_SRC_DIR}/THepMCParser_dev.cxx
   )

# Requried headers to build the library.
set(HEADERS
    ${INC_SRC_DIR}/AliAnalysisTaskHFJets.h
    ${INC_SRC_DIR}/AliGenEvtGen_dev.h
    ${INC_SRC_DIR}/AliGenExtFile_dev.h
    ${INC_SRC_DIR}/AliGenPythia_dev.h
    ${INC_SRC_DIR}/AliGenReaderHepMC_dev.h
    ${INC_SRC_DIR}/AliPythia6_dev.h
    ${INC_SRC_DIR}/AliPythia8_dev.h
    ${INC_SRC_DIR}/AliPythiaBase_dev.h
    ${INC_SRC_DIR}/OnTheFlySimulationGenerator.h
    ${INC_SRC_DIR}/THepMCParser_dev.h
  )
# include dirs
#include_directories(include/)
include_directories(${INC_SRC_DIR})
include_directories($ENV{ALICE_ROOT}/include)
include_directories($ENV{ALICE_PHYSICS}/include)
include_directories($ENV{FASTJET}/include)

########
# ROOT #
########
# Find ROOT and get useful functions from ROOT_USE_FILE,
# e.g. ROOT_GENERATE_DICTIONARY
list(APPEND CMAKE_PREFIX_PATH $ENV{ROOTSYS})
find_package(ROOT REQUIRED)
include(${ROOT_USE_FILE})
# Find ROOT headers
include_directories(${ROOT_INCLUDE_DIRS})

# Generate ROOT dictionary
SET(ROOT_DICT_LINKDEF_FILE "${IMP_SRC_DIR}/${MODULE_NAME}LinkDef.h")
SET(ROOT_DICT_NAME "G__${MODULE_NAME}")

ROOT_GENERATE_DICTIONARY(${ROOT_DICT_NAME} ${HEADERS} LINKDEF ${ROOT_DICT_LINKDEF_FILE})
# Files produced by the dictionary generation
SET(ROOT_DICT_LIB_FILES
    "${PROJECT_BINARY_DIR}/lib${MODULE_NAME}_rdict.pcm"
    "${PROJECT_BINARY_DIR}/lib${MODULE_NAME}.rootmap"
)

# Build a library from the sources specified above together with generated ROOT
# dictionary
add_library(${MODULE_NAME} SHARED ${SRCS} "${ROOT_DICT_NAME}.cxx")

# Link together with ROOT libs
target_link_libraries(${MODULE_NAME} ${ROOT_LIBRARIES} -L$ENV{ALICE_ROOT}/lib -L$ENV{ALICE_PHYSICS}/lib -L$ENV{FASTJET}/lib THepMCParser HepMC EG EGPythia6 lhapdfbase pythia6_4_28 pythia8210dev AliPythia6 AliPythia8 TEvtGen EvtGen Core Geom STEERBase STEER EVGEN ESD AOD ANALYSIS ANALYSISalice PWGJEEMCALJetTasks PWGEMCALbase PWGEMCALtasks PWGEMCALtrigger PWGJETFW PWGJEFlavourJetTasks PWGTools Tree VMC Gui XMLParser Minuit Minuit2 Proof Physics OADB CDB RAWDatabase STEER pythia6 CORRFW TOFbase RAWDatabase RAWDatarec TPCbase TPCrec ITSbase ITSrec TRDbase Tender STAT TRDrec HMPIDbase PWGPP PWGHFbase PWGDQdielectron PWGHFhfe EMCALUtils PHOSUtils PWGCaloTrackCorrBase PWGHFvertexingHF EMCALraw EMCALbase EMCALrec TRDbase VZERObase VZEROrec Tender TenderSupplies ESDfilter PWGGAEMCALTasks PWGCFCorrelationsBase PWGCFCorrelationsDPhi fastjet siscone siscone_spherical fastjetplugins fastjettools fastjetcontribfragile)

