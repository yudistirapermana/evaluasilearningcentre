clear
set more off
cd "C:\Users\Dropbox\Evaluasi Program & Ekonomi JICA Loan\Rubrik Penilaian Indikator Outcome\Data Regresi\Graph"
use data_all 
	
*=======================*=======================
* 1. GENERATING LEARNING CENTER POST-EFFECT
*=======================*=======================

**Automatically post-effect variable generated**

foreach x in tunggu_kerja_S1 tunggu_kerja_S2_ tunggu_kerja_S3 reputasi_lulusan_S1 reputasi_lulusan_S2 reputasi_lulusan_S3 sesuai_S1 sesuai_S2 sesuai_S3 puas_S1puas_S2 puas_S3 atasUMR_S1 atasUMR_S2 atasUMR_S3 levjab_S1 levjab_S2 levjab_S3 rataIPK_S1 rataIPK_S2 rataIPK_S3 ratastudi_S1 ratastudi_S2 ratastudi_S3 kompetens_S1 kompetens_S2 kompetensi_S3 kerjasama_DUDI lab_LC pelatihan AF akreditasi_S1 akreditasi_S2 akreditasi_S3 akreditasi_intern_S1 akreditasi_intern_S2 akreditasi_intern_S3 sertif_intern_S1 sertif_intern_S2 sertif_intern_S3 asosiasi_ pengajar_tetap_naik_ pengajar_tidaktetap_naik_ kerjasama_DUDI_MoU kerjasama_DUDI_PKS DTPSpermah_S1 DTPSpermah_S2 DTPSpermah_S3 fasbelpermah_ruang_kelas fasbelpermah_lab jumlahmahasiswa_S1 jumlahmahasiswa_S2 fasilitas_kerjasama BC LC_riset jurnalintern_ jurnalnas_ buku_ medintern_ mednas_ danmasriset_ daneks_ danmaspengmas_ mahasiswariset_S1 mahasiswariset_S2 mahasiswariset_S3 RKAT_ jurnaltugasakhir_ seminartugasakhir_ kerjasama_ Lcriset_ labLC_ risetHKI_ risetinstansi_ researchgrant_ danmas_ BZ CA CB output_DUDI_MoU output_DUDI_PKS risetlab_ CF pendanaanLCriset_ youngentrepreneur_ pendampingan_ mahasiswausaha_ wirausahamuda_ pengembanganusaha_ peningkataninstitusi_ CN programkewirus_ pengmasLC_ mahasiswapengmas_ CR {
	
	drop `x' if t > 5
}
	gen `x'_T = `x' if t > 5

}
	
**Automatically figure generated

foreach x in akreditasi_* akreditasi_intern_* asosiasi_ atasUMR_* buku_* daneks_ danmas_ danmaspengmas_ danmasriset_ fasbelpermah_* jumlahmahasiswa_* jurnalintern_ jurnalnas_ jurnaltugasakhir_ kerjasama_DUDI_MoU kompetens_* kerjasama_DUDI_PKS LC_riset levjab_* mahasiswariset_* mahasiswausaha_ medintern_* mednas_* output_DUDI_PKS output_DUDI_MoU  pendampingan_ lab_LC pelatihan pengajar_tidaktetap_naik_ pengajar_tetap_naik_ pengembanganusaha_* peningkataninstitusi_* puas_* rataIPK_* ratastudi_* reputasi_* 

researchgrant_ risetHKI_ risetinstansi_ seminartugasakhir_ sertif_intern_* sesuai_* tunggu_kerja_* wirausahamuda_  youngentrepreneur_ RKAT_ DTPSpermah_*  fasilitas_kerjasama kerjasama_ Lcriset_ labLC_ {

twoway line  reputasi_lulusan_S1 puas_S1   t,  scale(.4) ytitle("Skala 1-10") title("Baseline dan Target Kepuasan Pengguna dan Reputasi Lulusan Fakultas Peternakan") xlabel(1 "Ganjil_19/20" 2 "Genap_19/20" 3 "Ganjil_20/21" 4 "Genap_20/21" 5 "Ganjil_21/22" 6 "Genap_21/22" 7 "Ganjil22/23" 8 "Genap22/23" 9 "Ganjil_23/24" 10 "Genap_23/24" 11 "Ganjil_24/25" 12 "Genap_24/25" 13 "Ganjil_25/26" 14 "Genap_25/26") tline(6) legend(rows(2) on)         
}
graph export `x'.jpg, replace
}


