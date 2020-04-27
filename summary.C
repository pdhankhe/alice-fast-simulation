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

//#include "AliAnalysisTaskHFJets.h"

void summary(TString sPathFileInputPattern, Bool_t bExtended = 0)
{
  printf("Loading the library.\n");
  gSystem->Load("libAnalysisCode.so");

  TString sSuff = "";
  TFile* F_Powheg;
  TTree* T_XSections;
  TList* L_XSections;
  TProfile* fh_XSections_Weights;
  Double_t XSections_Weights;
  Double_t XSections_Events;
  Int_t N_Entries = 0;
  AliAnalysisTaskHFJets::AliDmesonMCInfoSummary* HFHadron = 0;
  AliAnalysisTaskHFJets::AliJetInfoSummary* HFJet = 0;
  std::vector<AliAnalysisTaskHFJets::AliDmesonMCInfoSummary> HFHadronEx;
  std::vector<AliAnalysisTaskHFJets::AliJetInfoSummary> HFJetEx;

  Double_t dPDG_Parton = 0.0;
  Double_t dPtHadron = 0.0;
  Double_t dEtaHadron = 0.0;
  Double_t dPhiHadron = 0.0;
  Double_t dYHadron = 0.0;

  Double_t iNConst = 0;
  Double_t dPtJet = 0.0;
  Double_t dEtaJet = 0.0;
  Double_t dPhiJet = 0.0;
  Double_t dZJet = 0.0;
  Double_t dZgJet = 0.0;
  Double_t dRgJet = 0.0;
  Double_t iNSD = 0;
  Double_t dPt_splitting = 0.0;
  Double_t dK0 = 0.0;
  Double_t dK1 = 0.0;
  Double_t dK2 = 0.0;
  Double_t dKT = 0.0;

  Double_t dRangedPtH[2] = {0, 204.8};
  const Int_t iNBinsPtH = Int_t(TMath::Power(2, 12));
  Double_t dRangedEtaH[2] = { -2.048, 2.048};
  const Int_t iNBinsEtaH = Int_t(TMath::Power(2, 10));
  Double_t dRangedPhiH[2] = {0, TMath::TwoPi()};
  const Int_t iNBinsPhiH = Int_t(TMath::Power(2, 10));

  Double_t dRangedPtJet[2] = {0, 409.6};
  const Int_t iNBinsPtJet = Int_t(TMath::Power(2, 13));
  Double_t dRangedEtaJet[2] = { -2.048, 2.048};
  const Int_t iNBinsEtaJet = Int_t(TMath::Power(2, 10));
  Double_t dRangedPhiJet[2] = {0, TMath::TwoPi()};
  const Int_t iNBinsPhiJet = Int_t(TMath::Power(2, 10));

  TH1D* hisPtH = 0;
  TH1D* hisEtaH = 0;
  TH1D* hisPhiH = 0;

  TH1D* hisPtJet = 0;
  TH1D* hisEtaJet = 0;
  TH1D* hisPhiJet = 0;


  F_Powheg = new TFile(sPathFileInputPattern.Data());
  if(F_Powheg->IsZombie())
  {
    printf("Skipping\n", sSuff.Data());
    continue;
  }

  L_XSections = (TList*) F_Powheg->Get("AliAnalysisTaskHFJets_histos");
  if(!L_XSections)
  {
    printf("Could not get L_XSections\n.");
    return;
  }
  fh_XSections_Weights = (TProfile*) L_XSections->FindObject("fHistXsection");
  if(!fh_XSections_Weights)
  {
    printf("Could not get fh_XSections_Weights\n.");
    return;
  }
  XSections_Weights = fh_XSections_Weights->GetBinContent(1);
  XSections_Events = fh_XSections_Weights->GetEntries();
  Double_t dScaleFactor = XSections_Weights / XSections_Events;
//  printf("Scaling factor: %g\n", dScaleFactor);
  printf("xsection:\t%g\n", XSections_Weights);

  TString sLabelsHadron[2] = {"D0", "Lc"};

  for(Int_t iH = 0; iH < 2; iH++)
  {

    hisPtH = new TH1D(Form("hisPtH_%s", sLabelsHadron[iH].Data()), Form("hisPtH_%s", sLabelsHadron[iH].Data()), iNBinsPtH, dRangedPtH[0], dRangedPtH[1]);
    hisEtaH = new TH1D(Form("hisEtaH_%s", sLabelsHadron[iH].Data()), Form("hisEtaH_%s", sLabelsHadron[iH].Data()), iNBinsEtaH, dRangedEtaH[0], dRangedEtaH[1]);
    hisPhiH = new TH1D(Form("hisPhiH_%s", sLabelsHadron[iH].Data()), Form("hisPhiH_%s", sLabelsHadron[iH].Data()), iNBinsPhiH, dRangedPhiH[0], dRangedPhiH[1]);

    hisPtJet = new TH1D(Form("hisPtJet_%s", sLabelsHadron[iH].Data()), Form("hisPtJet_%s", sLabelsHadron[iH].Data()), iNBinsPtJet, dRangedPtJet[0], dRangedPtJet[1]);
    hisEtaJet = new TH1D(Form("hisEtaJet_%s", sLabelsHadron[iH].Data()), Form("hisEtaJet_%s", sLabelsHadron[iH].Data()), iNBinsEtaJet, dRangedEtaJet[0], dRangedEtaJet[1]);
    hisPhiJet = new TH1D(Form("hisPhiJet_%s", sLabelsHadron[iH].Data()), Form("hisPhiJet_%s", sLabelsHadron[iH].Data()), iNBinsPhiJet, dRangedPhiJet[0], dRangedPhiJet[1]);

    T_XSections = (TTree*) F_Powheg->Get(Form("AliAnalysisTaskHFJets_%s_MCTruth", sLabelsHadron[iH].Data()));
    if(!T_XSections)
    {
      printf("Could not get T_XSections\n.");
      return;
    }

//    printf("Setting branches.\n");

    T_XSections->SetBranchAddress((bExtended ? "Dmesons" : "DmesonJet"), (bExtended ? &HFHadronEx : &HFHadron));
    T_XSections->SetBranchAddress("Jet_AKTChargedR040_E_scheme", (bExtended ? &HFJetEx : &HFJet));
    N_Entries = T_XSections->GetEntries();

//    printf("Starting loop for %d entries.\n", N_Entries);

    for(Int_t j = 0; j < N_Entries; j++) {
      T_XSections->GetEntry(j);

      dPDG_Parton = HFHadron->fPartonType;
      dPtHadron = HFHadron->fPt;
      dEtaHadron = HFHadron->fEta;
      dPhiHadron = HFHadron->fPhi;
      dYHadron = HFHadron->fY;

      iNConst = HFJet->fN;
      dPtJet = HFJet->fPt;
      dEtaJet = HFJet->fEta;
      dPhiJet = HFJet->fPhi;
      dZJet = HFJet->fZ;
      dZgJet = HFJet->fZg;
      dRgJet = HFJet->fRg;
      iNSD = HFJet->fNSD;
      dPt_splitting = HFJet->fPt_splitting;
      dK0 = HFJet->fK0;
      dK1 = HFJet->fK1;
      dK2 = HFJet->fK2;
      dKT = HFJet->fKT;

      hisPtH->Fill(dPtHadron);
      hisEtaH->Fill(dEtaHadron);
      hisPhiH->Fill(dPhiHadron);

      hisPtJet->Fill(dPtJet);
      hisEtaJet->Fill(dEtaJet);
      hisPhiJet->Fill(dPhiJet);
    }
//    printf("End of loop.\n");

    printf("\n\n\n");
    printf("n_%s:\t%g\n", sLabelsHadron[iH].Data(), hisPtH->GetEntries());
    printf("pt_%s:\t%g\n", sLabelsHadron[iH].Data(), hisPtH->GetMean());
    printf("eta_%s:\t%g\n", sLabelsHadron[iH].Data(), hisEtaH->GetMean());
    printf("phi_%s:\t%g\n\n", sLabelsHadron[iH].Data(), hisPhiH->GetMean());
    printf("pt_jet_%s:\t%g\n", sLabelsHadron[iH].Data(), hisPtJet->GetMean());
    printf("eta_jet_%s:\t%g\n", sLabelsHadron[iH].Data(), hisEtaJet->GetMean());
    printf("phi_jet_%s:\t%g\n", sLabelsHadron[iH].Data(), hisPhiJet->GetMean());
  }

  F_Powheg->Close();
  printf("End.\n");
}
