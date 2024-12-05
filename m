Return-Path: <linux-acpi+bounces-9960-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601FE9E5FBA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAED16C150
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 20:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F2B1B87D0;
	Thu,  5 Dec 2024 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3kZQbGiK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044B1B6D02;
	Thu,  5 Dec 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733431786; cv=fail; b=dAKysmtalMkILHEUhDWp6wFH4z5Y3j6ld7CRkkBVrz+DwIHLVZXUsJRv6zR5MD1zQ+tXZb2FyFsMTHbaaZqfnZOKJL2XUX1GjYRjbFU2R6W4TKJWlBg57t887QL/BpjjdtcMEz9/Qf0RFnEryS5YI/NoFNdmZ0+qDvbtk/Nk9ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733431786; c=relaxed/simple;
	bh=PFwi0W2Pvi0aTFQykr1/ewi02fK/Byx8dvsx6oDvNhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u3r87Iosvo3tFYLfDzeKnOt/A6dC31AxeqWi4LDuyTKEttWnm6b6R2eNaAzFPViPr51vio2fJ9whLpSUDMZ6Z2GlPE2O12G4zRI0O59XO1vmnZx1K2HXAzfbGl7lYeyIPTeqQ4tGIYrJHQ6shgP3hnA9TTzOT+Ta41wyZu1vdVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3kZQbGiK; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heyG+CQfYQ3jVLYGf18XZ6z4eK5POExv9CzHxH097VXwK2TQeo9/dyNYPGneeS0dQY/y7dxz6arAmD5K9N6KdvelVw87uDFF5wg3FHFu9+SYNpxBSvlARcFWSUywtaX4IHlsXjrIdiUUvXLWE0Fn0Bcf/Pl33ZfyAIEWEK5DhHjByxTZ1r3hV9gxiiTFiJucDlqXBJte+tXMI3pEaOhBRdz99yAb/Wfzfz+WJxVu+S6lXmgEFfqRZKPTYee8nQHYodl2+VsBXtZ4EtipB9HDUE4gc93M5UzOIPWlNyE6uCsJTjfiyQfJAO5mgo95OkiWWjP1UoIZvwCfsEuY0dAoiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oq74//hu6lmUd9isYSuyOsexQ6x8BZCWdccvcwf0Vhs=;
 b=x1uioLgvBvaqI2IFS2iL4emAUNn9GNEcEIsPY5uMXCYbBvj6Fn4qfHVZJeZ02sPQxwx++j+9uT1RD/YbnxpPdRs7QppuHbMn1e1xrnB/21tg2GXpt0IqF8cmhBeSn5A6vrRNp1W0+NcAzJjHtgC7pwWJ6lfbypaDT/D8jknEH2Zz/lH+y80xFzEbZNiFcmbM0klhyAFi7B3gQzoKeXVoXlOjVIQMNnDdfpB1RWL9fACRprXjV2JNozAiEXhbY3xi+BnXxXVHXkCpKj9l9mPSlIeQpj6ghU+Nw+7D3zdzwwzIaHvszZzUd+9olUT+t2uCKFaDzZTicArPf6EsoU/MeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq74//hu6lmUd9isYSuyOsexQ6x8BZCWdccvcwf0Vhs=;
 b=3kZQbGiK1Wc8Y3ottcy4IHbKRIjNamtTXa0UD6gyJpv5OZSw7mGxpX5hssBlIPrqTZVNa157glirGW8AwYQOtGXr7UqKAx06KFcxFEcpeQ3cY7sNgdTN5D/ldYtfcOsueyZLnVCTBLh6/FsLX2X18hybl8rNh1ztJW2BZdXz4r4=
