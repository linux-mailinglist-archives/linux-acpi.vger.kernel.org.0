Return-Path: <linux-acpi+bounces-9973-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDB09E6057
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 23:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF47B166EB0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89E1C3054;
	Thu,  5 Dec 2024 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m3UBIRjr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2B282FB;
	Thu,  5 Dec 2024 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733436557; cv=fail; b=B2fBk4HpWZc013rkdxrdLsgUpDMBz4nOCgiN9iC//ReYHujI3G2bxFEPQAN6aacauJS+npQ7gL80QgEyUAgCGmBCug5RO3ufSF5QGDlkIxrCEfYUrj+xmZC7zYf2vJ6W4PhYAWBWE6FIJ6ixA0FPzPxetmgCgEvJVeN2DHcJ+vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733436557; c=relaxed/simple;
	bh=lrgiCV1S6NOgqbBArqrk8t/kfiq4JezkWNWZ7Rrq3K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ma+tkFhdErKmuELQ/1nufHoTyXaIaMCi4XgyFfQFZE93xB/Xuk+mg9AdkmubZnDhURphG/Vtq8pBEl4TUmGFvEat1+POGM3agld6D+GnkrFXhgP3egQrsxiqyJPHNth3s9CX1sqkYH3kPHjZ7vlUpjc17XZsip48YIYHzAGFhcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m3UBIRjr; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tqjkbz8yHYCzQzvgXV/qScrbsUj7/hHZ6wWMJ9EzcZSoko7zknAS8FxS1Hibjqjo8gimtdghN7AsyzAJd/LnhDbqZiN9szA5ch6MkdKWIX/ixJEvhg14cteOCCH61IMurTeDYSvr1hS9VRSWjZCsklr1BZjVclxhvXwf7J81UbB7Y+j26zFwQnALMIMS/bGSvLYiRH2ygHBKsBwddyc7W7xk7Z1H8Thv/ccsj7lewvA3Yw3wjJxtoHBjy5MmRIgebKtGvPMlbpXFjHdI2RbItYWsuL3WEfq2aftZdgp3RXZedOgtdUYSxNmWwRcx1QNoLLGkPEUfhgU3He5OUjdJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2oNJqsZFkdjC6f4t8Tnc11EcksGmoxUcgBJOkfzPoY=;
 b=VwmK2oTBr+vql5c2HtzRA1z20V/u44HikdiDCQ/9NK04iMV0TEPaWmwiAV0+tsjMcdryaqrQxg/T6K1ghnHJfK7WsX8LGe8rtPqxj1I+PL9Yobg1c6Ig/MMp+cGtSSB6SGGxumbhFHL8PolwGuG0w5SMeA+J7kuMueyeKY1xKOYd+20vCPFYsry4t5q1TOSDEqalDdjfVHkTbkU1oyFuBsw/kOu5QDDSHKblCpx8y77Di4yw+Q8FhYg9yWHGByKlUQHA2jXYqXrT8LnVAFWr5etSyNYN8BqFqUwWW3f9d9dVXOyguwHIvE8263ZR2ds1OnIvKryilgnWOgy82sVXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2oNJqsZFkdjC6f4t8Tnc11EcksGmoxUcgBJOkfzPoY=;
 b=m3UBIRjrhQLVRFdx1aAAt1Gx1R1+1MjUO7Bj64YrXJCs4ZujsX8yVk/Rmqsw1iYply5MSWOvQqvFdpUfYKDXaZCTJWYdmgMnMoBc4DVfDUf6dm1DeGn85IvGdDCQp5S5/AakNqdeIXsICVV/pBll89Pd8hRDl1vxGBICdm/NYNQ=
