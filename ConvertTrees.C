#include "TROOT.h"
#include "TSystem.h"
#include "TFile.h"
#include "TProfile.h"
#include "TString.h"
#include "TTree.h"
#include "TList.h"
#include "TMath.h"
#include "TH1F.h"
#include "TH2F.h"
#include "TH3F.h"
#include <vector>

class AliAnalysisTaskHFJets;

void ConvertTrees(TString sPathFileInput)
{
  printf("Loading the library.\n");
  gSystem->Load("libAnalysisCode.so");

  TString sPathFileOutput = sPathFileInput;
  sPathFileOutput.ReplaceAll("AnalysisResults_FastSim", "trees");

  TString sLabelsHadron[] = {"D0", "Lc"};
  const Int_t iNHadrons = sizeof(sLabelsHadron) / sizeof(sLabelsHadron[0]);

  TFile* fileIn = 0;
  TFile* fileOut = 0;

  TTree** treeIn = new TTree*[iNHadrons];
  TTree** treeOut = new TTree*[iNHadrons];

  TList* listIn = 0;
  TList* listOut = 0;

  TProfile* prXSection = 0;
  /*
  Double_t dPtHadron = 0;
  Double_t dEtaHadron = 0;
  Double_t dPhiHadron = 0;
  Double_t dYHadron = 0;
  Int_t    iPDGParton = 0;
  Double_t dPtJet = 0;
  Double_t dEtaJet = 0;
  Double_t dPhiJet = 0;
  Double_t dR = 0;
  Double_t dZJet = 0;
  Int_t    iNConst = 0;
  Double_t dZgJet = 0;
  Double_t dRgJet = 0;
  Int_t    iNSD = 0;
  Double_t dPtMother = 0;
  Double_t dK0 = 0;
  Double_t dK1 = 0;
  Double_t dK2 = 0;
  Double_t dKT = 0;
  */
  /// Transverse momentum of the D meson in GeV/c, precision 0.05
  Double32_t   dPtHadron     ; //[0,204.8,12]
  /// Eta of the D meson, precision 0.004
  Double32_t   dEtaHadron    ; //[-2.048,2.048,10]
  /// Phi of the D meson, precision 0.006
  Double32_t   dPhiHadron    ; //[0,2*pi,10]
  /// Y of the D meson, precision 0.004
  Double32_t   dYHadron      ; //[-2.048,2.048,10]
  /// Parton type, precision 1
  Double32_t   iPDGParton  ; //[0, 16, 4]
  /// Transverse momentum of the jet in GeV/c, precision 0.05
  Double32_t  dPtJet        ; //[0,409.6,13]
  /// Eta of the jet, precision 0.004
  Double32_t  dEtaJet       ; //[-2.048,2.048,10]
  /// Phi of the jet, precision 0.006
  Double32_t  dPhiJet       ; //[0,2*pi,10]
  /// Distance between D meson and jet axis, precision 0.02
  Double32_t  dR         ; //[0,2.56,7]
  /// Z of the D meson, precision 0.001
  Double32_t  dZJet         ; //[0,1.024,10]
  /// Number of jet constituents, precision 1
  Double32_t  iNConst         ; //[0, 64, 6]
  /// z_g, precision 0.001
  Double32_t  dZgJet        ; //[0,1.024,10]
  /// R_g, precision 0.001
  Double32_t  dRgJet        ; //[0,1.024,10]
  /// n_SD, precision 1
  Double32_t  iNSD       ; //[-1, 63, 6]
  /// pT of the SD mother subjet, precision 0.05
  Double32_t  dPtMother  ; //[-1,408.6,13]
  /// k_0, precision 0.001
  Double32_t  dK0        ; //[-0.004,1.020,10]
  /// k_1, precision 0.001
  Double32_t  dK1        ; //[-0.004,1.020,10]
  /// k_2, precision 0.001
  Double32_t  dK2        ; //[-0.004,1.020,10]
  /// k_T, precision 0.05
  Double32_t  dKT        ; //[-1,101.4,11]

  fileIn = new TFile(sPathFileInput.Data());
  if(fileIn->IsZombie())
  {
    printf("Could not open the input file %s\n", sPathFileInput.Data());
    return;
  }
  listIn = (TList*) fileIn->Get(Form("AliAnalysisTaskHFJets_histos"));
  if(!listIn)
  {
    printf("Could not get the list\n.");
    return;
  }
  prXSection = (TProfile*) listIn->FindObject("fHistXsection");
  if(!prXSection)
  {
    printf("Could not get fHistXsection\n.");
    return;
  }

  fileOut = new TFile(sPathFileOutput.Data(), "recreate");
  if(fileOut->IsZombie())
  {
    printf("Failed to create the output file %s.\n", sPathFileOutput.Data());
    return;
  }

  listOut = new TList();
  listOut->Add(prXSection);

  for(Int_t iH = 0; iH < iNHadrons; iH++)
  {
    printf("Converting the %s tree.\n", sLabelsHadron[iH].Data());
    treeIn[iH] = (TTree*)fileIn->Get(Form("AliAnalysisTaskHFJets_%s_MCTruth", sLabelsHadron[iH].Data()));
    if(!treeIn[iH])
    {
      printf("Could not get %s tree\n.", sLabelsHadron[iH].Data());
      return;
    }

    printf("Setting branches.\n");

    AliAnalysisTaskHFJets::AliDmesonMCInfoSummary* HFHadron = 0;
    AliAnalysisTaskHFJets::AliJetInfoSummary* HFJet = 0;
    treeIn[iH]->SetBranchAddress("DmesonJet", &HFHadron);
    treeIn[iH]->SetBranchAddress("Jet_AKTChargedR040_E_scheme", &HFJet);

    TString sNameTree = Form("tree_%s", sLabelsHadron[iH].Data());
    treeOut[iH] = new TTree(sNameTree.Data(), sNameTree.Data());
    treeOut[iH]->Branch("pt_cand", &dPtHadron);
    treeOut[iH]->Branch("eta_cand", &dEtaHadron);
    treeOut[iH]->Branch("phi_cand", &dPhiHadron);
    treeOut[iH]->Branch("y_cand", &dYHadron);
    treeOut[iH]->Branch("pdg_parton", &iPDGParton);
    treeOut[iH]->Branch("pt_jet", &dPtJet);
    treeOut[iH]->Branch("eta_jet", &dEtaJet);
    treeOut[iH]->Branch("phi_jet", &dPhiJet);
    treeOut[iH]->Branch("delta_r_jet", &dR);
    treeOut[iH]->Branch("z", &dZJet);
    treeOut[iH]->Branch("n_const", &iNConst);
    treeOut[iH]->Branch("zg_jet", &dZgJet);
    treeOut[iH]->Branch("rg_jet", &dRgJet);
    treeOut[iH]->Branch("nsd_jet", &iNSD);
    treeOut[iH]->Branch("Pt_mother_jet", &dPtMother);
    treeOut[iH]->Branch("k0_jet", &dK0);
    treeOut[iH]->Branch("k1_jet", &dK1);
    treeOut[iH]->Branch("k2_jet", &dK2);
    treeOut[iH]->Branch("kT_jet", &dKT);

    Int_t iNEntries = treeIn[iH]->GetEntries();
    printf("Starting the %s loop for %d entries.\n", sLabelsHadron[iH].Data(), iNEntries);
    for(Int_t i = 0; i < iNEntries; i++)
    {
      treeIn[iH]->GetEntry(i);

      dPtHadron = HFHadron->fPt;
      dEtaHadron = HFHadron->fEta;
      dPhiHadron = HFHadron->fPhi;
      dYHadron = HFHadron->fY;
      iPDGParton = HFHadron->fPartonType;
      dPtJet = HFJet->fPt;
      dEtaJet = HFJet->fEta;
      dPhiJet = HFJet->fPhi;
      dR = HFJet->fR;
      dZJet = HFJet->fZ;
      iNConst = HFJet->fN;
      dZgJet = HFJet->fZg;
      dRgJet = HFJet->fRg;
      iNSD = HFJet->fNSD;
      dPtMother = HFJet->fPtMother;
      dK0 = HFJet->fK0;
      dK1 = HFJet->fK1;
      dK2 = HFJet->fK2;
      dKT = HFJet->fKT;
      treeOut[iH]->Fill();
    }
    printf("End of the %s loop.\n", sLabelsHadron[iH].Data());
  }

  printf("Writing the output.\n");
  fileOut->cd();
  listOut->Write(0, TObject::kOverwrite);
//  listOut->Write();
  for(Int_t iH = 0; iH < iNHadrons; iH++)
    treeOut[iH]->Write(0, TObject::kOverwrite);
//  fileOut->ls();
  fileOut->Close();
  fileIn->Close();
  printf("Output saved.\n");
  TFile* fileTest = new TFile(sPathFileOutput.Data());
  fileTest->ls();
  fileTest->Close();
  printf("End\n");
}