Received: from SJ0PR03CA0265.namprd03.prod.outlook.com (2603:10b6:a03:3a0::30)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 20:49:40 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::6d) by SJ0PR03CA0265.outlook.office365.com
 (2603:10b6:a03:3a0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Thu,
 5 Dec 2024 20:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 20:49:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 14:49:38 -0600
Received: from [172.25.146.163] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Dec 2024 14:49:37 -0600
Message-ID: <4227f19d-f065-4563-b48b-538aafe52ed9@amd.com>
Date: Thu, 5 Dec 2024 15:49:37 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] acpi/cppc: extract _cpc entry parsing logic
To: Penny Zheng <Penny.Zheng@amd.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>
CC: Ray Huang <Ray.Huang@amd.com>, Xenia Ragiadakou
	<Xenia.Ragiadakou@amd.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20241205054252.471761-1-Penny.Zheng@amd.com>
 <20241205054252.471761-3-Penny.Zheng@amd.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20241205054252.471761-3-Penny.Zheng@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1d4c96-c0ea-4b10-41a4-08dd156e5696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzJoT3dERnd0SFNkSlduSDVHbm85NG5jOXJPMk4yb3A3Tnhubmg5a09VZkVH?=
 =?utf-8?B?NjRNWDFTZWM3MGJ5TWh6Y3NLVlNNeS83NUtiOFpFT1I5VEpsZStHRW9ZdnJF?=
 =?utf-8?B?dWlDMFpobUc3RTNDbFFLY21US0xrOUhHTFVUY3NXVnVHU0luV1h5cFJNOVpl?=
 =?utf-8?B?bFVKMFNYUEI3LzJMMG9KU2dmNVBwQUFPaWtTL1BxMXVBekpyVTZScEYzTEdX?=
 =?utf-8?B?cGtnSDNsVU5FOE9URXBLQm1OeW1hWDFIUTVBWVZ2WVBPMklWYThLUFozNGhq?=
 =?utf-8?B?NUlQbGlubDVlZ0pHUkplTzQ0bGtaYVI1eTIyZTJPZndKbWI0cnJUWnp5MVU3?=
 =?utf-8?B?TzdmcGNxWmcxdVNZcUZVYmZ1bHRUVEdMZnQ0SEViUzNZZnI0UDdnOFhTbW05?=
 =?utf-8?B?NG8xeFBVK1dpLzVFM3hVdTJ0OEhETER6OVRsQmRZbFFnOHkvaEdWb2hmT05V?=
 =?utf-8?B?OVk1OVRLSkpGVzZJejQzc0pwczcxd0tsRzd2S2JrTEtGV1lmM2ZjZmtiYTBF?=
 =?utf-8?B?NlRyRTFXZU5Mc2czb0ZCSTRWMndDcFRjbXNBS3dWUnNtWXJUVnBwZVlYalhM?=
 =?utf-8?B?UGVJWXROK3I2NkROdlpUQ0FXT1pqVXVrVU5NbjA5QWNXN1p0YldSQ0w5Y0tR?=
 =?utf-8?B?b1l4dGVnUFBwaWZnZ3ZjT2pxVzJxYlV4bXRVbk5ROHc3ZEJ4SVF1YU0xLzU1?=
 =?utf-8?B?SS9PdEx4MmY4NEJEZndjTG9GWFdFMExEZTNYN0dBeUhndU4xWXhDK29QUmlL?=
 =?utf-8?B?UmRlSlNSZzBjbG1rckgrRWVGdUhKclJmRFM4ek5ORTdZVEVTU08xdUtybzl2?=
 =?utf-8?B?Q3RSbDFBcCtkN09jTHJmby9EdWh4ckdNOXN4dnJ5QzZjQzN4UU9VV2tIQzBY?=
 =?utf-8?B?a3diaW5uaWMxeGVqRVc2aTlRYTVUd0dxUVViOHRoaTVCUFhBT3B5NHdtR2FZ?=
 =?utf-8?B?Q3RrTEFkV0RQRWNmd1hJMG9iZGZOQnZYYlNYY3VIbm0wcVM3QmduYXlTN0E4?=
 =?utf-8?B?N25sMmpsRkxRTTU4Y2lKQlNGa1hzV252dHpHS055MW91R2lRc3poYzVGNDRj?=
 =?utf-8?B?dWFnUWpjeXhydm9qTVpXM290SHhnb1NHTVRlTFBDNVFaRjdPZUxBT3RpdnFw?=
 =?utf-8?B?M2NlbWJobXVpeTdVb1lGamNvUk9KNmxLajRTSmlGa3pGcmhZdUpiQjB3QUJo?=
 =?utf-8?B?blBDaVRnWDlCL0ZSa2FRQXNSR3VORGNUekpYbHEzQmY3VGdyYmU4QnhTdEFU?=
 =?utf-8?B?dExLRGQ0NnZYb012ZksxRFozWnd0QWduSW5oNWVPYXl1K1Byd3JMYmNsUElQ?=
 =?utf-8?B?Y0h3aSt5Vk11dk0xcmhHTWZ4RkF3TU9TelBWVnZGTEZXMjJoeFo4QzI1Q0ls?=
 =?utf-8?B?S1BWU3U3a0Q1Qm5GbUFwaDBNM0FZczZUYjVPS2FtZVl0aFBIemVEUmpJL1FB?=
 =?utf-8?B?OElScWF5N3cyZ2NTRkoraFJaOXNrWWZ0L0ZTLzFTREMwSTJrYW5YRnRlN2RZ?=
 =?utf-8?B?cDFPeUU1cG9LM3ArMXNwa1BtUHl1WlFLdE1kekhzYk9VZ0dLSU1PTENzTjRZ?=
 =?utf-8?B?ZHErTWt1QnJ6TlJZWnNPdWFDczI0bWloRC9sRzJ2WEVuMVR3QmM3MHlzZVJs?=
 =?utf-8?B?c0NySzlZNFVaZnZ2amhpZ0FFdDE3Uk5zSGxERWcxek11SkZ6dXJuR2JJbUsv?=
 =?utf-8?B?V0NVNDVnRHNTNVkwWGNuVlRVNm1MVmUweHBUTVBSa3F2UzlMN1Rqam95VFA4?=
 =?utf-8?B?dTF5WTM5cUFGOHJsZ1RyV0hoV1BXUkdwR2xpUGpua1l6WUYvUUZMeno4VnBy?=
 =?utf-8?B?TGsvNWVuMUNQS2dqUU5GRUR4T3RWb3BkeWlXTHlVOGhSNW5xRE80Qk9rbVow?=
 =?utf-8?B?di9qNjk2eHR4TXRMOWhLeVltTW5jblY5a1Z6alBSSVVEbTR1VVN1M3p5NlIy?=
 =?utf-8?Q?VvhMefGIbE+gOSfAsJarJ49TCN7pzzqM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 20:49:39.8189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1d4c96-c0ea-4b10-41a4-08dd156e5696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978

