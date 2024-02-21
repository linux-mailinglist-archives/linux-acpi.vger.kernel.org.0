Return-Path: <linux-acpi+bounces-3799-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8D85E904
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 21:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDDE1C22FF2
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF3186ACA;
	Wed, 21 Feb 2024 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZvBTv3Do"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A82A8DA;
	Wed, 21 Feb 2024 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547263; cv=fail; b=GNo9NtW6opFdp6bzFRJrOTRwhxPiM2KiqkkEOAJagQ6Q9rCF1qZyo2oIgcj20VKIxpuNClrHDMzxWkG2PuG8wMr66785ae2G21WTWeBOAW3SiW+deMmUzDoeSA1zgsWcPplx+fGWl5U80P6viV0P8mnM+U/Pv213YDDFaUaZk+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547263; c=relaxed/simple;
	bh=65g0EVrE7BkOzgOhTB6qB/RDxKwTgiD++Mo8X8p7tns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A8qd8FcE8Sf/vaeLFa5cjYzsrJcebYV6KkJSQAoacppDu28vr6iXotUC0mL22pnuOb3TJniQR8D8g3ZIog/fjZgoABO8lAiiQsQcG6gL3N3vuf2+edpkQ9JUdjj00RJg/hYDIQpPHR0UHw36XohQWpnlkicbksJfzyKAh6YStPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZvBTv3Do; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D41k2vxXFR8Tev9iGx2L1kXf2+dTMOZUsgzWyIE4VfyUZTlSMrdjITHHZ7mfgPtOq95W8DSCnmDg9UsGyclSh6DHgPFIykH7jLT1tFI8BFzx42/43zCZ9oyLmst2Ws4t5g/pmVuuDrpTuinRWKxRROGojx49ZkqQz2shAu6GqPgAsBVdHwdFfqLH5I/ur+s2O5AF2w/By/ZJBrGmAudnlBqq0lFAOCmcnFVz6C4OVjx9KmqiOC6Yd/kWnTU0/U+Vci4KfULo2BudSDNDZQqD+BlviS1gyLEAxPz0rP/8o8678NFwlVWrB8zpDxQH/y5UU8nnD96dEp2zYBd0Jk37AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBrYR66w1RQwacxU2CFYPQYwPGaAjqYUkLNYt/9BtOg=;
 b=NBbqDQiwPjq2YV31/ZYVtIeRmhhAkpEkQrXcVcMqwilf0eF311U/Px0lqwsEwHgv6ymKA7YUFY6Fvi63TGW/E+hti2e2vG8dKjrQwsJuPmxBHR1Iy3XwCX/Wgse501VZ7h8+gXzEF8PgaYOcT3NlqD0tqAwmziQ8ETOa9saAsmqabty/klb1rIXGCr2l/daNAVOZS8TALpAk1tlxj9IKlI7v6q+Q1p8uWthXfclqDgS5NyScleiptx2vNgLhjfS5R24eL6i2AemdhrbuTRLCL5JHlH1ss9wy3UmhzjZiLg/mjJPOdAX1CeJKugYj4rbHhy5zzHNYiYidDRcSF3SyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBrYR66w1RQwacxU2CFYPQYwPGaAjqYUkLNYt/9BtOg=;
 b=ZvBTv3DoONbmb0uUCrTUWYj6FE19Xy2aHb4w8NxS+71BYH8umPXIVVe2Pv4QyPaunsBV+2xtLnirEO4JAQfAREFh+F+mxe8aLnMwTOKB6k59s6iDBXnSHYlbFzCMTmIcol3HwWMTR0labEHrbsQjoG9u7aJYkH1y1WZ4DCaHMQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 20:27:34 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 20:27:34 +0000
