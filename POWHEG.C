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

void POWHEG(TString sPathFileInputPattern, TString sLabelHadron = "Lc" /*Lc, D0*/, Bool_t bFD = 1)
{
  // bFD
  // 0 - prompt
  // 1 - feed-down (non-prompt)

  if(sLabelHadron != "Ds" && sLabelHadron != "Lc" && sLabelHadron != "D0")
  {
    printf("Error: Unknown particle %s\n", sLabelHadron.Data());
    return;
  }

  printf("Loading the library.\n");
  gSystem->Load("libAnalysisCode.so");

  const Int_t NVariations = 10;
  TString Variations[NVariations] = {"central", "F1_R05", "F05_R1", "F2_R1", "F1_R2", "F2_R2", "F05_R05", "Mhigh", "Mlow", "NoEvtGen"};
  TFile* F_Powheg = 0;
  TFile* F_Output = 0;
  TTree* T_XSections = 0;
  TTree* treeOut = 0;
  TList* L_XSections = 0;
  TList* listOut = 0;
  TProfile* fh_XSections_Weights = 0;
  Double_t XSections_Weights;
  Double_t XSections_Events;

  TH3F* fh3_feeddown_z = 0;
  TH1F* fh1_feeddown_xsection_z = 0;
  TH3F* fh3_feeddown_zg = 0;
  TH1F* fh1_feeddown_xsection_zg = 0;
  TH3F* fh3_feeddown_rg = 0;
  TH1F* fh1_feeddown_xsection_rg = 0;

  TH2F* fh2_prompt_z = 0;
  TH2F* fh2_prompt_xsection_z = 0;
  TH2F* fh2_prompt_zg = 0;
  TH2F* fh2_prompt_xsection_zg = 0;
  TH2F* fh2_prompt_rg = 0;
  TH2F* fh2_prompt_xsection_rg = 0;

  /*
  // Lc
  Double_t dBinsPtHadron[] = {3.0, 4.0, 6.0, 8.0, 12.0, 24.0};
  Double_t dBinsPtJet[] = {5.0, 7.0, 15.0, 35.0};
  Double_t dBinsZJet[] = {0.4001, 0.6001, 0.7001, 0.8001, 0.9001, 1.0001};
  */
  ///*
  // D0
  Double_t dBinsPtHadron[] = {2, 3, 4, 5, 6, 7, 8, 10, 12, 16, 24, 36, 48}; // sel_an_binmin
  Double_t dBinsPtJet[] = {5.0,7.0,15.0,30.0,50.0}; // D0 zg, sel_binmin2_reco
//  Double_t dBinsPtJet[] = {5.0, 7.0, 10.0, 15.0, 50.0}; // D0 FF, sel_binmin2_reco
  Double_t dBinsZJet[] = {0.2001, 0.4001, 0.5001, 0.6001, 0.7001, 0.8001, 0.9001, 1.0001}; // sel_binminshape_reco
  //*/

  const Int_t iNBinsPtHadron = sizeof(dBinsPtHadron) / sizeof(dBinsPtHadron[0]) - 1;
  const Int_t iNBinsPtJet = sizeof(dBinsPtJet) / sizeof(dBinsPtJet[0]) - 1;
  const Int_t iNBinsZJet = sizeof(dBinsZJet) / sizeof(dBinsZJet[0]) - 1;

  // check sel_binminshape_reco
  Double_t dBinsZgJet[] = {0.1, 0.2, 0.3, 0.4, 0.5};
  const Int_t iNBinsZgJet = sizeof(dBinsZgJet) / sizeof(dBinsZgJet[0]) - 1;
  Double_t dBinsRgJet[] = {0., 0.1, 0.2, 0.3, 0.4, 0.6};
  const Int_t iNBinsRgJet = sizeof(dBinsRgJet) / sizeof(dBinsRgJet[0]) - 1;

  Double_t dPDG_Parton = 0.0;
  Double_t dPtHadron = 0.0;
  Double_t dEtaHadron = 0.0;
  Double_t dYHadron = 0.0;

  Double_t iNConst = 0;
  Double_t dPtJet = 0.0;
  Double_t dEtaJet = 0.0;
  Double_t dPhiJet = 0.0;
  Double_t dZJet = 0.0;
  Double_t dZgJet = 0.0;
  Double_t dRgJet = 0.0;
  Double_t iNSD = 0;
  Double_t dPtMother = 0.0;
  Double_t dK0 = 0.0;
  Double_t dK1 = 0.0;
  Double_t dK2 = 0.0;
  Double_t dKT = 0.0;

  Double_t dRangedPtJet[2] = {7., 15.};
  Double_t dCutEtaJet = 0.5;
  Double_t dPDG_Good = (bFD ? 5 : 4); // 5 - non.prompt, 4 - prompt

  TH1D* hisTest = 0;
  TH2D* hisTest2 = 0;

  for(Int_t i = 0; i < NVariations; i++) {
    if(!bFD && (i == NVariations - 1))
      continue;

    F_Powheg = new TFile(Form("%s_%s.root", sPathFileInputPattern.Data(), Variations[i].Data()));
    if(F_Powheg->IsZombie())
    {
      printf("Skipping %s\n", Variations[i].Data());
      continue;
    }
    printf("Processing %s %s %s\n", sLabelHadron.Data(), (bFD ? "fd" : "prompt"), Variations[i].Data());

    T_XSections = (TTree*) F_Powheg->Get(Form("AliAnalysisTaskHFJets_%s_MCTruth", sLabelHadron.Data(), sLabelHadron.Data()));
    if(!T_XSections)
    {
      printf("Could not get T_XSections\n.");
      return;
    }
    L_XSections = (TList*) F_Powheg->Get(Form("AliAnalysisTaskHFJets_histos", sLabelHadron.Data()));
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

    listOut = new TList();
    listOut->Add(fh_XSections_Weights);


    XSections_Weights = fh_XSections_Weights->GetBinContent(1);
    XSections_Events = fh_XSections_Weights->GetEntries();
    Double_t dScaleFactor = XSections_Weights / XSections_Events;
    printf("Scaling factor: %g\n", dScaleFactor);

    fh3_feeddown_z = new TH3F(Form("fh3_feeddown_z_%s", Variations[i].Data()), Form("fh3_feeddown_z_%s", Variations[i].Data()), iNBinsZJet, dBinsZJet, iNBinsPtJet, dBinsPtJet, iNBinsPtHadron, dBinsPtHadron);
    fh3_feeddown_z->Sumw2();
    fh3_feeddown_zg = new TH3F(Form("fh3_feeddown_zg_%s", Variations[i].Data()), Form("fh3_feeddown_zg_%s", Variations[i].Data()), iNBinsZgJet, dBinsZgJet, iNBinsPtJet, dBinsPtJet, iNBinsPtHadron, dBinsPtHadron);
    fh3_feeddown_zg->Sumw2();
    fh3_feeddown_rg = new TH3F(Form("fh3_feeddown_rg_%s", Variations[i].Data()), Form("fh3_feeddown_rg_%s", Variations[i].Data()), iNBinsRgJet, dBinsRgJet, iNBinsPtJet, dBinsPtJet, iNBinsPtHadron, dBinsPtHadron);
    fh3_feeddown_rg->Sumw2();

    fh1_feeddown_xsection_z = new TH1F(Form("fh1_feeddown_xsection_z_%s", Variations[i].Data()), Form("fh1_feeddown_xsection_z_%s", Variations[i].Data()), iNBinsZJet, dBinsZJet);
    fh1_feeddown_xsection_z->Sumw2();
    fh1_feeddown_xsection_zg = new TH1F(Form("fh1_feeddown_xsection_zg_%s", Variations[i].Data()), Form("fh1_feeddown_xsection_zg_%s", Variations[i].Data()), iNBinsZgJet, dBinsZgJet);
    fh1_feeddown_xsection_zg->Sumw2();
    fh1_feeddown_xsection_rg = new TH1F(Form("fh1_feeddown_xsection_rg_%s", Variations[i].Data()), Form("fh1_feeddown_xsection_rg_%s", Variations[i].Data()), iNBinsRgJet, dBinsRgJet);
    fh1_feeddown_xsection_rg->Sumw2();

    fh2_prompt_z = new TH2F(Form("fh2_prompt_z_%s", Variations[i].Data()), Form("fh2_prompt_z_%s", Variations[i].Data()), iNBinsZJet, dBinsZJet, iNBinsPtJet, dBinsPtJet);
    fh2_prompt_z->Sumw2();
    fh2_prompt_zg = new TH2F(Form("fh2_prompt_zg_%s", Variations[i].Data()), Form("fh2_prompt_zg_%s", Variations[i].Data()), iNBinsZgJet, dBinsZgJet, iNBinsPtJet, dBinsPtJet);
    fh2_prompt_zg->Sumw2();
    fh2_prompt_rg = new TH2F(Form("fh2_prompt_rg_%s", Variations[i].Data()), Form("fh2_prompt_rg_%s", Variations[i].Data()), iNBinsRgJet, dBinsRgJet, iNBinsPtJet, dBinsPtJet);
    fh2_prompt_rg->Sumw2();

    fh2_prompt_xsection_z = new TH2F(Form("fh2_prompt_xsection_z_%s", Variations[i].Data()), Form("fh2_prompt_xsection_z_%s", Variations[i].Data()), iNBinsZJet, dBinsZJet, iNBinsPtJet, dBinsPtJet);
    fh2_prompt_xsection_z->Sumw2();
    fh2_prompt_xsection_zg = new TH2F(Form("fh2_prompt_xsection_zg_%s", Variations[i].Data()), Form("fh2_prompt_xsection_zg_%s", Variations[i].Data()), iNBinsZgJet, dBinsZgJet, iNBinsPtJet, dBinsPtJet);
    fh2_prompt_xsection_zg->Sumw2();
    fh2_prompt_xsection_rg = new TH2F(Form("fh2_prompt_xsection_rg_%s", Variations[i].Data()), Form("fh2_prompt_xsection_rg_%s", Variations[i].Data()), iNBinsRgJet, dBinsRgJet, iNBinsPtJet, dBinsPtJet);
    fh2_prompt_xsection_rg->Sumw2();

    AliAnalysisTaskHFJets::AliDmesonMCInfoSummary* HFHadron = 0;
    AliAnalysisTaskHFJets::AliJetInfoSummary* HFJet = 0;

    printf("Setting branches.\n");

    T_XSections->SetBranchAddress("DmesonJet", &HFHadron);
    T_XSections->SetBranchAddress("Jet_AKTChargedR040_E_scheme", &HFJet);
    Int_t N_Entries = T_XSections->GetEntries();

    F_Output = new TFile(Form("%s_histos_%s_%s.root", sPathFileInputPattern.Data(), sLabelHadron.Data(), Variations[i].Data()), "recreate");
    if(F_Output->IsZombie())
    {
      printf("Failed to create the output file.\n");
      return;
    }

    treeOut = new TTree(Form("tree_%s", sLabelHadron.Data()), Form("tree_%s", sLabelHadron.Data()));
    treeOut->Branch("PtHadron", &dPtHadron);

    printf("Starting loop for %d entries.\n", N_Entries);

    for(Int_t j = 0; j < N_Entries; j++) {
      T_XSections->GetEntry(j);

      dPDG_Parton = HFHadron->fPartonType;
      dPtHadron = HFHadron->fPt;
      dEtaHadron = HFHadron->fEta;
      dYHadron = HFHadron->fY;

      iNConst = HFJet->fN;
      dPtJet = HFJet->fPt;
      dEtaJet = HFJet->fEta;
      dPhiJet = HFJet->fPhi;
      dZJet = HFJet->fZ;
      dZgJet = HFJet->fZg;
      dRgJet = HFJet->fRg;
      iNSD = HFJet->fNSD;
      dPtMother = HFJet->fPtMother;
      dK0 = HFJet->fK0;
      dK1 = HFJet->fK1;
      dK2 = HFJet->fK2;
      dKT = HFJet->fKT;

      treeOut->Fill();

      //printf("N = %d, eta jet = %g, phi = %g, eta = %g, y = %g, z = %g, PtJet = %g, PtHadron = %g, PtMother = %g, r_g = %g, z_g = %g, nSD = %d, k0 = %g, k1 = %g, k2 = %g, kT = %g\n", iNConst, dEtaJet, dPhiJet, dEtaHadron, dYHadron, dZJet, dPtJet, dPtHadron, dPtMother, dRgJet, dZgJet, iNSD, dK0, dK1, dK2, dKT);

      if(dPtJet < dBinsPtJet[0] ||
          dPtJet >= dBinsPtJet[iNBinsPtJet] ||
          dPtHadron < dBinsPtHadron[0] ||
          dPtHadron >= dBinsPtHadron[iNBinsPtHadron] ||
          TMath::Abs(dEtaJet) > dCutEtaJet ||
          dPDG_Parton != dPDG_Good)
        continue;

      if(dPtHadron > 5.0) {
        if(TMath::Abs(dYHadron) > 0.8) continue;
      }
      else {
        if(TMath::Abs(dYHadron) > -0.2 / 15. * dPtHadron * dPtHadron + 1.9 / 15. * dPtHadron + 0.5) continue;
      }

      fh3_feeddown_z->Fill(dZJet, dPtJet, dPtHadron);
      fh3_feeddown_zg->Fill(dZgJet, dPtJet, dPtHadron);
      fh3_feeddown_rg->Fill(dRgJet, dPtJet, dPtHadron);

      if(dPtJet >= dRangedPtJet[0] && dPtJet < dRangedPtJet[1])
      {
        fh1_feeddown_xsection_z->Fill(dZJet);
        fh1_feeddown_xsection_zg->Fill(dZgJet);
        fh1_feeddown_xsection_rg->Fill(dRgJet);
      }

      fh2_prompt_z->Fill(dZJet, dPtJet);
      fh2_prompt_xsection_z->Fill(dZJet, dPtJet);
      fh2_prompt_zg->Fill(dZgJet, dPtJet);
      fh2_prompt_xsection_zg->Fill(dZgJet, dPtJet);
      fh2_prompt_rg->Fill(dRgJet, dPtJet);
      fh2_prompt_xsection_rg->Fill(dRgJet, dPtJet);
    }
    printf("End of loop.\n");

    fh3_feeddown_z->Scale(dScaleFactor);
    fh3_feeddown_zg->Scale(dScaleFactor);
    fh3_feeddown_rg->Scale(dScaleFactor);
    fh1_feeddown_xsection_z->Scale(dScaleFactor);
    fh1_feeddown_xsection_zg->Scale(dScaleFactor);
    fh1_feeddown_xsection_rg->Scale(dScaleFactor);

    fh2_prompt_xsection_z->Scale(dScaleFactor);
    fh2_prompt_xsection_zg->Scale(dScaleFactor);
    fh2_prompt_xsection_rg->Scale(dScaleFactor);

    printf("Writing output\n");
    F_Output->cd();
    if(bFD)
    {
      fh3_feeddown_z->Write("fh3_feeddown_z");
      fh3_feeddown_zg->Write("fh3_feeddown_zg_jet");
      fh3_feeddown_rg->Write("fh3_feeddown_rg_jet");
      fh1_feeddown_xsection_z->Write("fh1_feeddown_xsection_z");
      fh1_feeddown_xsection_zg->Write("fh1_feeddown_xsection_zg_jet");
      fh1_feeddown_xsection_rg->Write("fh1_feeddown_xsection_rg_jet");
    }
    else
    {
      fh2_prompt_z->Write("fh2_prompt_z");
      fh2_prompt_xsection_z->Write("fh2_prompt_xsection_z");
      fh2_prompt_zg->Write("fh2_prompt_zg_jet");
      fh2_prompt_xsection_zg->Write("fh2_prompt_xsection_zg_jet");
      fh2_prompt_rg->Write("fh2_prompt_rg_jet");
      fh2_prompt_xsection_rg->Write("fh2_prompt_xsection_rg_jet");
    }
//    listOut->Write();
    listOut->Write(Form("list_%s", sLabelHadron.Data()), TObject::kSingleKey);
    treeOut->Write();
    F_Output->Close();
    F_Powheg->Close();
  }
  printf("End.\n");
}