Received: from SJ0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:a03:33e::8)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 22:09:00 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ab) by SJ0PR03CA0033.outlook.office365.com
 (2603:10b6:a03:33e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Thu,
 5 Dec 2024 22:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:08:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:08:58 -0600
Received: from [172.25.146.163] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Dec 2024 16:08:57 -0600
Message-ID: <b9d5636c-0485-4a27-bf17-fd092b0b8ef9@amd.com>
Date: Thu, 5 Dec 2024 17:08:56 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] xen/cppc: introduce cppc data upload sub-hypercall
To: Penny Zheng <Penny.Zheng@amd.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>
CC: Ray Huang <Ray.Huang@amd.com>, Xenia Ragiadakou
	<Xenia.Ragiadakou@amd.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20241205054252.471761-1-Penny.Zheng@amd.com>
 <20241205054252.471761-5-Penny.Zheng@amd.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20241205054252.471761-5-Penny.Zheng@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b65e50-943e-4b44-3ac9-08dd15796b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkozUitXU2ZFVTg4Zit4V3B3ajJVNHNGZkJ2ZXJCR1VHRkV2dTlYK1h3UEdS?=
 =?utf-8?B?WmRmRnBnVi9hNlNuYjBBQWJIeDhleG03dlJnV29ZWnY4N2JsZlUvWitiNVda?=
 =?utf-8?B?Tys4VzJkUmxUVXNUTm5scGp5SG1UcGYwYTE3MkRFa1JaazdxVkQyYUZTUWJY?=
 =?utf-8?B?S2tmeUxiOGx1SmtISnh6bmY0Z1NIQnhSR1B2R0JWczBVSU9tNU5mR2h3UWFW?=
 =?utf-8?B?QzBtRmFDK0NWamxybGY4N0pvOVdqd0xQMExmMjBXWlREdklCSXRpTWdGN2tj?=
 =?utf-8?B?YTFKRkJvSndWOUdDdmJiV0RydDN4KzFiV29mM3VWNHlLK0xUTzFDVjI5VE9p?=
 =?utf-8?B?cFdPcVhrZkhJMXgzTnR0bndKQUkrU0RLN05vem81bVU3enVSS0VGZnhUSG15?=
 =?utf-8?B?c3VtR2tIZExHTWRlZ0Z4Qkh6OUg3UFd4MXFkTExBeXlEVGEzRVVuWm1mR09q?=
 =?utf-8?B?LzdBbE9GekpHV0JDUGJWWUlOMzUrRkJIWENuc242ZllsUlB4cjlpeXMySzdw?=
 =?utf-8?B?MlRqVnpZcDlsZjdnNC9lZ0JCQy9ZWGpabHdNVklYVk5WZ21uNnljem0vbGVU?=
 =?utf-8?B?N1BHQS83ZTJWSDJIa1htaXlBZG80dGlqRVl0RXAzbWJhR2ZTMUxaV1ltSmVS?=
 =?utf-8?B?L24ycmE2Z0x3OWRyUmw4bVpWN0NLZUtVdUNtWWxXc01kdUpVcXhJQmVUT3NC?=
 =?utf-8?B?ekdtR05ueEI2dFI5RzVyaysyT1BaMzhOMEJuRlkxS2ZmZjVvWm1kQTJjQjVF?=
 =?utf-8?B?a3ZkMElSTVFseTRSL0gzU2hYbXZiUE9hU0N2UjY5OXNTL0RlM1RFb3lQNzBs?=
 =?utf-8?B?QXd6V21OVjdFdUxDbitlSklQSzJBOWxnUEYwdGxCSXc5aUFQVlZFNm11NzRY?=
 =?utf-8?B?TnQxZkF6TjlIanhxTnBmYzJsV0UrdHJKd1BQSmpZTnhXSWVqZ3BGN3hub0tJ?=
 =?utf-8?B?R205ZktyZk5wYitHUS9LOWduc0VMZ1J0WVVHWkxvQ1oyYTh3V3dlQjIycjR4?=
 =?utf-8?B?RUFUNFZXQmhlTjJqdWdveTZWbTc1WklRVUE1emlLYlVGNVk0Wk5jYUVDL0M4?=
 =?utf-8?B?MFU0R3RsUCs1QisxMi96SE5adUswOUg5ZnpPWi9wdHB6RFlVRDB6ZG1JV1Fh?=
 =?utf-8?B?NjZCdHRVSXhjcTQzMTJHUDRrSThQd0gvem5vS1REWE1kbG9la2IveW1icXBV?=
 =?utf-8?B?d1lrNU5VMG1jQnpmR2pkZnZjMHEzQnZBRVM2Tm9LbUljRy9JdHNTZUFyR3Zm?=
 =?utf-8?B?L09YMWpja1pBb0xYbzJic0E0U1lWVVpPSkV5eTR0enZOd3dpM055RVBEa2hV?=
 =?utf-8?B?eHdDTElydFlzTFJqVWh0WHdIUEw1U2puU1d5SFYxcnA0b3NiT3A2YWZudlJp?=
 =?utf-8?B?SzdjTTd1aUlJOVgyeTdFWjUxZVFPMGxMdFlYYUZxQ2RqcXR1amtoOC9UMHFu?=
 =?utf-8?B?aWZLRy9JSUtnWnNMT2NGYUl3Y25lVXJmdnZtMllvVHF5ejRVMlBDZGxDbEM3?=
 =?utf-8?B?R1BwUHdxSHpNTCtqQVhIZ1VQOWdEYk5CendTbnpXcE5hK1F6Wnk5OGlzcUg3?=
 =?utf-8?B?TCtlRDlpYWUrN1NKUmZIZHoxdG12d1I0UUdXaDJYZFhLcjU1dkRVU0gzaXV3?=
 =?utf-8?B?cmZpTTRaVlB5Q28vU3pXVTVXTXROSyswZXFDQ2RXcS9pODJVZGdQRXlzSEFI?=
 =?utf-8?B?dkZjUjVsbHJGNitnUDBhVjlrQmtnL0d3N1NPUG55cWc3eDR0dDM5YkVZS1Jz?=
 =?utf-8?B?dGNoVTRxVGhKUXRGbytiOGNKbVliZENvZUxyUlZKLzMwMXYzNXQra3FVSm5r?=
 =?utf-8?B?SnZVaFJnb1ExcEU0UDZiS29aUmlkb2JGVlhtTzUvdjRuZEh2Vmd3ZHVxbkVv?=
 =?utf-8?B?bzFKWnJkME1xM0ZpbUhYNFpHd2JYVFRwN2RmczZNK0ZOSnNhZGFHUkZMMENy?=
 =?utf-8?Q?rh2YLT1jU4sm0Q1d54icIec5TccPTK/Z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:08:59.4388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b65e50-943e-4b44-3ac9-08dd15796b88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

