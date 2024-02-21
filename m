Return-Path: <linux-acpi+bounces-3798-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B8885E903
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 21:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AB01C229F7
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 20:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055C386ACA;
	Wed, 21 Feb 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NV0Br83h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654A86654;
	Wed, 21 Feb 2024 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547254; cv=fail; b=MbOWUipT4jmfhe6ycZYh53c79BLSOEj2Mo4pXQRXD1hlPlkltPHjOi9NZSWPlIqrUq1F+ZV8VflO7TSwxW+DFSw3O8+fQQXd7UamaGnjlPV1wVoH2QlKRMQATloiM2HD9Qgn72DbQQPRuGam5cQWt4YM7c80NBL6lMpAdZdoNl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547254; c=relaxed/simple;
	bh=S5xCBJAuakpkSEOHR/5bCVqqSdLqrrws4HKNT2i3A8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RlEhjA/mDmUCyDuxMORDZ6uCREqnMva04CY+12CCUDKhiB+OuBkC70aaWaNJC9d//QsPJ5CuLppyFjD+YNgxsF0NQOZ81OXfTahRm0ZlRjqqt7tGVYVzMRmSEQmV40vIkGwuBpSdywmfjINY6/IxS3pq2hlkbn6FXqJ6xJA8h9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NV0Br83h; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEMvh86thHVWhg0fBXSuUU0Rn6tc+AuqEN9G6T4B0QEtl8y+0z/y9BM3jau9w2yQp4h1HqjicHceGxG76a+FysF9dsQpbyE/UZ5jJpJiKq7Xpr2AiKj25cnFLJ348mfgwByaJpMQoKIUB9p111z1taw9nUK3jRoxUxdql8b0u2pd3yLnEEWTwTQu9x2/IezQeTT7IMC6lgEJRrMCx2GiiLeAf76kasz0zAYsURafqUPQe/PnWMA5/pKkJMdwJS+dTJOfm0Ton2KuAuHkjqVPwC5K2qlFnwkW7sE9bsvuqYc3z2A3yjn32nqqAowckTYvomRQ4+gQgqbI05UvnMu61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM4Jke6H7fRexqQwdH+AZYO+mqklytoPynRa5R50ZPk=;
 b=cG7SyDPySFhSUjtFQs7oZb6DimCDaur+Nez6lBzSBJBBxjYxnq3KO9sqX71rGBa6uKa3M75y3/wROrXmvFn8cTtNPTju3QeHaTduYeN8tuvclZxtRziS19yNdwS5Oa/NfNRTBZaSnw9JzeusvRC7ykVXCmfwHxwOWQ/mAOAaUNHePKfr7xipf6vaRSeZh8wcJSnf7tGjbclK7c+pZtIzo09zAM1jO/LYooGdFalwh4vImORtkExfQ0Uz/tNJ0zz9sIWYilzUWMfueNzo9+bHuZwC0U921iBtMCKjeMFbj5HdsFS+grjX61FA0HYG24BsqojEnizjqK/u2WB/EeFpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM4Jke6H7fRexqQwdH+AZYO+mqklytoPynRa5R50ZPk=;
 b=NV0Br83h4caAz26S8vu7SyIAG3A6OcHnb7QU0bm+l0jHD5HkboY8OX2wfKqOAd/d+NT9+5uoKrWhODwdJ5eZPWwBhTKc1ZSfjM4PUFNWsE0k42TBed0c2zcDXJ/ejJRAxZhaAIjpYbDednvE412+Xa22GAaLxJzLSJkmGwRN6x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 20:27:28 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 20:27:28 +0000
