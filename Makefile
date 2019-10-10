CC=`root-config --cxx`
LD=`root-config --ld`
CFLAGS=-c -g -fPIC `root-config --cflags`
LDFLAGS=`root-config --glibs` -shared -L$$ROOTSYS/lib -L$$ALICE_ROOT/lib -L$$ALICE_PHYSICS/lib -L$$FASTJET/lib -lTHepMCParser -lHepMC -lEG -lEGPythia6 -llhapdfbase -lpythia6_4_28 -lpythia8210dev -lAliPythia6 -lAliPythia8 -lTEvtGen -lEvtGen -lCore -lGeom -lSTEERBase -lSTEER -lEVGEN -lESD -lAOD -lANALYSIS -lANALYSISalice -lPWGJEEMCALJetTasks -lPWGEMCALbase -lPWGEMCALtasks -lPWGEMCALtrigger -lPWGJETFW -lPWGJEFlavourJetTasks -lPWGTools -lTree -lVMC -lGui -lXMLParser -lMinuit -lMinuit2 -lProof -lPhysics -lOADB -lCDB -lRAWDatabase -lSTEER -lpythia6 -lCORRFW -lTOFbase -lRAWDatabase -lRAWDatarec -lTPCbase -lTPCrec -lITSbase -lITSrec -lTRDbase -lTender -lSTAT -lTRDrec -lHMPIDbase -lPWGPP -lPWGHFbase -lPWGDQdielectron -lPWGHFhfe -lEMCALUtils -lPHOSUtils -lPWGCaloTrackCorrBase -lPWGHFvertexingHF -lEMCALraw -lEMCALbase -lEMCALrec -lTRDbase -lVZERObase -lVZEROrec -lTender -lTenderSupplies -lESDfilter -lPWGGAEMCALTasks -lPWGCFCorrelationsBase -lPWGCFCorrelationsDPhi -lfastjet -lsiscone -lsiscone_spherical -lfastjetplugins -lfastjettools -lfastjetcontribfragile
SOURCES=OnTheFlySimulationGenerator.cxx AliGenEvtGen_dev.cxx AliGenPythia_dev.cxx AliPythiaBase_dev.cxx AliPythia6_dev.cxx AliPythia8_dev.cxx AliGenExtFile_dev.cxx AliGenReaderHepMC_dev.cxx THepMCParser_dev.cxx
OBJECTS=$(SOURCES:.cxx=.o)
LIBRARY=AnalysisCode.so

$(LIBRARY): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) $(OBJECTS:.o=_Dict.o) -o $@

%.o: %.cxx hepmc
	rootcint -f $(@:.o=_Dict.cxx) -c -I`root-config --incdir` -I$$ROOTSYS/include -I$$ALICE_ROOT/include -I$$ALICE_PHYSICS/include -I$$FASTJET/include -I./ $(@:.o=.h)
	$(CC) $(CFLAGS) -I`root-config --incdir` -I./ -I$$ROOTSYS/include -I$$ALICE_ROOT/include -I$$ALICE_PHYSICS/include -I$$FASTJET/include $(@:.o=_Dict.cxx) $(@:.o=.cxx)

hepmc:
	tar -xf HepMC.tar

clean:
	rm -f ./*.pcm ./*.o ./*.so ./*Dict*