Adding Rafael and Len. and again keeping the full patch.

On 2024-12-05 00:42, Penny Zheng wrote:
> As Xen is uncapable of parsing the ACPI dynamic table, this commit

s/uncapable/incapable/

> introduces a new sub-hypercall XEN_PM_CPPC to deliver CPPC perf
> caps data.
> 
> Signed-off-by: Penny Zheng <Penny.Zheng@amd.com>
> ---
>   drivers/acpi/cppc_acpi.c         |  1 +
>   drivers/xen/xen-acpi-processor.c | 89 +++++++++++++++++++++++++++++++-
>   include/acpi/processor.h         |  1 +
>   include/xen/interface/platform.h | 11 ++++
>   4 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3a436591da07..3570a52a5dbd 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -860,6 +860,7 @@ static int acpi_cppc_processor_parse(struct acpi_processor *pr, struct cpc_desc
>   		cpc_ptr->cpc_regs[i].cpc_entry.int_value = 0;
>   	}
>   
> +	pr->flags.has_cpc = 1;
>   	pr_debug("Parsed _CPC entry for CPU: %d\n", pr->acpi_id);
>   	kfree(output.pointer);
>   	return 0;
> diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
> index e9f38f171240..8a39e46c1ebc 100644
> --- a/drivers/xen/xen-acpi-processor.c
> +++ b/drivers/xen/xen-acpi-processor.c
> @@ -25,6 +25,7 @@
>   #include <xen/xen.h>
>   #include <xen/interface/platform.h>
>   #include <asm/xen/hypercall.h>
> +#include <acpi/cppc_acpi.h>
>   
>   static int no_hypercall;
>   MODULE_PARM_DESC(off, "Inhibit the hypercall.");
> @@ -45,8 +46,12 @@ static unsigned long *acpi_ids_done;
>   static unsigned long *acpi_id_present;
>   /* And if there is an _CST definition (or a PBLK) for the ACPI IDs */
>   static unsigned long *acpi_id_cst_present;
> +/* And if there is an _CPC entry for the ACPI IDs */
> +static unsigned long *acpi_id_cpc_present;
>   /* Which ACPI P-State dependencies for a enumerated processor */
>   static struct acpi_psd_package *acpi_psd;
> +/* ACPI CPPC structures for a enumerated processor */
> +static struct cppc_perf_caps *acpi_cppc_data;
>   
>   static bool pr_initialized;
>   
> @@ -208,6 +213,44 @@ static int xen_copy_pct_data(struct acpi_pct_register *pct,
>   	dst_pct->address = pct->address;
>   	return 0;
>   }
> +static int push_cppc_to_hypervisor(struct acpi_processor *_pr)
> +{
> +	int ret = 0;
> +	struct xen_platform_op op = {
> +		.cmd            = XENPF_set_processor_pminfo,
> +		.interface_version  = XENPF_INTERFACE_VERSION,
> +		.u.set_pminfo.id    = _pr->acpi_id,
> +		.u.set_pminfo.type  = XEN_PM_CPPC,
> +	};
> +	struct cppc_perf_caps *cppc_perf = acpi_cppc_data + _pr->acpi_id;
> +
> +	op.u.set_pminfo.cppc_data.highest_perf = cppc_perf->highest_perf;
> +	op.u.set_pminfo.cppc_data.lowest_perf = cppc_perf->lowest_perf;
> +	op.u.set_pminfo.cppc_data.nominal_perf = cppc_perf->nominal_perf;
> +	op.u.set_pminfo.cppc_data.lowest_nonlinear_perf = cppc_perf->lowest_nonlinear_perf;
> +	op.u.set_pminfo.cppc_data.lowest_freq = cppc_perf->lowest_freq;
> +	op.u.set_pminfo.cppc_data.nominal_freq = cppc_perf->nominal_freq;
> +
> +	if (!no_hypercall)
> +		ret = HYPERVISOR_platform_op(&op);
> +
> +	if (!ret) {
> +		pr_debug("ACPI CPU%u - CPPC uploaded.\n", _pr->acpi_id);
> +		pr_debug("     highest_perf: %d\n", cppc_perf->highest_perf);
> +		pr_debug("     lowest_perf: %d\n", cppc_perf->lowest_perf);
> +		pr_debug("     lowest_nonlinear_perf: %d\n", cppc_perf->lowest_nonlinear_perf);
> +		pr_debug("     nominal_perf: %d\n", cppc_perf->nominal_perf);
> +		pr_debug("     lowest_freq: %d Mhz\n", cppc_perf->lowest_freq);
> +		pr_debug("     nominal_freq: %d Mhz\n", cppc_perf->nominal_freq);
> +	} else if ((ret != -EINVAL) && (ret != -ENOSYS))
> +		/* EINVAL means the ACPI ID is incorrect - meaning the ACPI
> +		 * table is referencing a non-existing CPU - which can happen
> +		 * with broken ACPI tables. */
> +		pr_warn("(_CPC): Hypervisor error (%d) for ACPI CPU%u\n",
> +			ret, _pr->acpi_id);
> +
> +		return ret;
> +}
>   static int push_pxx_to_hypervisor(struct acpi_processor *_pr)
>   {
>   	int ret = 0;
> @@ -284,6 +327,9 @@ static int upload_pm_data(struct acpi_processor *_pr)
>   	if (_pr->flags.power)
>   		err = push_cxx_to_hypervisor(_pr);
>   
> +	if (_pr->flags.has_cpc)
> +		err |= push_cppc_to_hypervisor(_pr);
> +

Older hypervisors without the xen changes will return an error since 
they don't implement XEN_PM_CPPC.  We might want to ignore the return 
when it's EINVAL, the default for the XEN_PM_* switch, but that may 
ignore more than intended.

The two calls to upload_pm_data() ignore the return value, so maybe it 
doesn't matter.

(This is the end of my comments.)

Thanks,
Jason

>   	if (_pr->performance && _pr->performance->states)
>   		err |= push_pxx_to_hypervisor(_pr);
>   
> @@ -488,6 +534,7 @@ read_acpi_id(acpi_handle handle, u32 lvl, void *context, void **rv)
>   	union acpi_object object = { 0 };
>   	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
>   	struct acpi_buffer cst_buf = { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_buffer cpc_buf = { ACPI_ALLOCATE_BUFFER, NULL };
>   	acpi_io_address pblk = 0;
>   
>   	status = acpi_get_type(handle, &acpi_type);
> @@ -567,11 +614,20 @@ read_acpi_id(acpi_handle handle, u32 lvl, void *context, void **rv)
>   	/* .. and it has a C-state */
>   	__set_bit(acpi_id, acpi_id_cst_present);
>   
> +	status = acpi_evaluate_object(handle, "_CPC", NULL, &cpc_buf);
> +	if (ACPI_FAILURE(status)) {
> +		return AE_OK;
> +	}
> +	kfree(cpc_buf.pointer);
> +
> +	/* .. and it has a _CPC entry */
> +	__set_bit(acpi_id, acpi_id_cpc_present);
> +
>   	return AE_OK;
>   }
>   static int check_acpi_ids(struct acpi_processor *pr_backup)
>   {
> -	if (acpi_id_present && acpi_id_cst_present)
> +	if (acpi_id_present && acpi_id_cst_present && acpi_id_cpc_present)
>   		/* OK, done this once .. skip to uploading */
>   		goto upload;
>   
> @@ -588,11 +644,19 @@ static int check_acpi_ids(struct acpi_processor *pr_backup)
>   		return -ENOMEM;
>   	}
>   
> +	acpi_id_cpc_present = bitmap_zalloc(nr_acpi_bits, GFP_KERNEL);
> +	if (!acpi_id_cpc_present) {
> +		bitmap_free(acpi_id_present);
> +		bitmap_free(acpi_id_cst_present);
> +		return -ENOMEM;
> +	}
> +
>   	acpi_psd = kcalloc(nr_acpi_bits, sizeof(struct acpi_psd_package),
>   			   GFP_KERNEL);
>   	if (!acpi_psd) {
>   		bitmap_free(acpi_id_present);
>   		bitmap_free(acpi_id_cst_present);
> +		bitmap_free(acpi_id_cpc_present);
>   		return -ENOMEM;
>   	}
>   
> @@ -608,6 +672,12 @@ static int check_acpi_ids(struct acpi_processor *pr_backup)
>   			pr_backup->acpi_id = i;
>   			/* Mask out C-states if there are no _CST or PBLK */
>   			pr_backup->flags.power = test_bit(i, acpi_id_cst_present);
> +			/* Mask out relevant flag if there are no _CPC */
> +			pr_backup->flags.has_cpc = test_bit(i, acpi_id_cpc_present);
> +			if (pr_backup->flags.has_cpc) {
> +				if (xen_processor_get_perf_caps(pr_backup, acpi_cppc_data + i))
> +					return -EINVAL;
> +			}
>   			/* num_entries is non-zero if we evaluated _PSD */
>   			if (acpi_psd[i].num_entries) {
>   				memcpy(&pr_backup->performance->domain_info,
> @@ -726,6 +796,15 @@ static int __init xen_acpi_processor_init(void)
>   		bitmap_free(acpi_ids_done);
>   		return -ENOMEM;
>   	}
> +
> +	acpi_cppc_data = kcalloc(nr_acpi_bits, sizeof(struct cppc_perf_caps),
> +				GFP_KERNEL);
> +	if (!acpi_cppc_data) {
> +		pr_debug("Memory allocation error for acpi_cppc_data\n");
> +		rc = -ENOMEM;
> +		goto err1_out;
> +	}
> +
>   	for_each_possible_cpu(i) {
>   		if (!zalloc_cpumask_var_node(
>   			&per_cpu_ptr(acpi_perf_data, i)->shared_cpu_map,
> @@ -751,6 +830,11 @@ static int __init xen_acpi_processor_init(void)
>   		rc = acpi_processor_get_performance_info(pr);
>   		if (rc)
>   			goto err_out;
> +
> +		pr->flags.pcc_unsupported = true;
> +		rc = xen_processor_get_perf_caps(pr, acpi_cppc_data + i);
> +		if (rc)
> +			goto err_out;
>   	}
>   
>   	rc = xen_upload_processor_pm_data();
> @@ -766,6 +850,8 @@ static int __init xen_acpi_processor_init(void)
>   
>   err_out:
>   	/* Freeing a NULL pointer is OK: alloc_percpu zeroes. */
> +	kfree(acpi_cppc_data);
> +err1_out:
>   	free_acpi_perf_data();
>   	bitmap_free(acpi_ids_done);
>   	return rc;
> @@ -779,6 +865,7 @@ static void __exit xen_acpi_processor_exit(void)
>   	bitmap_free(acpi_id_present);
>   	bitmap_free(acpi_id_cst_present);
>   	kfree(acpi_psd);
> +	kfree(acpi_cppc_data);
>   	for_each_possible_cpu(i)
>   		acpi_processor_unregister_performance(i);
>   
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 18499cc11366..66492f5d68a8 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -214,6 +214,7 @@ struct acpi_processor_flags {
>   	u8 bm_control:1;
>   	u8 bm_check:1;
>   	u8 has_cst:1;
> +	u8 has_cpc:1;
>   	u8 pcc_unsupported:1;
>   	u8 has_lpi:1;
>   	u8 power_setup_done:1;
> diff --git a/include/xen/interface/platform.h b/include/xen/interface/platform.h
> index 79a443c65ea9..e11bb9443dc0 100644
> --- a/include/xen/interface/platform.h
> +++ b/include/xen/interface/platform.h
> @@ -319,6 +319,7 @@ DEFINE_GUEST_HANDLE_STRUCT(xenpf_getidletime_t);
>   #define XEN_PM_PX   1
>   #define XEN_PM_TX   2
>   #define XEN_PM_PDC  3
> +#define XEN_PM_CPPC 4
>   /* Px sub info type */
>   #define XEN_PX_PCT   1
>   #define XEN_PX_PSS   2
> @@ -384,6 +385,15 @@ struct xen_processor_px {
>   };
>   DEFINE_GUEST_HANDLE_STRUCT(xen_processor_px);
>   
> +struct xen_processor_cppc {
> +    uint32_t highest_perf;
> +    uint32_t nominal_perf;
> +    uint32_t lowest_perf;
> +    uint32_t lowest_nonlinear_perf;
> +    uint32_t lowest_freq;
> +    uint32_t nominal_freq;
> +};
> +
>   struct xen_psd_package {
>   	uint64_t num_entries;
>   	uint64_t revision;
> @@ -412,6 +422,7 @@ struct xenpf_set_processor_pminfo {
>   		struct xen_processor_power          power;/* Cx: _CST/_CSD */
>   		struct xen_processor_performance    perf; /* Px: _PPC/_PCT/_PSS/_PSD */
>   		GUEST_HANDLE(uint32_t)              pdc;
> +		struct xen_processor_cppc           cppc_data; /* _CPC */
>   	};
>   };
>   DEFINE_GUEST_HANDLE_STRUCT(xenpf_set_processor_pminfo);