Adding Rafael and Len, since the patch touches drivers/acpi/.

On 2024-12-05 00:42, Penny Zheng wrote:
> When running as Xen dom0 PVH guest, MADT table is customized
> and may have the "wrong" UID processor number, which is
> inconsistent with the UID in Processor entry in native DSDT.
> 
> As a result, during ACPI boot-up for dom0, linux fails to set
> up proper processor logical id <-> physical id map(acpi_map_cpuid).
> Furthermore, It leads to that some ACPI processor feature data,
> like per-cpu cpc_desc structure, failed to be correctly stored.
> 
> In order to re-parse _CPC entry later for delivering correct data
> in performance hypercall, firstly, we extract parsing logic from
> acpi_cppc_processor_probe() and export it as a new function
> acpi_cppc_processor_parse().
> 
> Also, replace logical processor id with ACPI ID, to show correct print
> info in Xen dom0 PVH guest.
> 
> Signed-off-by: Penny Zheng <Penny.Zheng@amd.com>

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>

No further comments by me - leaving untrimmed for Rafael and Len.

Regards,
Jason

> ---
>   drivers/acpi/cppc_acpi.c | 93 +++++++++++++++++++++++-----------------
>   1 file changed, 53 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c3fc2c05d868..13d6ff84a1e9 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -675,19 +675,11 @@ static int pcc_data_alloc(int pcc_ss_id)
>   static inline void arch_init_invariance_cppc(void) { }
>   #endif
>   
> -/**
> - * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
> - * @pr: Ptr to acpi_processor containing this CPU's logical ID.
> - *
> - *	Return: 0 for success or negative value for err.
> - */
> -int acpi_cppc_processor_probe(struct acpi_processor *pr)
> +static int acpi_cppc_processor_parse(struct acpi_processor *pr, struct cpc_desc *cpc_ptr)
>   {
>   	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
>   	union acpi_object *out_obj, *cpc_obj;
> -	struct cpc_desc *cpc_ptr;
>   	struct cpc_reg *gas_t;
> -	struct device *cpu_dev;
>   	acpi_handle handle = pr->handle;
>   	unsigned int num_ent, i, cpc_rev;
>   	int pcc_subspace_id = -1;
> @@ -706,31 +698,24 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   	status = acpi_evaluate_object_typed(handle, "_CPC", NULL, &output,
>   			ACPI_TYPE_PACKAGE);
>   	if (ACPI_FAILURE(status)) {
> -		ret = -ENODEV;
> -		goto out_buf_free;
> +		return -ENODEV;
>   	}
>   
>   	out_obj = (union acpi_object *) output.pointer;
>   
> -	cpc_ptr = kzalloc(sizeof(struct cpc_desc), GFP_KERNEL);
> -	if (!cpc_ptr) {
> -		ret = -ENOMEM;
> -		goto out_buf_free;
> -	}
> -
>   	/* First entry is NumEntries. */
>   	cpc_obj = &out_obj->package.elements[0];
>   	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
>   		num_ent = cpc_obj->integer.value;
>   		if (num_ent <= 1) {
>   			pr_debug("Unexpected _CPC NumEntries value (%d) for CPU:%d\n",
> -				 num_ent, pr->id);
> -			goto out_free;
> +				 num_ent, pr->acpi_id);
> +			goto out_pointer;
>   		}
>   	} else {
>   		pr_debug("Unexpected _CPC NumEntries entry type (%d) for CPU:%d\n",
> -			 cpc_obj->type, pr->id);
> -		goto out_free;
> +			 cpc_obj->type, pr->acpi_id);
> +		goto out_pointer;
>   	}
>   
>   	/* Second entry should be revision. */
> @@ -739,14 +724,14 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   		cpc_rev = cpc_obj->integer.value;
>   	} else {
>   		pr_debug("Unexpected _CPC Revision entry type (%d) for CPU:%d\n",
> -			 cpc_obj->type, pr->id);
> -		goto out_free;
> +			 cpc_obj->type, pr->acpi_id);
> +		goto out_pointer;
>   	}
>   
>   	if (cpc_rev < CPPC_V2_REV) {
>   		pr_debug("Unsupported _CPC Revision (%d) for CPU:%d\n", cpc_rev,
> -			 pr->id);
> -		goto out_free;
> +			 pr->acpi_id);
> +		goto out_pointer;
>   	}
>   
>   	/*
> @@ -758,8 +743,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   	    (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
>   	    (cpc_rev > CPPC_V3_REV && num_ent <= CPPC_V3_NUM_ENT)) {
>   		pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
> -			 num_ent, pr->id);
> -		goto out_free;
> +			 num_ent, pr->acpi_id);
> +		goto out_pointer;
>   	}
>   	if (cpc_rev > CPPC_V3_REV) {
>   		num_ent = CPPC_V3_NUM_ENT;
> @@ -793,7 +778,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   						goto out_free;
>   				} else if (pcc_subspace_id != gas_t->access_width) {
>   					pr_debug("Mismatched PCC ids in _CPC for CPU:%d\n",
> -						 pr->id);
> +						 pr->acpi_id);
>   					goto out_free;
>   				}
>   			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> @@ -848,7 +833,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
>   		} else {
>   			pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
> -				 i, pr->id);
> +				 i, pr->acpi_id);
>   			goto out_free;
>   		}
>   	}
> @@ -864,6 +849,45 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   		cpc_ptr->cpc_regs[i].cpc_entry.int_value = 0;
>   	}
>   
> +	pr_debug("Parsed _CPC entry for CPU: %d\n", pr->acpi_id);
> +	kfree(output.pointer);
> +	return 0;
> +
> + out_free:
> +	/* Free all the mapped sys mem areas for this CPU */
> +	for (i = 2; i < cpc_ptr->num_entries; i++) {
> +		void __iomem *addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
> +
> +		if (addr)
> +			iounmap(addr);
> +	}
> + out_pointer:
> +	kfree(output.pointer);
> +	return ret;
> +}
> +
> +/**
> + * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
> + * @pr: Ptr to acpi_processor containing this CPU's logical ID.
> + *
> + *	Return: 0 for success or negative value for err.
> + */
> +int acpi_cppc_processor_probe(struct acpi_processor *pr)
> +{
> +	acpi_handle handle = pr->handle;
> +	struct cpc_desc *cpc_ptr;
> +	struct device *cpu_dev;
> +	int pcc_subspace_id = -1;
> +	int ret = -ENODATA;
> +
> +	cpc_ptr = kzalloc(sizeof(struct cpc_desc), GFP_KERNEL);
> +	if (!cpc_ptr)
> +		return -ENOMEM;
> +
> +	ret = acpi_cppc_processor_parse(pr, cpc_ptr);
> +	if (ret)
> +		goto out_free;
> +	pcc_subspace_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
>   
>   	/* Store CPU Logical ID */
>   	cpc_ptr->cpu_id = pr->id;
> @@ -907,21 +931,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   
>   	arch_init_invariance_cppc();
>   
> -	kfree(output.pointer);
>   	return 0;
>   
>   out_free:
> -	/* Free all the mapped sys mem areas for this CPU */
> -	for (i = 2; i < cpc_ptr->num_entries; i++) {
> -		void __iomem *addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
> -
> -		if (addr)
> -			iounmap(addr);
> -	}
>   	kfree(cpc_ptr);
> -
> -out_buf_free:
> -	kfree(output.pointer);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);