Message-ID: <5a650a49-8f80-4ade-8844-61f88172cecd@amd.com>
Date: Wed, 21 Feb 2024 14:27:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/4] EINJ: Add CXL error type support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-3-Benjamin.Cheatham@amd.com>
 <65d63647ecdb1_5e9bf294d6@dwillia2-xfh.jf.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65d63647ecdb1_5e9bf294d6@dwillia2-xfh.jf.intel.com.notmuch>
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
X-MS-Office365-Filtering-Correlation-Id: 5b49eb0d-c6e8-42fc-701d-08dc331b8939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jplcJmIsiLiM1K9QD+B2RtN5pw0ixZaEDmBsH4Luzv6fkH3UrS/0Au0qAs607SS5cCpxJkbM0keL05L1g5qh32KM8X4RGTdOLRA+jM7r8DX32kFYoCx5LztFfxn12x/80t2or9ZBCfcEeV5YJxE1zFDkZ/p+zFTWnSWzYiVEQeE2qMyI7eF07G0cUqzuUDmheaFNq+7dr6QMDPEq+LfFHyyPjs/kwt/fMErsTcuEPBwg508+ZqKRIKBkgu4QEW+JJ5YsM4j6s03RhA77++UyW0t20i+fv+blAvuKUlSGnmU4QjjNHJSSWvUwlQYgeHErrcNMhRNbD2Y2HsvZhOMgAJb8rmhODnbk7uyquIXHbGIbHCB5ltVwpcnZIwBwLRf2p2R6j/GN2wImemxPQ1Y6u6XtgeJ59DYNe5bLIgZuBQnS4erFnM2qNm9S+xIMhUmYczlLUejMK+/NLq93SJU8nDGaeSi/58zWIOAdahkf6i9p+xMiKKvWrNFI6bqWw3IE6UL4F58owTOjgleo+x1hb5X9XQvS8HJ+7QhX+O7I/Sg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFFQZEIySXN4K3Z3OHZFZnAxcTFBNVNvYXRRQUd1Q0ovVUU1N3VoNnY5UWtQ?=
 =?utf-8?B?VVpmeVV5UEs5TUhROWdxKzRQR1pJTlI1amQxdFU0SndQbGQyRFRTb2VsbFNE?=
 =?utf-8?B?clBRSmVBMUtaK3JqMHlTTzlvYnZxN0VWV0JTMHZWblNMZ3ZTakRNYXJDaWFQ?=
 =?utf-8?B?eWh5UHpFcTBYYktrQXJ1MjArbVVRbFNYMnBtN2JJV3VsU24wT2h3N1Vwbjdz?=
 =?utf-8?B?WEtENHZWeGs2MmFQUDdWL2E5Rk9DRGFOU0kyV2Y2N0pGbWRDNDJIbittZTQy?=
 =?utf-8?B?dFQzckdmRmFpK2JjQ3BzV2tDMkRQTDdDaThDbFlHaSthWjk2Q3Z6VHU4b2pO?=
 =?utf-8?B?dXhLN3M5RElGL29QcFAySDNVMmtZVFpQYitidEg3WHNoMXFBajcycVgweTY4?=
 =?utf-8?B?SjkrclhOcS9sV2ttalc5Q0x6QjJoR3IxcmNTMlZXQ0Y2am5PK1pxei9ZRHhl?=
 =?utf-8?B?N3duTzhpTGhuNUdaME9Ka2lvSE93VDlBWFJZaHB3bjRCc1hVODV5TWVhcElJ?=
 =?utf-8?B?L0tYSWRYcndieVJXTi9HOHJCSXk0UzR1ejhMeTltNEhkSFVYdXovVHFYR2w0?=
 =?utf-8?B?aUNOUFF4aldtTEh1b3RjWXEwZnV4OC95bS9mMUkyWHp4V2tKUFc0aVloTWZL?=
 =?utf-8?B?emZpOENmVisza2l4L2NOYzduVC91cVlEN05nRU56SUExS3BRdkV5T0FMNU0v?=
 =?utf-8?B?WHVySUxZcW8xdzNROHpxZVJIUjZ0ditzWEVxMld6eGsrU3FvVWVoNEVGOFRI?=
 =?utf-8?B?ODNCZzVaSm5UcmdzNlUxUkl4ZkZ0ZHljZzVhL3N3R2Z1MUtPeWdsUU5UZ2tE?=
 =?utf-8?B?RndiTmFxL3EzaUdRT0lTN253NWFOd3dkL2ZoL1RFOFBHRG5BN3Jsd1lFckFi?=
 =?utf-8?B?Z1JIR3RaMVA4dFFvVkNPOS9UQ1BCMDN1Z2ZLRXg3TWlFRWcrS0p6NlIyWCsr?=
 =?utf-8?B?bXZ5cnc4aG5MbUlSZGRVVnRuUCtpWnlENW9IWTVUcStCRE1rTzJjdzZkSFU0?=
 =?utf-8?B?eTA5OGI4VHg2MXJPckRJWGZHdnVnOTZscFZoUThsM2xkNFJYdGs3dGZqR1h6?=
 =?utf-8?B?eFhTRnRYMVVjd0pWdkZ5Skh6OUpzVTU3bHlreHZaZGNTZ3AxdTBnd3JqcjFG?=
 =?utf-8?B?M2tTR1IxUFdOb241ODhZUGVEMHRwYlA2NENWR01RZDRGU29QQnF5UFBwMW9U?=
 =?utf-8?B?alFVazF6SVNiclVNcGJhbWVIRUlxTnorZFZ1cHFIelFQWTdTY2lpaEo5M0hO?=
 =?utf-8?B?TVFZRkxueEh2NW8rYmJ3WHR0MXlzQW5YZ2x2R3VWRVM5blY2TkpFMlVpdVR1?=
 =?utf-8?B?amw4L1ZyZzdITlVWZlIyU1pwV2tWa1dFTDV0NGxISW9kKzM3ODVabU5EMGhZ?=
 =?utf-8?B?akNLdjh0SU1QSVJoMnowSms4dUxzL2JLZTJOMXh3NE1ydnNzQVdtNWJwUk1M?=
 =?utf-8?B?UlM2TjdESThnY2pPSy9pVDM4VnFGRVJybU1CZkpWQ0IzTUdoWDl5SXAzTzJN?=
 =?utf-8?B?R1E3TlExNEltenZQbDMrUmIycWpJZy92aWRDYmlMNTI1Vnp0eTVPNVZZQnp0?=
 =?utf-8?B?MkhXb0NLdTlseUtEaWZMdGhYTTI4K29iK29Hd09ENlAzdVNtS2t5aFdIM3pW?=
 =?utf-8?B?aHRRVGU1alhUdWEwL2JTVjloODVLRzFpb0xsVU5Nc1Q2aWVCTGhrTDZEL2g5?=
 =?utf-8?B?OHZoM1kyV2NYYXV1UXByWldIYVFIOWpvMDlZNEpsTSsrZmd2N3F4NThCK3NR?=
 =?utf-8?B?SzlMUDFYeE5rVHdZOCtVYTdpT0o3c2RHcHhSVjNYSC9GVmttOEwrOGJWZTVp?=
 =?utf-8?B?THUyUC9yM1ZEMU1TVllCNURVOEwyQ0tkaFNDQlpyWlkzOUZONlJtbXNjR3cw?=
 =?utf-8?B?MmhxRU1xdUYwWXBnNHVLOUhUUWdpWTU2ZjZWaU1IMjNpaUtyNGpoQ2NhL21H?=
 =?utf-8?B?aGYrREhNMkpsTHBmeS8yWGhDQ2dwcWhzdmNjMW9MQTBxSmJzVE9wK0xjQWpj?=
 =?utf-8?B?T2cwU3ZzWE0yTDgxS3hoY3REa05BMTErbjJnQ2RMZzRjbnl6bzZUSlp6cjF0?=
 =?utf-8?B?NjMyd2dxbUhOV2JuSnFPUDJOdTFSWEkzSXN1VGoxUnd3NFNUakRnMm94VnpI?=
 =?utf-8?Q?vO454kAd2PfYBDPKOnPUvz0ea?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b49eb0d-c6e8-42fc-701d-08dc331b8939
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 20:27:34.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwxca60CQhTVj/RLvf05JBT8o1wlGHFWhVl4yUI8D8muxi3EWKGTvJvp4RWdGMBUcJhQ32UrI0/JTj76V5xzJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685



