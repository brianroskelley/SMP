/*
##################################################################################
# Date Modified: 5/17/2023
# Purpose of Code: Build out Financial Data
# Written by: Brian Roskelley
# Updated by: 
# Tableau: [FILL IN URL]

IMPORTANT FIELDS/VALUES:
table = UNKNOWN
Patient Acct No
Claim No

IMPORTANT FIELDS/VALUES:
table = dbo.superbill_categories
Field = groupid
Values:
3 = Casting
4 = Endo/Arth
6 = Foot
10 = Leg
15 = Strap & Splints
16 = E/M Consult
17 = E/M EST


CPT Codes not in:
('82607','83037','87075','87481','87500','87640','87641','87651','87798','87801','88305','Q4101','Q4106','Q4132','Q4133','Q4158','Q4159','Q4164','Q4177','Q4188','Q4196','Q4197','Q4204','Q4210','Q4215','Q4244','Q4248','Q4252','Q4254','11400','A6010','A6223','L0649','QUTRE','1100F','11740','3288F','G8430','28730','99337','G0456','38220','PSLEV','A6021','A5510','99201','17000','17003','Q4234','86340','99211','76140','28315','11600','29892','L4396','L4631','27632','88304','S9981','99224','93998','28092','99321','Q4221','REF','A5512','28238','27613')

TEST ACCOUNTS:


QUESTIONS:

##################################################################################
*/


select 
inv.id as claim_no,
inv.encounterid,
inv.patientid,
--inv.dosproviderid,
--inv.paytoproviderid,
--inv.renproviderid,
--inv.supervisorid,
--inv.guarantorid,
inv.servicedt as service_date,
inv.invoicedt,
inv.InvoiceAmount,
inv.payment,
inv.copay,
inv.uncoveredamount,
inv.ptresp,
inv.ptpayment,
inv.ptbalance,
inv.balance,
inv.netpayment as allowed,
inv.allowedfee
from dbo.edi_invoice inv
--left join dbo.edi_paymentdetail payment
--on inv.id = payment.invoiceid
where renproviderID in ('9176')
and servicedt between '2021-07-25 00:00:00.000' and '2021-07-31 00:00:00.000'
and id = '1092'




