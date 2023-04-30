/*
##################################################################################
# Date Modified: 4/27/2023
# Purpose of Code: Build out Financial Data
# Written by: Brian Roskelley
# Updated by: 
# Tableau: [FILL IN URL]

IMPORTANT FIELDS/VALUES:
table = UNKNOWN
Patient Acct No
Claim No

TEST ACCOUNTS:


QUESTIONS:
1. How is Vanessa totalling the Dashboard workheet for:
'Unique_Patient' = 8837
'Visits" = 27235
There is no calculation in the Excel worksheet for those values but she does have a pivot table
that just lists out 'patient_account_no' and '




##################################################################################
*/



--Get a count of unique (distinct) visits




--Get a count of unique (distinct) patients
select
--enc.doctorID,
--doctors.PrintName,
count (distinct enc.encounterID) as visit_count
from dbo.enc enc
--join dbo.doctors doctors
--on enc.doctorID = doctors.doctorID
where enc.date between '2000-01-01' and '2023-04-28'
and enc.encType in ('1')
and enc.deleteFlag <> 1
--group by enc.encounterID
--group by enc.doctorID, doctors.PrintName
--order by enc.date
--and patientID in ('33761','35976')
--group by patientID

select
enc.doctorID,
doctors.PrintName,
count (distinct enc.encounterID) as visit_count
from dbo.enc enc
join dbo.doctors doctors
on enc.doctorID = doctors.doctorID
where enc.date between '2000-01-01' and '2023-04-28'
and enc.encType in ('1')
and enc.deleteFlag <> 1
group by enc.doctorID, doctors.PrintName
--order by enc.date
--and patientID in ('33761','35976')
--group by patientID












--Facilities
with facilities as
(select * from dbo.edi_facilities),
--Users
users as
(select * from dbo.users),
--ENC
enc as
(select * from dbo.enc)

select a.name, a.pos, c.doctorID
from enc c
left join facilities a
on c.pos = a.pos
where a.pos = '11'


from dbo.doctors b

join b.doctorID on c.doctorID


select top 1000 * from dbo.users
select top 1000 * from dbo.doctors
select top 1000 * from dbo.edi_facilities
select top 1000 * from dbo.enc
where patientID = '22928'


join
users b
on a.

a.uid,
CONCAT(a.ulname,', ', a.ufname) as Patient,
CONVERT(varchar, a.ptDob, 107) as 'Patient DOB',
FLOOR((CAST (GetDate() AS INTEGER) - CAST(a.ptDOB AS INTEGER)) / 365.25) as 'Patient Age',
a.sex as 'Patient Gender',
a.upaddress as 'Patient Address Line 1',
a.upaddress2 as 'Patient Address Line 2',
a.upcity as 'Patient City',
a.upstate as 'Patient State',
a.zipcode as 'Patient ZIP Code',
a.CountryCode as 'Patient Country Code',
a.umobileno as 'Patient Cell Phone',
a.upPhone as 'Patient Home Phone'
from dbo.users a
join dbo.edi_facilities b on 


select top 1000 *  from dbo.edi_inv_cpt
where InvoiceID = '10157'


select doctorID, patientID, encounterID from dbo.enc
where encounterId = '10157'

select top 10 * from dbo.enc
where encounterID = '14990'

select top 10 * from dbo.prisma_encounters
where recordid = '10157'
14990

select top 10 * from dbo.prisma_providers
where prismaRecordId = '17613'

select top 10 * from dbo.prisma_user_patient_mapping
where userID = '17613'

select top 10 * from dbo.prisma_patient_data
where patientId like '%17613%'

select top 10 * from dbo.prisma_patient_status
where patientID = '17613'

select top 10 * from dbo.prisma_userprofile_settings
where uid = '22129'

select * from dbo.enc
where patientID = '22129'

'recordid' in prisma_encounters = 'invoiceid' in edi_inv_cpt
'recordid' in prisma_encounters = 'prismaRecordID' in prisma_providers

--financial data
select a.recordid as 'Claim No', 
c.patientID as 'Patient Acct No', 
--b.prismaRecordID as 'Claim No', 
--b.name, 
c.doctorID, 
d.PrintName
from dbo.prisma_encounters a
--join dbo.prisma_providers b
--on a.recordid = b.prismaRecordID
--on a.id = b.id
join dbo.enc c
on a.recordid = c.InvoiceId
left join dbo.doctors d
on c.doctorID = d.doctorID
where a.recordid = '10157'