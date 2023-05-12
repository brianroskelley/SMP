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


FacilityID and Facility Name

6 = Millcreek 
2 = Riverton 
5 = Provo South 
19, 50, 51, 52 = Provo North 
4 = Price 
21 = Fillmore
22 = Delta 
3 = Atlanta 
18 = St George 
30 = Vernal
84 = West Valley 
94 = Tampa

AMBLE (Missing Sheridan Assisted Living, Anthology of South Jordan, Amble Home (maybe 86 or 47 or a new one). This might be a new facility)
’15’,’86’,’47’,’27’,’28’,’79’,’81’,’25’,’91’,’126’,’78’,’73’,’92’,’16’,’72’,’74’,’80’,’98’,’41’,’89’,’96’,’23’,’55’,’61’,’30’,’95’,’31’,’71’,’59’,’75’,’9’,’60’,’12’,’62’,’97’,’67’,’54’,’42’,’83’,’24’,’44’,’38’,’13’,’49’,’90’,’17’,’88’,’76’,’32’,’104’,’103’,’105’,’106’,’93’,’108’,’107’,’111’,’110’,’112’,’113’,’116’,’115’,’117’,’118’,’120’,’121’,’122’,’124’,’123’,’126’,’127’,’129’,’130’,’131’,’136’,’135’,’137’,’139’,’141’,’142’

Whole Group
Everyone <> (’34’,’48’,’109’,’63’,’142’,’143’)

Facilities:
Id	Name	Code
15	Abbington Manor Senior Living	ABB
86	Amble Home Care	Amble
47	Amble Home Visit	SUMM
122	Ashford Assisted Living	ASHselect
27	Ashford Draper	ASHDr
28	Ashford Springville	SELECT
138	Ashley Regional Medical Center	
142	Aspen Ridge Care Center	
104	AUBERGE N OGDEN	AUBOG
79	Barton Creek Senior Living	BART
81	Beehive Homes	BEE
116	BeeHive Homes of Syracuse	BeeSyra
131	Beehive Homes of Vernal	
106	BEEHIVE PROVO	BEEHIVE
108	Bel Air senior living	BelAir
120	Bellaview Assisted Living	BELAL
93	Brightwork Villa	Bright
34	Cameron Foot + Ankle - Mesquite	MESQ
25	Canyon Breeze Senior Living	BREEZE
124	Capitol Hill Senior Living	CAPHILLSUM
134	Castleview Hospital	
136	Cedarwood at Sandy	
91	Chancellor Gardens	Chan
126	Charleston at Cedar Hills	CEDHAMB
102	Charleston Cedar Hills	CHAR
14	Copper Creek	Copper
45	Coral Desert Surgery center	
78	Country Home	
111	Country View Assisted Living	COUNT
73	Courtyard at Jamestown	Crtyrd
92	Cove Point Retirement	Cove
125	Cove Point Retirement	CVPTAMB
16	Covington Senior Living	COVSL
72	Crescent Senior Living	Cresc
74	Diamond D/Delta Legacy	DiaDDel
114	DME MEDICARE	
80	Elk Ridge Assisted Living	
53	ELLSWORTH FOOT AND ANKLE	
98	Escalante at Willow Creek	ESCA
129	Gardens Assisted Living	
41	Grove Creek Surgery center	GROVE
29	Heritage Gardens	HERITAGE
57	Heritage Home Assisted Living	
89	Hidden Valley Assisted Living	HID
143	Holiday The Harrison Regent	
96	Holiday The Seville	HOLI
23	Home Visit	HOME
7	Intermountain Medical Center	IMC
65	Intermountain Medical Center ST GEORGE	STG
103	Jamestown Assisted Living	JAMES
55	JARAMILLO HOME VISIT	HOME
61	JARAMILLO SHERIDAN	
128	Jordan Valley Medical Center West	
58	LABORATORY FACILITY	LAB
105	LAKE RIDGE SENIOR LIVING	LARIAMB
119	Lake Ridge Senior Living	LARISUMM
48	Landon Cameron - Mesquite	MESQ
30	Legacy House	LEGACY
43	Legacy House	JARA
95	Legacy House of Ogden	LEGOG
118	Legacy House Spanish Fork	LEGAMB
31	Legacy Village	LEGVILL
123	Legacy Village of Provo	LEGAMB
110	Lotus Park Assisted Living	LOTUS
71	Merrill Gardens	
109	Mesa Valley Estates	Mesa
63	Mesa View regional Hospital	MESA
59	Millard County Care Center	
8	Mountain Point Medical Center	MPMC
39	Old Admin	
75	Orchard View Assisted Living & memory Care	ORCH
40	Orem Community Hospital	OREM
9	Park Terrace Surgery Center	PTSC
141	Peaks at Millcreek	
19	Precision Foot and Ankle	PRECISION
50	Precision Foot and Ankle	SELECT
51	PRECISION FOOT AND ANKLE	DAVID
52	Precision Foot and Ankle	Todd
87	Primrose Retirement Community	Prim
60	Provo Rehab and Nursing	
12	Provo Rehabilitation And Nursing	JARAM
82	Red Cliffs	RED
10	Riverton Hospital	RIVHOS
62	Rocky Mountain Care - Grove Creek	GROVE
97	Rocky Mountain Care Riverton	ROCKYRIV
67	Sagewood at Daybreak	Sage
54	SELECT WENTWORTH	SELECT
42	Spring Gardens Assisted Living	SPRING
112	Spring Gardens Mapleton	SPRINGM
26	Spring Hollow Assisted Living	SPRING
11	St. Marks Surgery Center	SMSC
117	Stoney Brooke Assisted Living	STOBRO
3	Summit Foot + Ankle - Atlanta	ATL
22	Summit Foot + Ankle - Delta	DELTA
21	Summit Foot + Ankle - Fillmore	FILLMORE
4	Summit Foot + Ankle - Huntington	HUNT
6	Summit Foot + Ankle - Millcreek	MILL
20	Summit Foot + Ankle - Park City	PARK
133	Summit Foot + Ankle - Price	PRICE
5	Summit Foot + Ankle - Provo	PROVO
2	Summit Foot + Ankle - Riverton	RIVER
18	Summit Foot + Ankle - St George	STG
94	Summit Foot + Ankle - Tampa	TAMPA
84	Summit Foot + Ankle - West Valley	WVC
33	Summit Foot and Ankle	SANDY
77	Summit Foot and Ankle - Vernal	VERNAL
85	Summit Medical Care	HOME
36	Summit Medical Care - Provo	SMCPROVO
35	Summit Medical Care - Riverton	SMCRIV
37	Summit Medical Care - St. George	SMCSTGEO
83	Templeview Independent Living	TEMP
99	The Charleston at Cedar Hills	CHARCEDAR
100	The Charleston at Cedar Hills	CHARCEDAR
101	The Charleston at Cedar Hills	CHAR
135	The Escalante at Coventry	ESC
24	The Grand at Holliday	GRAND
44	The Grand Holladay	Grand
121	The INN Between	TIBSUMM
130	The Lodge at North Ogden	
38	The Lodge at Riverton	LODGE
13	The Ridge Foothill Assisted Living	RIDGE
49	The Ridge Foothill Assisted Living- Summit	AMBLE
90	The Wellington	Well
17	The Wentworth At Coventry	WENT
88	Timpanogos Regional Hospital	
76	Tradition Assisted Living	TAL
113	Treeo Orem	TREEAMB
139	Treeo South Ogden	
107	Truewood by Merrill	TRUE
137	Twin Oaks Senior Living	
132	Utah Surgical Center	
140	Utah Valley Hospital	
32	Welcome Home	WELHOM
127	Welcome Home Bountiful	
115	Willow Creek - Wentworth	Willow