Message-ID: <ce39062a-c321-4706-a6b9-b5d3bd8a1c2a@amd.com>
Date: Wed, 21 Feb 2024 14:27:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/4] EINJ: Migrate to a platform driver
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-2-Benjamin.Cheatham@amd.com>
 <65d595c990661_5e9bf294d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65d595c990661_5e9bf294d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::22) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1baa08-c3e5-41c9-8d05-08dc331b85eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dfr+K2zhL/dbEOqXY143Yf4pUmqETIDAnkDNlHs3Q9QfuzX8XAzOJUqaHFhRf/svBxwHMC7Hik8Gyn+oxWvalgM7HeGfmOF/O+UUespoQEi7r3E96zkshmC2SwHaPFPkqJLAgkViSrmdb8eM2Gqf0wsvL5ryHELSenze0NtbrOaVdDPspLPPVHI32XF/ySiRbhpBncHN6ws/htP3lXUdhYT/6khnuI2NUoJ/uoTygredWXGnjXe0z4hklFrB0BDfgvQgCXXyypIqtldPITIWrYX6uOVL6RyZt+sCZmZ00I+cMnCBkYrYFlljAC5P3vMQ5BlZanMBXaUqc9482xTjB5Zag3bqFjlIwrzPNzU6vWO2tj/nBHAuMpvrCEWuBMYAwU5o2DzHjIHHHVtbvQYmJkXMXat1oGwCpLP+dJ48H6v4cdU/vB4Mev0ntkU9/fB+wivysjffMIgdIzCn+pHS2F6oKWIBZIhQNb+t/x/DLx8SyDMKe8nwWWC97bCVrm6otyiPOsc2iq2dNZA170YuIeg1IAEo7g+tONQ/uXzNY77MbK/EJ4XnRIeE9+bwlyK6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG91OXFFVlFrNzFjUVM5NkNkUGdCdUt4aGVTcEZ5ZHQ1alk2L1JFTjNKTDF2?=
 =?utf-8?B?NDJnTXMxL0tVU0FRN2xBNWJlbEJBdSs2NlhqN3lLMW1kQ1R4anppRG03MnFB?=
 =?utf-8?B?eUwxQ2t2K3dPK3BGSmkxOWtCd2JBTitxblJKa1JSVHorU0J4L1N1TkdsRk1X?=
 =?utf-8?B?OEI2Wm5YV2dOWndBcDRyZUw5cjlPM2dzZnRnL1ZxaTFtZVVSanQ0ZjJVdmtl?=
 =?utf-8?B?aURmWDhMNDArcm85OXZVU0xRdWJMY0pmSEFjY3d1UkRBd05zMktSNlFsQmt4?=
 =?utf-8?B?YmFKbTNBQzl0Z2ZEVWdGbUxlOUc1ckQxWmt6YmplcGtMdkNhRk1KM3NjN2dF?=
 =?utf-8?B?ZDI1alZsSVpKMkdKT3lSUEx6WUV3VUNkZnJHdEd6bjJ6cVgxVEg3QWlaejVp?=
 =?utf-8?B?WFh4NFUwaXRZaTJxVjNDcldaSW5tRVFJSEw1aUR0a3ptMEw4dTlMRzh1NVc5?=
 =?utf-8?B?aDdBQkhlNTgrbDJWbVVKVEwvT1A3aW9sN0pVdmJ3SGg1ZmlUTXJ3L1FuTGdC?=
 =?utf-8?B?dkRrdDM3ajJJV3BRZ055ZUxCQm5ZK1R1UjhoQWQ5UVZscWVyUTQrbldQc0VP?=
 =?utf-8?B?RXZQckp0dDh2RFd2enk3ZU5Gc2FLd0NCbjZzZXJZK1FSNkp6amlaWCtmTG5t?=
 =?utf-8?B?cUFVd2p2eElHV3lVRngwaTIraHY0L0JRV2RIU0ZDZnJqdmRPSEdmWEFuV2FO?=
 =?utf-8?B?RHBHVStkSWI0S1czcG90RkJBbmdVcC9sQ3FJQ0UxK3ZSTlQ2aFZ5bE1KeHRt?=
 =?utf-8?B?OHYydVJ5ZFBUQjl6VWhEeldZbjd4ajBBcXJta3hLL21uU3ZoU2c4NXFIb1dW?=
 =?utf-8?B?T1dqdUJVU09ESDFWaEFaeWFzWkl3aTZXTUUzK1pJcno3ZytsSU50bHVJMmpn?=
 =?utf-8?B?WWJzdUV1YkMzYzh6SGw4K2piZFo3cSt0VnlJUW1NODBjNkZBalpHalkxNVZJ?=
 =?utf-8?B?ay84eDhLaUw0RCs5SmJRTWpJdDJ3RHd0dVZVT1cyUVc5cS94QW5abXppU003?=
 =?utf-8?B?YjZaUVI3bi9Bbi9DdCt3akRJVGFzc3BzYUgvZzVpa2ZOTTduT1VOc0ZDU1lB?=
 =?utf-8?B?bEtnYXNtUVdiWUl0MUtibHVIQUdrRExOYXUrdE1yNFJDSTdkZEZXL1lvMzV2?=
 =?utf-8?B?L2hTNDRoeDl2ejZBYnJMOGdzWlFYK2ttc2padjJaRWVHWHp1Vk52L1Bhd1VU?=
 =?utf-8?B?VzRoVndySW5DVFFFbkFPejlaTFBNQzAvMm1IUVRndHMzdkNiRlBEQmhUZnU1?=
 =?utf-8?B?TFdxZ0JNWEI4TGlSaEl1L1pYWlFmWVpDOUFtU0RBYmIwVmI5ZDhLdE5pbkRx?=
 =?utf-8?B?MVR6b0N6ZmxVMmlYNTAvekRJTWxNYXdBbjR2eVEva3RTNmM4eHE3Q2tsQlcw?=
 =?utf-8?B?N0RBeVM0OHZIT0VoMDdUeGU1TEpwOXpZWEFrcUdER1BTQTJBZEtUVTBGTmhy?=
 =?utf-8?B?b3hpeEdGVW1rTlB1ZTFrNW5zSlZOVlgrSGwyVzNmeXJUWHVETjRuMnAwai9V?=
 =?utf-8?B?Wk1CaGRrK2pUZFFreHArdHdReEpMZjYrYTFGakZWUUswdnE1M3dwMlBscXJK?=
 =?utf-8?B?Q0FvanZTbm90SGpYLzNzTmNOKzAwR3A4V2hYU3NiOGZBRDk5bWVMc0lWUkti?=
 =?utf-8?B?Y1I4Y2hiUVF1RTJ4UjRXRWd3T0habHpYU0FVUE1DV0lEN1VySENxMytzdUFv?=
 =?utf-8?B?dDE3cGY1dEZkeXhTNkp5ZzNueThqc1orRU9LTWVSMnl4UU5OWlpLSHp4UzhF?=
 =?utf-8?B?Tm5KUWwzYkpzK2Yra3daZjJTMmNsd3hUVGV6Z2pKMjdtNk53MFkzam9oaElX?=
 =?utf-8?B?WG5qeFVJWGZMMnBtTlMrRmVxOFFRRHM2OHF3Z0s2SFVNcDFKWXZKWWk1cVhW?=
 =?utf-8?B?WFdBMHhqVWdxcHE0QmRZRHJoUWNsOWtvZnh4L1U4Nld3NlZJVS9YeE1KZm85?=
 =?utf-8?B?cHZjOVdmM3RzYmUyTURvQUoxdzllanNZUDVPckVwaEZPRzVBMktQenYwUTdV?=
 =?utf-8?B?cERpK2taZzMzb3o4d0o2SFZwNDAvMnBzdDFiNGI1aTEzVFQ5QXljQVliM1ho?=
 =?utf-8?B?ajV1RTFqNWg2T1lnME5WNktNS2hGaGtmeEgwKzhpaTZKWlZ3M1YzTmdUL2lO?=
 =?utf-8?Q?Kczu03zK0Oq7ibNnlLTfZe8HM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1baa08-c3e5-41c9-8d05-08dc331b85eb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 20:27:28.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLckg2ZlIqN3ZxGzmiZeJmhNH/JXaqrO+m5u7bnECneWsjq2Yd3A85bojrKh3YBmlF/ovI9w1JoyCEY+yubsXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685