On 2/21/24 11:43 AM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Remove CXL protocol error types from the EINJ module and move them to
>> a new einj_cxl module. The einj_cxl module implements the necessary
>> handling for CXL protocol error injection and exposes an API for the
>> CXL core to use said functionality. Because the CXL error types
>> require special handling, only allow them to be injected through the
>> einj_cxl module and return an error when attempting to inject through
>> "regular" EINJ.
> 
> So Robustness Principle says be conservative in what you send and
> liberal in what you accept. So cleaning up the reporting of CXL
> capabilities over to the new interface is consistent with that
> principle, but not removing the ability to inject via the legacy
> interface. Especially since that has been the status quo for a few
> kernel cycles is there a good reason to actively prevent usage of that
> path?
> 

For CXL 2.0+ ports it's fine since EINJ only expects an SBDF which is
pretty readily accessible by the user. CXL 1.1/1.0 ports however, it's a bit
of a headache. It would require the user to find the address of the RCRB
for the port and supply that to the EINJ module. I originally had this option
anyway, but I think it got shot down for being too obtuse to use (I think by
you, but it's been a while xD). If you think it's still worthwhile I can
remove the restriction for both types of ports or just the 2.0+ ports.

For CXL 1.0/1.1 ports there's also the security issue of being able to inject
to any address since the way it works is by skipping the memory address
checks, but since this is a debug module I don't think it's that big
of a deal.

>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  MAINTAINERS                       |   1 +
>>  drivers/acpi/apei/Kconfig         |  12 +++
>>  drivers/acpi/apei/Makefile        |   1 +
>>  drivers/acpi/apei/apei-internal.h |  17 +++++
>>  drivers/acpi/apei/einj-cxl.c      | 121 ++++++++++++++++++++++++++++++
>>  drivers/acpi/apei/einj.c          |  81 ++++++++++++++------
>>  include/linux/einj-cxl.h          |  40 ++++++++++
>>  7 files changed, 249 insertions(+), 24 deletions(-)
>>  create mode 100644 drivers/acpi/apei/einj-cxl.c
>>  create mode 100644 include/linux/einj-cxl.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 73d898383e51..51f9a0da57d7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5289,6 +5289,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>>  L:	linux-cxl@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/cxl/
>> +F:	include/linux/cxl-einj.h
>>  F:	include/linux/cxl-event.h
>>  F:	include/uapi/linux/cxl_mem.h
>>  F:	tools/testing/cxl/
>> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
>> index 6b18f8bc7be3..040a9b2de235 100644
>> --- a/drivers/acpi/apei/Kconfig
>> +++ b/drivers/acpi/apei/Kconfig
>> @@ -60,6 +60,18 @@ config ACPI_APEI_EINJ
>>  	  mainly used for debugging and testing the other parts of
>>  	  APEI and some other RAS features.
>>  
>> +config ACPI_APEI_EINJ_CXL
>> +	tristate "CXL Error INJection Support"
> 
> This should still be a boolean because it is add-on functionality to the
> cxl_core.ko module which has its own tristate configuration.
> 

I tried this but was running into issues, more about this in the Makefile
portion of the patch.

>> +	default ACPI_APEI_EINJ
>> +	depends on ACPI_APEI_EINJ
> 
> The dependency still needs to be:
> 
>     depends on ACPI_APEI_EINJ && CXL_BUS >= ACPI_APEI_EINJ
> 
> ...because CXL_BUS can not tolerate being built-in when ACPI_APEI_EINJ
> is not.
> 

Will do.

>> +	help
>> +	  Support for CXL protocol Error INJection through debugfs/cxl.
>> +	  Availability and which errors are supported is dependent on
>> +	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
>> +	  EINJ documentation for more information.
>> +
>> +	  If unsure say 'n'
>> +
>>  config ACPI_APEI_ERST_DEBUG
>>  	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
>>  	depends on ACPI_APEI
>> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
>> index 4dfac2128737..c18e96d342b2 100644
>> --- a/drivers/acpi/apei/Makefile
>> +++ b/drivers/acpi/apei/Makefile
>> @@ -2,6 +2,7 @@
>>  obj-$(CONFIG_ACPI_APEI)		+= apei.o
>>  obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
>>  obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
>> +obj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
> 
> No new module needed. It only needs another compilation unit optionally
> added to einj.ko. Something like this:
> 
> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
> index 4dfac2128737..2c474e6477e1 100644
> --- a/drivers/acpi/apei/Makefile
> +++ b/drivers/acpi/apei/Makefile
> @@ -2,6 +2,8 @@
>  obj-$(CONFIG_ACPI_APEI)                += apei.o
>  obj-$(CONFIG_ACPI_APEI_GHES)   += ghes.o
>  obj-$(CONFIG_ACPI_APEI_EINJ)   += einj.o
> +einj-y                         := einj-core.o
> +einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>  
>  apei-y := apei-base.o hest.o erst.o bert.o
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
> similarity index 100%
> rename from drivers/acpi/apei/einj.c
> rename to drivers/acpi/apei/einj-core.c
> 

And this is what was causing my issues. I couldn't CONFIG_ACPI_APEI_EINJ_CXL work
as a boolean because I didn't put it in the right compilation unit. This should
also allow me to remove the dependency in the next patch and the exports below.

>>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>>  
>>  apei-y := apei-base.o hest.o erst.o bert.o
>> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
>> index 67c2c3b959e1..336408f4f293 100644
>> --- a/drivers/acpi/apei/apei-internal.h
>> +++ b/drivers/acpi/apei/apei-internal.h
>> @@ -130,4 +130,21 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>>  }
>>  
>>  int apei_osc_setup(void);
>> +
>> +int einj_get_available_error_type(u32 *type);
>> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>> +		      u64 param4);
>> +bool einj_is_initialized(void);
>> +bool einj_is_cxl_error_type(u64 type);
>> +int einj_validate_error_type(u64 type);
>> +
>> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
>> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
>> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
>> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
>> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
>> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
>> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
>> +#endif
>> +
>>  #endif
>> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
>> new file mode 100644
>> index 000000000000..607d4f6adb98
>> --- /dev/null
>> +++ b/drivers/acpi/apei/einj-cxl.c
>> @@ -0,0 +1,121 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * CXL Error INJection support. Used by CXL core to inject
>> + * protocol errors into CXL ports.
>> + *
>> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
>> + */
>> +#include <linux/einj-cxl.h>
>> +#include <linux/debugfs.h>
>> +
>> +#include "apei-internal.h"
>> +
>> +static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
>> +	{ BIT(12), "CXL.cache Protocol Correctable" },
>> +	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
>> +	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
>> +	{ BIT(15), "CXL.mem Protocol Correctable" },
>> +	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
>> +	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
>> +};
>> +
>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>> +{
>> +	int cxl_err, rc;
>> +	u32 available_error_type = 0;
>> +
>> +	if (!einj_is_initialized())
>> +		return -ENXIO;
>> +
>> +	rc = einj_get_available_error_type(&available_error_type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
>> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
>> +
>> +		if (available_error_type & cxl_err)
>> +			seq_printf(m, "0x%08x\t%s\n",
>> +				   einj_cxl_error_type_string[pos].mask,
>> +				   einj_cxl_error_type_string[pos].str);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
>> +
>> +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
>> +{
>> +	struct pci_bus *pbus;
>> +	struct pci_host_bridge *bridge;
>> +	u64 seg = 0, bus;
>> +
>> +	pbus = dport_dev->bus;
>> +	bridge = pci_find_host_bridge(pbus);
>> +
>> +	if (!bridge)
>> +		return -ENODEV;
>> +
>> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
>> +		seg = bridge->domain_nr;
>> +
>> +	bus = pbus->number;
>> +	*sbdf = (seg << 24) | (bus << 16) | dport_dev->devfn;
>> +
>> +	return 0;
>> +}
>> +
>> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
>> +{
>> +	int rc;
>> +
>> +	if (!einj_is_initialized())
>> +		return -ENXIO;
>> +
>> +	/* Only CXL error types can be specified */
>> +	if (!einj_is_cxl_error_type(type))
>> +		return -EINVAL;
>> +
>> +	rc = einj_validate_error_type(type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return einj_error_inject(type, 0x2, rcrb, GENMASK_ULL(63, 12), 0, 0);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
>> +
>> +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
>> +{
>> +	u64 param4 = 0;
>> +	int rc;
>> +
>> +	if (!einj_is_initialized())
>> +		return -ENXIO;
>> +
>> +	/* Only CXL error types can be specified */
>> +	if (!einj_is_cxl_error_type(type))
>> +		return -EINVAL;
>> +
>> +	rc = einj_validate_error_type(type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_dport_get_sbdf(dport, &param4);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return einj_error_inject(type, 0x4, 0, 0, 0, param4);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
>> +
>> +bool einj_cxl_is_initialized(void)
>> +{
>> +	return einj_is_initialized();
>> +}
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_is_initialized, CXL);
>> +
>> +MODULE_AUTHOR("Ben Cheatham");
>> +MODULE_DESCRIPTION("CXL Error INJection support");
>> +MODULE_LICENSE("GPL");
> 
> These go away when cxl-einj.ko is no longer its own module.
> 
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 6ea323b9d8ef..e76e64df97a7 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -37,6 +37,12 @@
>>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_FATAL)
>> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
>> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
>> +				ACPI_EINJ_CXL_CACHE_FATAL | \
>> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
>> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
>> +				ACPI_EINJ_CXL_MEM_FATAL)
>>  
>>  /*
>>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>> @@ -166,7 +172,7 @@ static int __einj_get_available_error_type(u32 *type)
>>  }
>>  
>>  /* Get error injection capabilities of the platform */
>> -static int einj_get_available_error_type(u32 *type)
>> +int einj_get_available_error_type(u32 *type)
>>  {
>>  	int rc;
>>  
>> @@ -176,6 +182,7 @@ static int einj_get_available_error_type(u32 *type)
>>  
>>  	return rc;
>>  }
>> +EXPORT_SYMBOL_GPL(einj_get_available_error_type);
> 
> There should not be any need for new exports from the legacy einj.c.
> 
>>  
>>  static int einj_timedout(u64 *t)
>>  {
>> @@ -536,8 +543,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  }
>>  
>>  /* Inject the specified hardware error */
>> -static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>> -			     u64 param3, u64 param4)
>> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>> +		      u64 param4)
>>  {
>>  	int rc;
>>  	u64 base_addr, size;
>> @@ -560,8 +567,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  	if (type & ACPI5_VENDOR_BIT) {
>>  		if (vendor_flags != SETWA_FLAGS_MEM)
>>  			goto inject;
>> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
>> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>>  		goto inject;
>> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
>> +		goto inject;
>> +	}
>>  
>>  	/*
>>  	 * Disallow crazy address masks that give BIOS leeway to pick
>> @@ -592,6 +602,7 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  
>>  	return rc;
>>  }
>> +EXPORT_SYMBOL_GPL(einj_error_inject);
>>  
>>  static u32 error_type;
>>  static u32 error_flags;
>> @@ -613,12 +624,6 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>>  	{ BIT(9), "Platform Correctable" },
>>  	{ BIT(10), "Platform Uncorrectable non-fatal" },
>>  	{ BIT(11), "Platform Uncorrectable fatal"},
>> -	{ BIT(12), "CXL.cache Protocol Correctable" },
>> -	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
>> -	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
>> -	{ BIT(15), "CXL.mem Protocol Correctable" },
>> -	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
>> -	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
>>  	{ BIT(31), "Vendor Defined Error Types" },
>>  };
>>  
>> @@ -640,29 +645,21 @@ static int available_error_type_show(struct seq_file *m, void *v)
>>  
>>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>>  
>> -static int error_type_get(void *data, u64 *val)
>> -{
>> -	*val = error_type;
>> -
>> -	return 0;
>> -}
>> -
>> -static int error_type_set(void *data, u64 val)
>> +int einj_validate_error_type(u64 type)
>>  {
>> +	u32 tval, vendor, available_error_type = 0;
>>  	int rc;
>> -	u32 available_error_type = 0;
>> -	u32 tval, vendor;
>>  
>>  	/* Only low 32 bits for error type are valid */
>> -	if (val & GENMASK_ULL(63, 32))
>> +	if (type & GENMASK_ULL(63, 32))
>>  		return -EINVAL;
>>  
>>  	/*
>>  	 * Vendor defined types have 0x80000000 bit set, and
>>  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
>>  	 */
>> -	vendor = val & ACPI5_VENDOR_BIT;
>> -	tval = val & 0x7fffffff;
>> +	vendor = type & ACPI5_VENDOR_BIT;
>> +	tval = type & GENMASK(30, 0);
>>  
>>  	/* Only one error type can be specified */
>>  	if (tval & (tval - 1))
>> @@ -671,9 +668,39 @@ static int error_type_set(void *data, u64 val)
>>  		rc = einj_get_available_error_type(&available_error_type);
>>  		if (rc)
>>  			return rc;
>> -		if (!(val & available_error_type))
>> +		if (!(type & available_error_type))
>>  			return -EINVAL;
>>  	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(einj_validate_error_type);
>> +
>> +bool einj_is_cxl_error_type(u64 type)
>> +{
>> +	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
>> +}
>> +EXPORT_SYMBOL_GPL(einj_is_cxl_error_type);
>> +
>> +static int error_type_get(void *data, u64 *val)
>> +{
>> +	*val = error_type;
>> +
>> +	return 0;
>> +}
>> +
>> +static int error_type_set(void *data, u64 val)
>> +{
>> +	int rc;
>> +
>> +	/* CXL error types have to be injected from cxl debugfs */
>> +	if (einj_is_cxl_error_type(val))
>> +		return -EINVAL;
>> +
>> +	rc = einj_validate_error_type(val);
>> +	if (rc)
>> +		return rc;
>> +
>>  	error_type = val;
>>  
>>  	return 0;
>> @@ -709,6 +736,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>>  	return 0;
>>  }
>>  
>> +bool einj_is_initialized(void)
>> +{
>> +	return einj_initialized;
>> +}
>> +EXPORT_SYMBOL_GPL(einj_is_initialized);
> 
> The variable can be referenced directly as a global symbol.