AMBLE Facilities:
AMBLE (Missing Sheridan Assisted Living, Anthology of South Jordan, Amble Home (maybe 86 or 47 or a new one). This might be a new facility)
’15’,’86’,’47’,’27’,’28’,’79’,’81’,’25’,’91’,’126’,’78’,’73’,’92’,’16’,’72’,’74’,’80’,’98’,’41’,’89’,’96’,’23’,’55’,’61’,’30’,’95’,’31’,’71’,’59’,’75’,’9’,’60’,’12’,’62’,’97’,’67’,’54’,’42’,’83’,’24’,’44’,’38’,’13’,’49’,’90’,’17’,’88’,’76’,’32’,’104’,’103’,’105’,’106’,’93’,’108’,’107’,’111’,’110’,’112’,’113’,’116’,’115’,’117’,’118’,’120’,’121’,’122’,’124’,’123’,’126’,’127’,’129’,’130’,’131’,’136’,’135’,’137’,’139’,’141’,’142’)


QUESITONS:
##################################################################################
*/

--Master Queries for Tableau
select
count (distinct enc.encounterID) as visit_count, enc.facilityid, enc.date
--enc.encounterID as visit_count, enc.facilityId, doctors.FacilityId
from dbo.enc enc
join dbo.doctors doctors
on enc.doctorID = doctors.doctorID
--where enc.date between '2022-11-13 00:00:00.000' and '2022-11-19 00:00:00.000'
and enc.deleteFlag <> 1
--and enc.doctorID = '9176'
--and VisitType = 'NP'
and visittype not in ('ACMR-SCR','JBR-SCR','JBR-SURG','FCR-SCR','ACMR-SURG')
and status not in ('N/S','N/A','R/S','CANCSMS','CANCPHONE','CANC','')
group by enc.facilityid, enc.date


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

--Total Patients Visit Totals. Don't touch this one. It is done.
select
count (distinct enc.encounterID) as visit_count
from dbo.enc enc
join dbo.doctors doctors
on enc.doctorID = doctors.doctorID
where enc.date between '2021-07-04 00:00:00.000' and '2021-07-10 00:00:00.000'
and enc.deleteFlag <> 1
--and enc.doctorID = '9176'
--and VisitType = 'NP'
and visittype not in ('ACMR-SCR','JBR-SCR','JBR-SURG','FCR-SCR','ACMR-SURG')
and status not in ('N/S','N/A','R/S','CANCSMS','CANCPHONE','CANC','')

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