Thanks for taking a look Dan, responses inline.

On 2/21/24 12:18 AM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Change the EINJ module to install a platform device/driver on module
>> init and move the module init() and exit() functions to driver probe and
>> remove. This change allows the EINJ module to load regardless of whether
>> setting up EINJ succeeds, which allows dependent modules to still load
>> (i.e. the CXL core).
>>
>> Since EINJ may no longer be initialized when the module loads, any
>> functions that are called from dependent/external modules should check
>> the einj_initialized variable before calling any EINJ functions.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/acpi/apei/einj.c | 46 +++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 89fb9331c611..6ea323b9d8ef 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/nmi.h>
>>  #include <linux/delay.h>
>>  #include <linux/mm.h>
>> +#include <linux/platform_device.h>
>>  #include <asm/unaligned.h>
>>  
>>  #include "apei-internal.h"
>> @@ -137,6 +138,11 @@ static struct apei_exec_ins_type einj_ins_type[] = {
>>   */
>>  static DEFINE_MUTEX(einj_mutex);
>>  
>> +/*
>> + * Exported APIs use this flag to exit early if einj_probe() failed.
>> + */
>> +static bool einj_initialized __ro_after_init;
>> +
>>  static void *einj_param;
>>  
>>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>> @@ -703,7 +709,7 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>>  	return 0;
>>  }
>>  
>> -static int __init einj_init(void)
>> +static int __init einj_probe(struct platform_device *pdev)
>>  {
>>  	int rc;
>>  	acpi_status status;
>> @@ -717,7 +723,7 @@ static int __init einj_init(void)
>>  	status = acpi_get_table(ACPI_SIG_EINJ, 0,
>>  				(struct acpi_table_header **)&einj_tab);
>>  	if (status == AE_NOT_FOUND) {
>> -		pr_warn("EINJ table not found.\n");
>> +		pr_info("EINJ table not found.\n");
> 
> Per comment on cover letter this should be pr_debug() to hide it given
> that this module is no longer only loaded manually.
> 

Alright sounds good.

>>  		return -ENODEV;
>>  	} else if (ACPI_FAILURE(status)) {
>>  		pr_err("Failed to get EINJ table: %s\n",
>> @@ -805,7 +811,7 @@ static int __init einj_init(void)
>>  	return rc;
>>  }
>>  
>> -static void __exit einj_exit(void)
>> +static void __exit einj_remove(struct platform_device *pdev)
>>  {
>>  	struct apei_exec_context ctx;
>>  
>> @@ -826,6 +832,40 @@ static void __exit einj_exit(void)
>>  	acpi_put_table((struct acpi_table_header *)einj_tab);
>>  }
>>  
>> +static struct platform_device *einj_dev;
>> +struct platform_driver einj_driver = {
> 
> This can be static.
> 

Will change.

>> +	.remove_new = einj_remove,
>> +	.driver = {
>> +		.name = "acpi-einj",
>> +	},
>> +};
>> +
>> +static int __init einj_init(void)
>> +{
>> +	struct platform_device_info einj_dev_info = {
>> +		.name = "acpi-einj",
>> +		.id = -1,
>> +	};
>> +	int rc;
>> +
>> +	einj_dev = platform_device_register_full(&einj_dev_info);
>> +	if (IS_ERR_OR_NULL(einj_dev))
> 
> Given that platform_device_register_full() never returns NULL, this
> should be IS_ERR().
> 

Sure thing.

>> +		return PTR_ERR(einj_dev);
>> +
>> +	rc = platform_driver_probe(&einj_driver, einj_probe);
>> +	einj_initialized = rc == 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit einj_exit(void)
>> +{
>> +	if (einj_initialized)
>> +		platform_driver_unregister(&einj_driver);
>> +
>> +	platform_device_del(einj_dev);
>> +}
>> +
>>  module_init(einj_init);
>>  module_exit(einj_exit);
>>  
>> -- 
>> 2.34.1
>>
> 
> 

