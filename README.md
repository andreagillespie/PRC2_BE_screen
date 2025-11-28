# PRC2_BE_screen
Scripts for the analysis I conducted as part of the PRC2 base editing screen project. Experiments for which I conducted analysis and am including scripts here are:

AM01_ChIP: These chips were not successful as the binding was very non-specific. The chips were for K27me3, EZH2, EED and SUZ12 in 641, 677G, 677V, EED-102, EZH2-156, EZH2-164, SUZ12-110 & SUZ12-95 mutants as well as WT K562s.

mass_spec: This is not really analysis so much as just compiling results from separate mass specs into a single file for downstream analysis by the wet lab researchers.

MF04_ChIP: This chip data was not included in the publication. This experiment was chipping for K27me3, EED, EZH2 & SUZ12 in EED-102, EZH2-156, SUZ12-110 & SUZ12-95 mutants along w/ WT K562.

MF05_ChIP: These chips showed evidence of contamination as detailed in the .Rmd for this and subsequent experiment (MF06_ChIP) so I advised that these should not be included in the manuscript. This experiment was chipping K27me1/2/3 & EZH2 in EZH2-677V, EZH2-677G & EZH2-641 mutants and WT K562.

MF06_ChIP: These chips also showed evidence of contamination with abherrant profiles where there should be nothing so I have also advised these should be excluded, notes are detailed in markdown script. This experiment chipped EZH2, EZHIP, K27me3 & SUZ12 in EZH2-164, EZH2-164_EZHIP-KO, EZH2-677V & WT-OE mutants along with WT K562 cells.

MF07_ChIP: These are the chips that were included in figures 4 & 5 in the manuscript. This experiment was chipping EED, EZH2, EZHIP, K27me3 & SUZ12 in EED-19, SUZ12-110 & SUZ12-110_EZHIP-KO mutants and WT K562s.

sparbier_et_al: This analysis is reprocessing data from our previous publication to align with Hg38 and use peak calls to identify methylation status of genes. Samples used in this manuscript were the SINGLE-K27me3 & -K4me3 chips from Christina's re-chip experment.
