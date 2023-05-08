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

table = dbo.enc
Field = VisitType
Values:
CON
VISION
PTDASH
ORTHO CONS
ESTPT
NULL
F/U
SUR
zINJ
TEL
ANN VISIT
AWV
OB
Coun
NP
Pre
Dental
NV
IGTN-EST
PRE-OP
CC
NP-DM
CC-SNF
NP-IGTN
NEUR
JBR-SCR
IGTN-NC
NP-NEUR
POST-OP
WOUND
POSTOP#1
POSTOP#2
POSTOP#3
Migrated
NP-REF
ORTH-P/U
LZR
ACMR-SCR
PROC
FCR-SCR
WEB
ePrescription
JBR-SURG
Home
ORTH SCAN
Qutenza
LZR/ELIGIB
NP-Wound
POSTOP#4
LAB
ACMR- SURG
'CON','VISION','PTDASH','ORTHO CONS','ESTPT','NULL','F/U','SUR','zINJ','TEL','ANN VISIT','AWV','OB','Coun','NP','Pre','Dental','NV','IGTN-EST','PRE-OP','CC','NP-DM','CC-SNF','NP-IGTN','NEUR','JBR-SCR','IGTN-NC','NP-NEUR','POST-OP','WOUND','POSTOP#1','POSTOP#2','POSTOP#3','Migrated','NP-REF','ORTH-P/U','LZR','ACMR-SCR','PROC','FCR-SCR','WEB','ePrescription','JBR-SURG','Home','ORTH SCAN','Qutenza','LZR/ELIGIB','NP-Wound','POSTOP#4','LAB','ACMR- SURG',

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

--New Patients by Doctor. Don't touch this one. It is done.
select
count (distinct enc.encounterID) as visit_count, doctors.PrintName
from dbo.enc enc
join dbo.doctors doctors
on enc.doctorID = doctors.doctorID
where enc.date between '2021-07-04 00:00:00.000' and '2021-07-10 00:00:00.000'
and enc.deleteFlag <> 1
and enc.doctorID = '9176'
--and VisitType = 'NP'
and visittype in ('NP','NP-DM','NP-IGTN','NP-NEUR','NP-REF','NP-WOUND')
and status not in ('N/S','N/A','R/S','CANCSMS','CANCPHONE','CANC')
group by doctors.printname


--Total Patients by Doctor. Don't touch this one. It is done.
select
count (distinct enc.encounterID) as visit_count, doctors.PrintName
from dbo.enc enc
join dbo.doctors doctors
on enc.doctorID = doctors.doctorID
where enc.date between '2021-07-04 00:00:00.000' and '2021-07-10 00:00:00.000'
and enc.deleteFlag <> 1
and enc.doctorID = '9176'
--and VisitType = 'NP'
and visittype not in ('ACMR-SCR','JBR-SCR','JBR-SURG','FCR-SCR','ACMR-SURG')
and status not in ('N/S','N/A','R/S','CANCSMS','CANCPHONE','CANC','')
group by doctors.printname


--Get a distinct count of Total Patients
select count (distinct pid) from dbo.patients
where webEnabledDate between '2002-08-31 09:44:40.000' and '2023-05-03 09:44:40.000'


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

--Breakout visits by year, month and day. Encounter counts are grouped by Encounter type and DoctorID
select
datepart(year,enc.date) as year,
datepart(month,enc.date) as month,
datepart(day,enc.date) as day,
count (distinct enc.encounterID) as visit_count,
enc.encType,
enc.doctorID
from dbo.enc enc
join dbo.doctors doctors
on enc.doctorID = doctors.doctorID
where enc.date between '2002-08-31 09:44:40.000' and '2023-05-03 09:44:40.000'
and enc.deleteFlag <> 1
--and enc.doctorID = '24718'
group by enc.encType, enc.date, enc.doctorID


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
