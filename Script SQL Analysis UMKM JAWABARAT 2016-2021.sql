select * from umkm_jawabarat.data_umkm_jawabarat;

#are there any null data?
select * from umkm_jawabarat.data_umkm_jawabarat
where Id is null
or kode_provinsi is null
or nama_provinsi is null
or kode_kabupaten_kota is null
or nama_kabupaten_kota is null
or kategori_usaha is null
or jumlah_umkm is null
or satuan is null
or tahun is null;

#Data type in the column
describe umkm_jawabarat.data_umkm_jawabarat;

#get information about city district codes with city district names in the data
select distinct kode_kabupaten_kota, nama_kabupaten_kota
from umkm_jawabarat.data_umkm_jawabarat;

#show data of umkm in bandung district on 2017
select * from umkm_jawabarat.data_umkm_jawabarat
where nama_kabupaten_kota ='KABUPATEN BANDUNG' and tahun = 2017;

#show data on business category,district name and number of umkm
select kategori_usaha, nama_kabupaten_kota, jumlah_umkm from umkm_jawabarat.data_umkm_jawabarat;


#show umkm data from 2017 sorted by businees categories
select * from umkm_jawabarat.data_umkm_jawabarat
where tahun >= 2017 
order by kategori_usaha asc;

#What businees categori are in the umkm data
select distinct kategori_usaha from umkm_jawabarat.data_umkm_jawabarat;

#show 10 umkm data with culinary and fashion business categories
select * from umkm_jawabarat.data_umkm_jawabarat
where kategori_usaha in ("KULINER","FASHION")
limit 10;

# swoh all umkm data with fashion category in bandung district
select * from umkm_jawabarat.data_umkm_jawabarat 
where kategori_usaha = "FASHION" and nama_kabupaten_kota= "KABUPATEN BANDUNG";

# Show all data umkm other than business category culinary, food and drink
select * from umkm_jawabarat.data_umkm_jawabarat
where kategori_usaha not in ('KULINER','MAKANAN','MINUMAN');

#from 2017 to 2019 what is the trend in the number of umkm in karawang district for the fashion business category
select nama_kabupaten_kota,jumlah_umkm,kategori_usaha,tahun 
from umkm_jawabarat.data_umkm_jawabarat
where tahun >=2017 
and tahun <=2019 
and kategori_usaha = 'FASHION' 
and nama_kabupaten_kota='KABUPATEN KARAWANG';

#Between the district of Bandung, the city of Bandung and the district of West Bandung, where is the umkm centre for the culinary business category in 2020
select * from umkm_jawabarat.data_umkm_jawabarat
where nama_kabupaten_kota like "%BANDUNG%" 
and kategori_usaha = "KULINER"
and tahun = 2020
order by jumlah_umkm desc;

#Which districts have code 7 in the third digit of the city district code
select distinct nama_kabupaten_kota, kode_kabupaten_kota 
from umkm_jawabarat.data_umkm_jawabarat 
where kode_kabupaten_kota like "__7%";

#how many rows are ini the data
select count(*) as total_data from umkm_jawabarat.data_umkm_jawabarat;

#how many umkm in karawang district in 2019
select sum(jumlah_umkm) as total_umkm_kabupaten_karawang_2019 
from umkm_jawabarat.data_umkm_jawabarat
where nama_kabupaten_kota = "KABUPATEN KARAWANG" 
and tahun ="2019";

#total of umkm in bekasi district in the years 2018 to 2021
select tahun, sum(jumlah_umkm) as Total_umkm 
from umkm_jawabarat.data_umkm_jawabarat
where nama_kabupaten_kota="KABUPATEN BEKASI" 
and tahun >=2018 and tahun <=2021
group  by tahun;

#The average total of umkm per business category per district/city in West Java in 2019
select  nama_kabupaten_kota,tahun, kategori_usaha, 
avg(jumlah_umkm) as rata_rata_jumlah_umkm 
from umkm_jawabarat.data_umkm_jawabarat
where tahun =2019 
group by nama_kabupaten_kota,tahun, kategori_usaha;

#The maximum and minimum number of umkm in each district/city in the province of jawabarat?
select nama_kabupaten_kota, 
max(jumlah_umkm) as max_umkm , 
min(jumlah_umkm) as min_umkm 
from umkm_jawabarat.data_umkm_jawabarat
group by nama_kabupaten_kota;

#which districts/cities have more than 400,000 umkm units in 2018
select nama_kabupaten_kota, sum(jumlah_umkm) as total_umkm 
from umkm_jawabarat.data_umkm_jawabarat
where tahun = 2018
group by nama_kabupaten_kota
having total_umkm >400000;

#Create stored procedured
DELIMITER $$
create procedure alldata ()
Begin
	select * from umkm_jawabarat.data_umkm_jawabarat;
end $$
DELIMITER ;

#call stored procedured
call alldata () ;

#show status stored procedure
show procedure status;

#delete stored procedure
drop procedure alldata ;

#create strored procedure with paramater

delimiter //
create procedure get_data_umkm_based_on_regency
(
	in name_regency varchar(50)
)
begin
	select *from umkm_jawabarat.data_umkm_jawabarat
	where nama_kabupaten_kota = name_regency;
end //
delimiter ;

call get_data_umkm_based_on_regency ("KABUPATEN GARUT");

delimiter //
create procedure get_total_rows 
(
	out total_rows int
)
begin
	select count(*) into total_rows from umkm_jawabarat.data_umkm_jawabarat;
end //
delimiter ;

call get_total_rows (@total_rows);
select @total_rows;

delimiter //
create procedure get_total_rows_based_on_regency
(
	inout code_regency int
)
begin
	select count(*) into code_regency from umkm_jawabarat.data_umkm_jawabarat
    where kode_kabupaten_kota = code_regency;
end //
delimiter ;

set @code_ = 3202;
call get_total_rows_based_on_regency(@code_);
select @code_;

