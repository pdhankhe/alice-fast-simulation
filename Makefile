# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

# Default target executed when no arguments are given to make.
default_target: all
.PHONY : default_target

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /usr/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /afs/cern.ch/user/p/pdhankhe/POWHEG_Simulation/alice-fast-simulation_radial/alice-fast-simulation

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /afs/cern.ch/user/p/pdhankhe/POWHEG_Simulation/alice-fast-simulation_radial/alice-fast-simulation

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake cache editor..."
	/usr/bin/ccmake -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache
.PHONY : edit_cache/fast

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	/usr/bin/cmake -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache
.PHONY : rebuild_cache/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start /afs/cern.ch/user/p/pdhankhe/POWHEG_Simulation/alice-fast-simulation_radial/alice-fast-simulation/CMakeFiles /afs/cern.ch/user/p/pdhankhe/POWHEG_Simulation/alice-fast-simulation_radial/alice-fast-simulation/CMakeFiles/progress.marks
	$(MAKE) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start /afs/cern.ch/user/p/pdhankhe/POWHEG_Simulation/alice-fast-simulation_radial/alice-fast-simulation/CMakeFiles 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean
.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named AnalysisCode

# Build rule for target.
AnalysisCode: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 AnalysisCode
.PHONY : AnalysisCode

# fast build rule for target.
AnalysisCode/fast:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/build
.PHONY : AnalysisCode/fast

AliAnalysisTaskHFJets.o: AliAnalysisTaskHFJets.cxx.o
.PHONY : AliAnalysisTaskHFJets.o

# target to build an object file
AliAnalysisTaskHFJets.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliAnalysisTaskHFJets.cxx.o
.PHONY : AliAnalysisTaskHFJets.cxx.o

AliAnalysisTaskHFJets.i: AliAnalysisTaskHFJets.cxx.i
.PHONY : AliAnalysisTaskHFJets.i

# target to preprocess a source file
AliAnalysisTaskHFJets.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliAnalysisTaskHFJets.cxx.i
.PHONY : AliAnalysisTaskHFJets.cxx.i

AliAnalysisTaskHFJets.s: AliAnalysisTaskHFJets.cxx.s
.PHONY : AliAnalysisTaskHFJets.s

# target to generate assembly for a file
AliAnalysisTaskHFJets.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliAnalysisTaskHFJets.cxx.s
.PHONY : AliAnalysisTaskHFJets.cxx.s

AliGenEvtGen_dev.o: AliGenEvtGen_dev.cxx.o
.PHONY : AliGenEvtGen_dev.o

# target to build an object file
AliGenEvtGen_dev.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenEvtGen_dev.cxx.o
.PHONY : AliGenEvtGen_dev.cxx.o

AliGenEvtGen_dev.i: AliGenEvtGen_dev.cxx.i
.PHONY : AliGenEvtGen_dev.i

# target to preprocess a source file
AliGenEvtGen_dev.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenEvtGen_dev.cxx.i
.PHONY : AliGenEvtGen_dev.cxx.i

AliGenEvtGen_dev.s: AliGenEvtGen_dev.cxx.s
.PHONY : AliGenEvtGen_dev.s

# target to generate assembly for a file
AliGenEvtGen_dev.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenEvtGen_dev.cxx.s
.PHONY : AliGenEvtGen_dev.cxx.s

AliGenExtFile_dev.o: AliGenExtFile_dev.cxx.o
.PHONY : AliGenExtFile_dev.o

# target to build an object file
AliGenExtFile_dev.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenExtFile_dev.cxx.o
.PHONY : AliGenExtFile_dev.cxx.o

AliGenExtFile_dev.i: AliGenExtFile_dev.cxx.i
.PHONY : AliGenExtFile_dev.i

# target to preprocess a source file
AliGenExtFile_dev.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenExtFile_dev.cxx.i
.PHONY : AliGenExtFile_dev.cxx.i

AliGenExtFile_dev.s: AliGenExtFile_dev.cxx.s
.PHONY : AliGenExtFile_dev.s

# target to generate assembly for a file
AliGenExtFile_dev.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenExtFile_dev.cxx.s
.PHONY : AliGenExtFile_dev.cxx.s

AliGenPythia_dev.o: AliGenPythia_dev.cxx.o
.PHONY : AliGenPythia_dev.o

# target to build an object file
AliGenPythia_dev.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenPythia_dev.cxx.o
.PHONY : AliGenPythia_dev.cxx.o

AliGenPythia_dev.i: AliGenPythia_dev.cxx.i
.PHONY : AliGenPythia_dev.i

