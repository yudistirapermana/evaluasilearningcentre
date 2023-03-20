clear
cls
set more off
capture log close

cd "D:\Kurang Duit\PIU-JICA\Analisis\Data Regresi\Dofile Analisis Evaluasi Outcome\"

**cd "E:\Dropbox\Evaluasi Program & Ekonomi JICA Loan\Rubrik Penilaian Indikator Outcome\Data Regresi\"

************************************************************************************************
* RESHAPING DATA FROM WIDE TO LONG --> THIS IS VOKASI CASE, THIS APPLIES to ANY FACULTIES
************************************************************************************************

** Socio
use Socio_Entrepreneurship_Mahasiswa.dta, clear
gen t=_n
reshape long youngentrepreneur_ pendampingan_  mahasiswausaha_ wirausahamuda_ pengembangusaha_ peningkataninstitusi_ danmaspengmas_ programkewirus_ pengmasLC_ mahasiswapengmas_ kerjasama_, i(Periode t) j(dept) string

tempfile temp
save `temp', replace

** Inovasi tek
use Inovasi_Teknologi.dta, clear
gen t=_n
ren medintern_dtsl medintern_DTSL // we can change any unique abbreviation according to the specific faculty
ren mednas_dtsl mednas_DTSL
ren jurnalintern_DELIKES jurnalintern_DLIKES
destring medintern_DLIKES mednas_DLIKES daneks_DBSMB daneks_DLIKES danmaspengmas_DLIKES mahasiswariset_DLIKES RKAT_DLIKES jurnaltugasakhir_DLIKES seminartugasakhir_DLIKES kerjasama_DLIKES LCriset_DLIKES labLC_DLIKES, force replace
reshape long jurnalintern_ jurnalnas_ buku_ medintern_ mednas_ danmasriset_ daneks_ danmaspengmas_ mahasiswariset_ RKAT_ jurnaltugasakhir_ seminartugasakhir_ kerjasama_ LCriset_ labLC_, i(Periode t) j(dept) string

merge Periode t dept using `temp'
save `temp', replace

** Penerapan hasil pen
use Penerapan_Hasil_Penelitian.dta, clear
gen t=_n
reshape long risetHKI_ risetinstansi_ researchgrant_ danmas_ mahasiswariset_ output_DUDI_MoU_ output_DUDI_PKS_ risetlab_ labLC_ pendanaanLCriset_, i(Periode t) j(dept) string

merge Periode t dept using `temp'
save `temp', replace


** Kualitas pelaksanaan
use Kualitas_Pelaksanaan_Pendidikan.dta, clear
gen t=_n
egen akreditasi_nas_DEB=rmean(akreditasi_manajemenPP_DEB akreditasi_perbankan_DEB akreditasi_ASP_DEB akreditasi_pemekwil_DEB)
egen akreditasi_nas_DBSMB=rmean(akreditasi_arsiprekaman_DBSMB akreditasi_bahasainggris_DBSMB akreditasi_bisniswisata_DBSMB)
egen akreditasi_nas_DTM=rmean(akreditasi_rekayasamesin_DTM akreditasi_alatberat_DTM)
egen akreditasi_nas_DTEDI=rmean(akreditasi_perangkatlunak_DTEDI akreditasi_rekayasaelektro_DTEDI akreditasi_instrumentasi_DTEDI akreditasi_internet_DTEDI)
egen akreditasi_nas_DTSL=rmean(akreditasi_pemeliharaan_DTSL akreditasi_pelaksanaan_DTSL)
egen akreditasi_nas_DTK=rmean(akreditasi_pemetaan_DTK akreditasi_SIG_DTK)
egen akreditasi_nas_DLIKES=rmean(akreditasi_mankes_DLIKES)
egen akreditasi_nas_DTHV=rmean(akreditasi_pengelolahutan_DTHV akreditasi_tekveteriner_DTHV akreditasi_agroindustri_DTHV)

drop akreditasi_manajemenPP_DEB akreditasi_perbankan_DEB akreditasi_ASP_DEB akreditasi_pemekwil_DEB akreditasi_arsiprekaman_DBSMB akreditasi_bahasainggris_DBSMB akreditasi_bisniswisata_DBSMB akreditasi_rekayasamesin_DTM akreditasi_alatberat_DTM akreditasi_perangkatlunak_DTEDI akreditasi_rekayasaelektro_DTEDI akreditasi_instrumentasi_DTEDI akreditasi_internet_DTEDI akreditasi_pemeliharaan_DTSL akreditasi_pelaksanaan_DTSL akreditasi_pemetaan_DTK akreditasi_SIG_DTK akreditasi_mankes_DLIKES akreditasi_pengelolahutan_DTHV akreditasi_tekveteriner_DTHV akreditasi_agroindustri_DTHV

ren akreditasi_intern_DEBYa1 akreditasi_intern_DEB

reshape long akreditasi_nas_ akreditasi_intern_ sertifikasi_intern_ asosiasi_ pengajartetap_naik_ pengajartidaktetap_naik_ output_DUDI_PKS_ output_DUDI_MoU_ DTPSpermah_ fasbelpermah_ kerjasama_ labLC_ pendanaanriset_, i(Periode t) j(dept) string

merge Periode t dept using `temp'
save `temp', replace

** Kualitas lulusan
use Kualitas_Lulusan.dta, clear
gen t=_n

reshape long tunggu_kerja_ reputasi_lulusan_ sesuai_ puas_ atasUMR_ levjab_ rataIPK_D3reg_ rataIPK_D4AP_ rataIPK_D4reg_ ratastudi_D3reg_ ratastudi_D4AP_ ratastudi_D4reg_ kompetensi_ output_DUDI_MoU_ output_DUDI_PKS_ labLC_ pelatihan_ aktivitas_DUDI_MoU_ aktivitas_DUDI_PKS_, i(Periode t) j(dept) string

merge Periode t dept using `temp'
drop _m

gen dept_id=1 if dept=="DBSMB"
replace dept_id=2 if dept=="DEB"
replace dept_id=3 if dept=="DLIKES"
replace dept_id=4 if dept=="DTEDI"
replace dept_id=5 if dept=="DTHV"
replace dept_id=6 if dept=="DTK"
replace dept_id=7 if dept=="DTM"
replace dept_id=8 if dept=="DTSL"

so dept_id t
order Periode t dept dept_id

xtset dept_id t

saveold data_all, replace v(12)
