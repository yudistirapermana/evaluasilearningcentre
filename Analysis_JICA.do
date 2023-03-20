clear
cls
set more off

** Directory for database may change following your PC/laptop directory
cd "C:\Users\Dropbox\Evaluasi Program & Ekonomi JICA Loan\Rubrik Penilaian Indikator Outcome\Data Regresi\Output"
use data_all

**Kindly reminder that these codes apply for all faculties**

eststo clear
ssc install outreg2
ssc install xtivreg2
gen d=(t>5)

//STARTING 2SLS REGRESSION//

**Kualitas Lulusan**

gen cumlaude = 1 if rataIPK > 3.49 & ratastudi < 49
replace cumlaude = 0 if rataIPK <= 3.49 & ratastudi >= 49

foreach x of varlist tunggu_kerja reputasi_lulusan sesuai levjab puas {
	eststo a4_`x': ivregress 2sls `x' d (cumlaude output_DUDI_MoU = kerjasama_ pelatihan_ labLC_ risetlab_ pendanaanLCriset_ aktivitas_DUDI_MoU_), first vce(robust)
	outreg2 `x' using kualitas_lulusan.xls, append symbol(***, **, *)
	predict p_`x', xb
}

**Kualitas Pelaksanaan Pendidikan**

foreach x of varlist akreditasi_intern_ akreditasi_nas_ sertifikasi_intern_ asosiasi_ {
	eststo a3_`x': ivregress 2sls `x' d (pengajartetap_naik_ DTPSpermah_ output_DUDI fasbelpermah_ = labLC_ kerjasama_ pendanaanLCriset_ pelatihan_ RKAT_ LCriset_), first vce(robust)
	outreg2 `x' using kualitas_pelaksanaan_pendidikan.xls, append  symbol(***, **, *)
	predict p_`x', xb
}
	
**Penerapan Hasil Penelitian**

foreach x of varlist risetHKI_ risetinstansi_ {
	eststo a4_`x': ivregress 2sls `x' d (researchgrant_ danmas_ mahasiswariset_ output_DUDI = labLC_ kerjasama_ pendanaanLCriset_ pelatihan_ RKAT_ LCriset_), first vce(robust)
	outreg2 `x' using penerapan_hasil_penelitian.xls, append  symbol(***, **, *)
	predict p_`x', xb
}
	
**Socio Entrepreneur Mahasiswa**

foreach x of varlist youngentrepreneur_ pendampingan_{
	eststo a4_`x': ivregress 2sls `x' d (danmaspengmas_ mahasiswausaha_ wirausahamuda_ pengembangusaha_ peningkataninstitusi_ = kerjasama_ programkewirus_ pengmasLC_ mahasiswapengmas_ RKAT_), first vce(robust)
	outreg2 `x' using socio_entrepreneur_mahasiswa.xls, append  symbol(***, **, *)
	predict p_`x', xb
}


**Inovasi T&K Nasional**
foreach x of varlist jurnalintern_ jurnalnas_ buku_ medintern_ mednas_  {
	eststo a4_`x': ivregress 2sls `x' d RKAT_ danmasriset_ danmaspengmas_ daneks_ (mahasiswariset_ jurnaltugasakhir_ seminartugasakhir_ = labLC_ kerjasama_ pendanaanLCriset_ pelatihan_ LCriset_), first vce(robust)
	outreg2 `x' using inovasi_TK_nasional.xls, append  symbol(***, **, *)
	predict p_`x', xb
}