# target to preprocess a source file
AliGenPythia_dev.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenPythia_dev.cxx.i
.PHONY : AliGenPythia_dev.cxx.i

AliGenPythia_dev.s: AliGenPythia_dev.cxx.s
.PHONY : AliGenPythia_dev.s

# target to generate assembly for a file
AliGenPythia_dev.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenPythia_dev.cxx.s
.PHONY : AliGenPythia_dev.cxx.s

AliGenReaderHepMC_dev.o: AliGenReaderHepMC_dev.cxx.o
.PHONY : AliGenReaderHepMC_dev.o

# target to build an object file
AliGenReaderHepMC_dev.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenReaderHepMC_dev.cxx.o
.PHONY : AliGenReaderHepMC_dev.cxx.o

AliGenReaderHepMC_dev.i: AliGenReaderHepMC_dev.cxx.i
.PHONY : AliGenReaderHepMC_dev.i

# target to preprocess a source file
AliGenReaderHepMC_dev.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenReaderHepMC_dev.cxx.i
.PHONY : AliGenReaderHepMC_dev.cxx.i

AliGenReaderHepMC_dev.s: AliGenReaderHepMC_dev.cxx.s
.PHONY : AliGenReaderHepMC_dev.s

# target to generate assembly for a file
AliGenReaderHepMC_dev.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliGenReaderHepMC_dev.cxx.s
.PHONY : AliGenReaderHepMC_dev.cxx.s

AliPythia6_dev.o: AliPythia6_dev.cxx.o
.PHONY : AliPythia6_dev.o

# target to build an object file
AliPythia6_dev.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliPythia6_dev.cxx.o
.PHONY : AliPythia6_dev.cxx.o

AliPythia6_dev.i: AliPythia6_dev.cxx.i
.PHONY : AliPythia6_dev.i

# target to preprocess a source file
AliPythia6_dev.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliPythia6_dev.cxx.i
.PHONY : AliPythia6_dev.cxx.i

AliPythia6_dev.s: AliPythia6_dev.cxx.s
.PHONY : AliPythia6_dev.s

# target to generate assembly for a file
AliPythia6_dev.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliPythia6_dev.cxx.s
.PHONY : AliPythia6_dev.cxx.s

AliPythia8_dev.o: AliPythia8_dev.cxx.o
.PHONY : AliPythia8_dev.o

# target to build an object file
AliPythia8_dev.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliPythia8_dev.cxx.o
.PHONY : AliPythia8_dev.cxx.o

AliPythia8_dev.i: AliPythia8_dev.cxx.i
.PHONY : AliPythia8_dev.i

# target to preprocess a source file
AliPythia8_dev.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliPythia8_dev.cxx.i
.PHONY : AliPythia8_dev.cxx.i

AliPythia8_dev.s: AliPythia8_dev.cxx.s
.PHONY : AliPythia8_dev.s

# target to generate assembly for a file
AliPythia8_dev.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliPythia8_dev.cxx.s
.PHONY : AliPythia8_dev.cxx.s

AliPythiaBase_dev.o: AliPythiaBase_dev.cxx.o
.PHONY : AliPythiaBase_dev.o

# target to build an object file
AliPythiaBase_dev.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliPythiaBase_dev.cxx.o
.PHONY : AliPythiaBase_dev.cxx.o

AliPythiaBase_dev.i: AliPythiaBase_dev.cxx.i
.PHONY : AliPythiaBase_dev.i

# target to preprocess a source file
AliPythiaBase_dev.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliPythiaBase_dev.cxx.i
.PHONY : AliPythiaBase_dev.cxx.i

AliPythiaBase_dev.s: AliPythiaBase_dev.cxx.s
.PHONY : AliPythiaBase_dev.s

# target to generate assembly for a file
AliPythiaBase_dev.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/AliPythiaBase_dev.cxx.s
.PHONY : AliPythiaBase_dev.cxx.s

G__AnalysisCode.o: G__AnalysisCode.cxx.o
.PHONY : G__AnalysisCode.o

# target to build an object file
G__AnalysisCode.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/G__AnalysisCode.cxx.o
.PHONY : G__AnalysisCode.cxx.o

G__AnalysisCode.i: G__AnalysisCode.cxx.i
.PHONY : G__AnalysisCode.i

# target to preprocess a source file
G__AnalysisCode.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/G__AnalysisCode.cxx.i
.PHONY : G__AnalysisCode.cxx.i

G__AnalysisCode.s: G__AnalysisCode.cxx.s
.PHONY : G__AnalysisCode.s

# target to generate assembly for a file
G__AnalysisCode.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/G__AnalysisCode.cxx.s
.PHONY : G__AnalysisCode.cxx.s

