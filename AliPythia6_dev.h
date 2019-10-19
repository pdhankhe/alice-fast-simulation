#ifndef ALIPYTHIA6_DEV_H
#define ALIPYTHIA6_DEV_H
/* Copyright(c) 1998-1999, ALICE Experiment at CERN, All rights reserved. *
 * See cxx source for full Copyright notice                               */

#include <TPythia6.h>
#include "AliPythiaBase_dev.h"
#include "PythiaProcess_dev.h"

class AliStack;

class AliPythia6_dev : public TPythia6, public AliPythiaBase_dev
{

public:
  AliPythia6_dev();
  virtual ~AliPythia6_dev() {;}

  // Implementation of AliPythiaBase_dev intrface
  virtual Int_t Version() {return (6);}

  // convert to compressed code and print result (for debugging only)
  virtual Int_t CheckedLuComp(Int_t kf);

  // Pythia initialisation for selected processes
  virtual void ProcInit(ProcessMy_t process, Float_t energy, Int_t strucfunc, Int_t tune);

  virtual void  GenerateEvent();
  virtual Int_t GetNumberOfParticles() { return GetN(); }
  virtual void  SetNumberOfParticles(Int_t i) { SetN(i); }
  virtual void  EditEventList(Int_t i) {Pyedit(i);}
  virtual void  PrintStatistics();
  virtual void  EventListing();
  virtual Int_t GetParticles(TClonesArray *particles);
  virtual void  SetDecayOff(const std::set<int>& pdg_codes);

  // Treat protons as inside nuclei
  virtual void  SetNuclei(Int_t a1, Int_t a2, Int_t pdf);

  virtual void SetLHEFile(const char* fname) { fLHEFile = fname; }

  // Print particle properties
  virtual void PrintParticles();

  void Pytune(int itune);

  // Common Physics Configuration
  virtual void SetWeightPower(Double_t pow); // use pT,hard dependent weight instead of p_T,hard bins
  virtual void SetPtHardRange(Float_t ptmin, Float_t ptmax);
  virtual void SetYHardRange(Float_t ymin, Float_t ymax);
  virtual void SetInitialAndFinalStateRadiation(Int_t flag1, Int_t flag2);

  virtual void UseNewMultipleInteractionsScenario(Bool_t b)   { fNewMIS = b; }

  // Common Getters
  virtual Float_t GetXSection();
  virtual Int_t   ProcessCode();
  virtual Float_t GetPtHard();
  virtual Float_t GetEventWeight();
  virtual Int_t   GetNMPI();
  virtual Bool_t  EndOfLHEFileReached() { return fEndOfLHEFile; }

  virtual void Pyevnw();
  virtual void Pyshow(Int_t ip1, Int_t ip2, Double_t qmax);

protected:
  ProcessMy_t             fProcess;            ///< Process type
  Int_t                 fItune;              ///< Tune
  Float_t               fEcms;               ///< Centre of mass energy
  Int_t                 fStrucFunc;          ///< Structure function
  TString               fLHEFile;            ///< LHE file name
  Bool_t                fNewMIS;             ///< Use new MIS
  Bool_t                fEndOfLHEFile;       //!<!End of LHE was reached

private:
  AliPythia6_dev(const AliPythia6_dev& pythia); // not implemented
  AliPythia6_dev & operator=(const AliPythia6_dev & rhs); // not implemented

  ClassDef(AliPythia6_dev, 1) //ALICE UI to PYTHIA
};

#endif





