/*
##################################################################################
# Date Modified: 4/29/2023
# Purpose of Code: Build out Visit Counts
# Written by: Brian Roskelley
# Updated by:
# Tableau: [FILL IN URL]

IMPORTANT TABLES/FIELDS:
table = dbo.enc
encType 1 = In person Visit
encType 2 = Telephone Contact
encType 4 = NULL
encType 5 = LAB
encType 6 = WEB
encType 7 = ePrescription
encType 8 = PTDASH
encType 9 = NULL
encType 12 = NULL

TEST ACCOUNTS:
dbo.enc
patientID = 31643, 8663
There might be a case where a test account is included in the final visit query count. Just omit that patientID (ie 31643)
The delete flag is necessary. If you do not include that variable, if someone has a
value greater than 0, it will count that encounter and you don't want that. I have no idea what
deleteFlag is controlled by. ¯\_(ツ)_/¯

Current Pivot table is looking for the following fields:
Visit Type
Visit Status
Appointment Date
Visit Count



QUESITONS:
1. What are the different visit types and where can I go to see them in ECW?
##################################################################################
*/



--Get a distinct visit count. Don't touch this one. It is done.
select
--patientID,
--encounterID
count (distinct encounterID) as visit_count
from dbo.enc
where date between '2023-01-01' and '2023-01-10'
and encType in ('1')
and deleteFlag <> 1
--and patientID in ('33761','35976')
--group by patientID



--Get a distinct visit count by Facility or Provider. Don't touch this one. It is done.
select
enc.doctorID,
doctors.PrintName,
count (distinct enc.encounterID) as visit_count
from dbo.enc enc
join dbo.doctors doctors
on enc.doctorID = doctors.doctorID
where enc.date between '2023-01-01' and '2023-01-10'
and enc.encType in ('1')
and enc.deleteFlag <> 1
group by enc.doctorID, doctors.PrintName
--order by enc.date
--and patientID in ('33761','35976')
--group by patientID



--Get a distinct new patient count by Facility or Provider grouped by date. Don't touch this one. It is done.
select
patientID,
encounterID,
count (distinct encounterID) as visit_count
from dbo.enc
where date between '2023-01-01' and '2023-01-15'
and encType in ('1')
and deleteFlag <> 1
and VisitType = 'NP'
--and patientID in ('33761','35976')
group by patientID, encounterID



--Not sure if prisma_encounters is a valid table.
select *
--count (distinct recordID)
from dbo.prisma_encounters
where serviceDate between '2023-01-02' and '2023-01-04'
and recordID = '35976'

select * from dbo.prisma_encounters



--Not sure what this table is for.
select *
--count (distinct ItemID)
from dbo.edi_inv_cpt
where SDOS between '2023-01-02' and '2023-01-04'
and Id = '35976'

select top 10000 * from dbo.edi_inv_cpt