OnTheFlySimulationGenerator.o: OnTheFlySimulationGenerator.cxx.o
.PHONY : OnTheFlySimulationGenerator.o

# target to build an object file
OnTheFlySimulationGenerator.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/OnTheFlySimulationGenerator.cxx.o
.PHONY : OnTheFlySimulationGenerator.cxx.o

OnTheFlySimulationGenerator.i: OnTheFlySimulationGenerator.cxx.i
.PHONY : OnTheFlySimulationGenerator.i

# target to preprocess a source file
OnTheFlySimulationGenerator.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/OnTheFlySimulationGenerator.cxx.i
.PHONY : OnTheFlySimulationGenerator.cxx.i

OnTheFlySimulationGenerator.s: OnTheFlySimulationGenerator.cxx.s
.PHONY : OnTheFlySimulationGenerator.s

# target to generate assembly for a file
OnTheFlySimulationGenerator.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/OnTheFlySimulationGenerator.cxx.s
.PHONY : OnTheFlySimulationGenerator.cxx.s

THepMCParser_dev.o: THepMCParser_dev.cxx.o
.PHONY : THepMCParser_dev.o

# target to build an object file
THepMCParser_dev.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/THepMCParser_dev.cxx.o
.PHONY : THepMCParser_dev.cxx.o

THepMCParser_dev.i: THepMCParser_dev.cxx.i
.PHONY : THepMCParser_dev.i

# target to preprocess a source file
THepMCParser_dev.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/THepMCParser_dev.cxx.i
.PHONY : THepMCParser_dev.cxx.i

THepMCParser_dev.s: THepMCParser_dev.cxx.s
.PHONY : THepMCParser_dev.s

# target to generate assembly for a file
THepMCParser_dev.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/THepMCParser_dev.cxx.s
.PHONY : THepMCParser_dev.cxx.s

ecorrel.o: ecorrel.cxx.o
.PHONY : ecorrel.o

# target to build an object file
ecorrel.cxx.o:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/ecorrel.cxx.o
.PHONY : ecorrel.cxx.o

ecorrel.i: ecorrel.cxx.i
.PHONY : ecorrel.i

# target to preprocess a source file
ecorrel.cxx.i:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/ecorrel.cxx.i
.PHONY : ecorrel.cxx.i

ecorrel.s: ecorrel.cxx.s
.PHONY : ecorrel.s

# target to generate assembly for a file
ecorrel.cxx.s:
	$(MAKE) -f CMakeFiles/AnalysisCode.dir/build.make CMakeFiles/AnalysisCode.dir/ecorrel.cxx.s
.PHONY : ecorrel.cxx.s

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... AnalysisCode"
	@echo "... edit_cache"
	@echo "... rebuild_cache"
	@echo "... AliAnalysisTaskHFJets.o"
	@echo "... AliAnalysisTaskHFJets.i"
	@echo "... AliAnalysisTaskHFJets.s"
	@echo "... AliGenEvtGen_dev.o"
	@echo "... AliGenEvtGen_dev.i"
	@echo "... AliGenEvtGen_dev.s"
	@echo "... AliGenExtFile_dev.o"
	@echo "... AliGenExtFile_dev.i"
	@echo "... AliGenExtFile_dev.s"
	@echo "... AliGenPythia_dev.o"
	@echo "... AliGenPythia_dev.i"
	@echo "... AliGenPythia_dev.s"
	@echo "... AliGenReaderHepMC_dev.o"
	@echo "... AliGenReaderHepMC_dev.i"
	@echo "... AliGenReaderHepMC_dev.s"
	@echo "... AliPythia6_dev.o"
	@echo "... AliPythia6_dev.i"
	@echo "... AliPythia6_dev.s"
	@echo "... AliPythia8_dev.o"
	@echo "... AliPythia8_dev.i"
	@echo "... AliPythia8_dev.s"
	@echo "... AliPythiaBase_dev.o"
	@echo "... AliPythiaBase_dev.i"
	@echo "... AliPythiaBase_dev.s"
	@echo "... G__AnalysisCode.o"
	@echo "... G__AnalysisCode.i"
	@echo "... G__AnalysisCode.s"
	@echo "... OnTheFlySimulationGenerator.o"
	@echo "... OnTheFlySimulationGenerator.i"
	@echo "... OnTheFlySimulationGenerator.s"
	@echo "... THepMCParser_dev.o"
	@echo "... THepMCParser_dev.i"
	@echo "... THepMCParser_dev.s"
	@echo "... ecorrel.o"
	@echo "... ecorrel.i"
	@echo "... ecorrel.s"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system

