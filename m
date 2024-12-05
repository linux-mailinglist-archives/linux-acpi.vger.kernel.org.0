Return-Path: <linux-acpi+bounces-9962-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198959E5FD7
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8B8286619
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C591BC08B;
	Thu,  5 Dec 2024 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FOfA9yT+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71E5028C;
	Thu,  5 Dec 2024 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433106; cv=fail; b=VoHeNMAnqbLKWgRQZ5jAnQQw9uyAmbg9LtUtru0fWIBVZr6QoL42YILE89Ir1vUyPK15WPvJoYv65C2fauH6QBSujtzxWa8HWExkWjs8WGpTQ84I8QyoPymZnD5HN4tVggAcS8lSsya9ObOgTzkJFpynRy/CywjuRBupjCr+bRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433106; c=relaxed/simple;
	bh=BxTjAuADLK7V2mv2/WxMGpNeyWBVVkR4vAonohkVZ6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zn5cc3BAw1Uw5z2jc/NxzjkorFtQK8Ml51zN+J4NTrqHe4aWeoevXd+Jg/fifjFLuKoSYaojYqpaXqMl4nt6+7fq6A/pGf+VXbORsNCsXzw9XLMV76x8MGpKbEizosoTVlVHBDG+2rqHOFIRcDWNAj6QChsvwUbftsvzEUstRZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FOfA9yT+; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOG6tLHzr5nSIOzRQH+zyFsWmmbF0yM3p3HygoEXJ+FCFFJ7+EOiHF0o0H+/7DWswNSUBi9lX9gsghO8lqaoJRSN5E0PW5tKZEP0i1e6OrFKcIu3F243Oci3vy45j63QUae/1bsLh022v6Xlul631tgen6M0/KubtfgS16QRBBl3GU6dZmnd17jZkZ7NIQTern6e20YPcQdtvDLVO8cNFUVsX9b+/7pV37u2meRZKWV4EbZnlosKRuEoEl5BhdFJYsYNLX3aNjx2yXiO/9A+0VCcBloIeZQVtNfTSijgXq5K95lGbAV9ihtjkZ7OVAfPVnr6roTZY8xf8jXBA4PAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwNo/Z+AaJnqKbx3t2X1NFa9blJOGIv2GNPm6Ol7lv8=;
 b=ZJbBeolNvVgrfkkt7AtB6DxV0bVjEdeZkMBuzJI4QFPWSAQRKlqxUWY7ZLWjhya7krmIcnA01xMrLKTimFRWeJyGg9ajnRFY5qC34Qm8RkgAGJSOZGTk6Ektwdr7CEtsvwYyK4lkvEBJVrzQpS6iKMQBzQFO98R+JEMcMZOKtwr0Z3cL0xdmkojIVoCa57mX9NSGvhDhB9oLiIONq0k27Ku6DY++NcLnua9GkObehL9tPcKCwddEkjz+mGAdJ8gV0xuEpXZOHIQO31d3G4APLOqy7fb7ahRvZARliK6sbY95hfNnnmiSiBMm2LuF0VOmwwE7HfB8eU0BUAsUWWzaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwNo/Z+AaJnqKbx3t2X1NFa9blJOGIv2GNPm6Ol7lv8=;
 b=FOfA9yT+OOnGiUWHVQ5ia7kq6nPfwyHZ7YTsXnS4ulx1ZP+Lu7pVm1lIQYcowyVb+lTsxe+RL/YIVCRZZGvZJxGsgRefmsDH2B8+qnwMLseG5JEv2qs9UuDOhGxYNWAxuB9YoGJpDfl+m7iSFEOH0Ls8okL71hDK8GVmlde/jrU=
Received: from BN9PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:fb::19)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 21:11:38 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::47) by BN9PR03CA0044.outlook.office365.com
 (2603:10b6:408:fb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Thu,
 5 Dec 2024 21:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 21:11:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 15:11:37 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 15:11:37 -0600
Received: from [172.25.146.163] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Dec 2024 15:11:36 -0600
Message-ID: <81d0f983-eea5-477b-9e8c-7da572914335@amd.com>
Date: Thu, 5 Dec 2024 16:11:36 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] xen/cppc: get xen-required cppc perf caps data
To: Penny Zheng <Penny.Zheng@amd.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>
CC: Ray Huang <Ray.Huang@amd.com>, Xenia Ragiadakou
	<Xenia.Ragiadakou@amd.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20241205054252.471761-1-Penny.Zheng@amd.com>
 <20241205054252.471761-4-Penny.Zheng@amd.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20241205054252.471761-4-Penny.Zheng@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d477f3-baab-4374-3b28-08dd15716852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3BjdzUrRi9uK2tTYzRyTjF0UVVzMzFOZklEbnFzMktlNmFXd0hPZWZlcVBs?=
 =?utf-8?B?dmlzKzhPRDYwM0dVVUtlb2k2YVpUNHdWV2Y3NnZJZzF3MjJoaFJoUW13OVd2?=
 =?utf-8?B?bWtHVFYrOFFOWEhvcnN0QTJOZGFtdmRkMEhadnpENys1V2hMb3NKanVWZmo2?=
 =?utf-8?B?NE5UK3J6bmgxL3R2WUx0Q3pORGFFQnBVdm1DMnJhbVV4eDRhWkluZU53TExt?=
 =?utf-8?B?ZThXTnVFeVR0VFAwS2huZUlsTWM3ZlpndVg2OCtmVmRScjE2K1BPZlZKOEdB?=
 =?utf-8?B?NzN3ekp2bWRqcVphdnhWQ2hBR2wzYURzZDFlYkdZNU00L1JEMlgrZWR3dUg5?=
 =?utf-8?B?MmtWdW1zRWl1dk0zY0tDMGpqNDFobW4rb0NpYU5WakRkc3E4MURwZjQyWFR5?=
 =?utf-8?B?dVBId1Q3WVFUMHpLdVpGbEZudXA2UVZoRzhoTjJyblAxaVA3Q1BZcjhaeWhG?=
 =?utf-8?B?V1kyOXV5a1I4bW5CcTBVVDU5Y3J5bjJXN1d4bFRXTTIvdkk5NlNPTU1pbk91?=
 =?utf-8?B?RCtocmNNaTdZdzMvOWVzL3ZUQVExU2tVaTVzUjlpWjFTZXZkdlowbjVhQ0Iv?=
 =?utf-8?B?Z3BvbmpVQXlYV2g1OS9kN3BPQmN4SjdaVGpIUzNZY2l1bjRZRm1ZRW9BbmJC?=
 =?utf-8?B?dXZKUzk2MDBNb3VGWDNUVm9xMTJyRGFLalExS3dBQy9tbGY5RXkrL0ROZUVo?=
 =?utf-8?B?RlpxeXMzRlR2eGw0UDVhdmp0d2U2U2tXd0JuYkU0SE1hcUxaTkJGSVg0djVZ?=
 =?utf-8?B?THIzV3ZmaWVobUx1Z3NNUXptYnFvcFEySzlMRTZhRHByOEVDMWFSREVhUzR2?=
 =?utf-8?B?UU9lUHZqdXpta1FuSkxiLzNHd3AxaHcxU2VzT0xMM1FmbGVoaU5PdmZORE84?=
 =?utf-8?B?a1lvaVY5a21wV1lhSnAvTmhLeUFvcFFJWU11cHFoYkpwU0tSSk1vREtwY3Rp?=
 =?utf-8?B?dllTTHpRQ2R2ZWNtaEx1MVB2OURVZjcyTUl2LzVWZGVxbTB3Uk5RZ0swTkNI?=
 =?utf-8?B?bS9CVmkzK09DQUwzNlBBVkx3N2VaM00vTnR5RjFyRHJqemFmRVFKSmFWd0sz?=
 =?utf-8?B?T3E2WjBKcC81K1k4TDVaRnRRdXkxaktoMHJhTkI2RnZzazBORm9JcXZpdjBz?=
 =?utf-8?B?UzlZcmRsY24zSm9kMVFmb2VBc1pGZllZWmtJNkdqQVgzUmpENkdjVnZvWFIy?=
 =?utf-8?B?UDlyNm1pR2U4em80SVhkbHg2SVNnREVXWDdwNUVkRXBCaWM2YXRncGpuYzlE?=
 =?utf-8?B?Tk05R0w2OHlmL2swaURGVEtvcE5aTlY2bzFuc3lsN2Z1aDhDcEtHNXNWQnhz?=
 =?utf-8?B?WEhnQTZ5Y3VqNkdEYjRScU4vYVBwcVBuWDhMajRxenBpWERZaTN6eXRoVzJX?=
 =?utf-8?B?SFAveDJLZmd6dURLcCtBL3ZKdnZ6Nnh1VEhqc25zRUY4WTI5NEtwcGdVN0JV?=
 =?utf-8?B?RE9QM0hxUUVNaGV4UGpOZFN4ME5PUkE5MDhFcG81ZkdnN0FRb09zb2l2VUts?=
 =?utf-8?B?UnlrR2NVVkI5bWZTc3B5dyt2NTdsMUNDeXVXTjZoNlQ2WTlxQjR3NlBHcm40?=
 =?utf-8?B?SCtHK3FzcHlxQjlkU3RCOHR4bXJvSDVCMkNnVnFMWlFKN0NSWG5XMHl2VHdk?=
 =?utf-8?B?OXo2MmpOc0xyRHRybnltdnRxNzRYck1lMjA3TGFYSm1oV3ZzckpvS2ZLaGhZ?=
 =?utf-8?B?TzRwTlRhS093QTZZVXpYbEo0bk9Ib0U1Y2o2TTREMmVFeENKUE1xNnBPMGM2?=
 =?utf-8?B?Yyt6d3UxbkFiU0dtRDlMZ3N2NWtETXVNS2tGY3RTdkhUUndDQzVET1ZFajU3?=
 =?utf-8?B?RVJRNTR4M3BJV0Z3ajZPaVkrdHZYM0NjejFEOVZxWUFFRUhsajBEUURwcWhw?=
 =?utf-8?B?MUJXYXZWOStVejdFaU92djNmUTRjZ0V1R05WZThSL0VqRjJxZUN3LzQydDIx?=
 =?utf-8?Q?wp7VhpvOKtHjKDT20YP0mqSh8GW5X9Nk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:11:38.1560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d477f3-baab-4374-3b28-08dd15716852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616

Add Rafael and Len,

On 2024-12-05 00:42, Penny Zheng wrote:
> When running as Xen dom0 PVH guest, processor logical id <-> physical
> id map could not be properly set up. So the original function
> cppc_get_perf_caps() fails to get correct cppc data for Xen ACPI
> processor.
> 
> A new function xen_processor_get_perf_caps() is introduced to
> get xen-required cppc perf caps data.
> 
> Also, as Xen couldn't read and process PCC-type register, this commit
> includes a new flag pcc_unsupported in struct acpi_processor_flags to
> tell whether platform supports PCC-type register.
> 
> Signed-off-by: Penny Zheng <Penny.Zheng@amd.com>

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>

Again, no further comments - keeping full patch for others.

Regards,
Jason

> ---
>   drivers/acpi/cppc_acpi.c | 110 +++++++++++++++++++++++++++++++++++----
>   include/acpi/cppc_acpi.h |   5 ++
>   include/acpi/processor.h |   1 +
>   3 files changed, 105 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 13d6ff84a1e9..3a436591da07 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -772,6 +772,15 @@ static int acpi_cppc_processor_parse(struct acpi_processor *pr, struct cpc_desc
>   			 * so extract it only once.
>   			 */
>   			if (gas_t->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
> +				/*
> +				 * When ACPI processor represents Xen processor, PCC register type
> +				 * could not be properly read and processed right now, as logical
> +				 * processor doesn't always have 1:1 map relation to physical processor.
> +				 */
> +				if (pr->flags.pcc_unsupported) {
> +					pr_debug("Unsupported PCC register type:%d\n", pr->acpi_id);
> +					goto out_free;
> +				}
>   				if (pcc_subspace_id < 0) {
>   					pcc_subspace_id = gas_t->access_width;
>   					if (pcc_data_alloc(pcc_subspace_id))
> @@ -837,7 +846,9 @@ static int acpi_cppc_processor_parse(struct acpi_processor *pr, struct cpc_desc
>   			goto out_free;
>   		}
>   	}
> -	per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;
> +
> +	if (!pr->flags.pcc_unsupported)
> +		per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;
>   
>   	/*
>   	 * Initialize the remaining cpc_regs as unsupported.
> @@ -1018,8 +1029,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>   static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>   {
>   	void __iomem *vaddr = NULL;
> -	int size;
> -	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	int size, pcc_ss_id;
>   	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>   
>   	if (reg_res->type == ACPI_TYPE_INTEGER) {
> @@ -1044,14 +1054,17 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>   
>   		*val = val_u32;
>   		return 0;
> -	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
> -		/*
> -		 * For registers in PCC space, the register size is determined
> -		 * by the bit width field; the access size is used to indicate
> -		 * the PCC subspace id.
> -		 */
> -		size = reg->bit_width;
> -		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
> +	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
> +		pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +		if (pcc_ss_id >= 0) {
> +			/*
> +			 * For registers in PCC space, the register size is determined
> +			 * by the bit width field; the access size is used to indicate
> +			 * the PCC subspace id.
> +			 */
> +			size = reg->bit_width;
> +			vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
> +		}
>   	}
>   	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>   		vaddr = reg_res->sys_mem_vaddr;
> @@ -1282,6 +1295,81 @@ int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
>   
> +
> +int xen_processor_get_perf_caps(struct acpi_processor *pr, struct cppc_perf_caps *perf_caps)
> +{
> +	struct cpc_desc *cpc_ptr;
> +	struct cpc_register_resource *highest_reg, *lowest_reg,
> +		*lowest_non_linear_reg, *nominal_reg,
> +		*low_freq_reg = NULL, *nom_freq_reg = NULL;
> +	u64 high, low, nom, min_nonlinear, low_f = 0, nom_f = 0;
> +	int ret = 0;
> +
> +	cpc_ptr = kzalloc(sizeof(struct cpc_desc), GFP_KERNEL);
> +	if (!cpc_ptr)
> +		return -ENOMEM;
> +
> +	ret = acpi_cppc_processor_parse(pr, cpc_ptr);
> +	if (ret)
> +		goto err;
> +
> +	highest_reg = &cpc_ptr->cpc_regs[HIGHEST_PERF];
> +	lowest_reg = &cpc_ptr->cpc_regs[LOWEST_PERF];
> +	lowest_non_linear_reg = &cpc_ptr->cpc_regs[LOW_NON_LINEAR_PERF];
> +	nominal_reg = &cpc_ptr->cpc_regs[NOMINAL_PERF];
> +	low_freq_reg = &cpc_ptr->cpc_regs[LOWEST_FREQ];
> +	nom_freq_reg = &cpc_ptr->cpc_regs[NOMINAL_FREQ];
> +
> +	/* Are any of the regs PCC ?*/
> +	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
> +		CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg) ||
> +		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg)) {
> +		pr_debug("Unsupported register type read for Xen Processor %d,"
> +			 "highest_reg in PCC: %s, lowest_reg in PCC: %s,"
> +			 "lowest_non_linear_reg in PCC: %s, nominal_reg in PCC: %s,"
> +			 "low_freq_reg in PCC: %s, nom_freq_reg in PCC: %s\n",
> +			 pr->acpi_id, CPC_IN_PCC(highest_reg) ? "true" : "false",
> +			 CPC_IN_PCC(lowest_reg) ? "true" : "false",
> +			 CPC_IN_PCC(lowest_non_linear_reg) ? "true" : "false",
> +			 CPC_IN_PCC(nominal_reg) ? "true" : "false",
> +			 CPC_IN_PCC(low_freq_reg) ? "true" : "false",
> +			 CPC_IN_PCC(nom_freq_reg) ? "true" : "false");
> +		goto err;
> +	}
> +
> +	cpc_read(pr->acpi_id, highest_reg, &high);
> +	perf_caps->highest_perf = high;
> +
> +	cpc_read(pr->acpi_id, lowest_reg, &low);
> +	perf_caps->lowest_perf = low;
> +
> +	cpc_read(pr->acpi_id, nominal_reg, &nom);
> +	perf_caps->nominal_perf = nom;
> +
> +	cpc_read(pr->id, lowest_non_linear_reg, &min_nonlinear);
> +	perf_caps->lowest_nonlinear_perf = min_nonlinear;
> +
> +	if (!high || !low || !nom || !min_nonlinear)
> +		pr_warn("CPPC: read zero cpc register value for Xen Processor %d"
> +			"highest_reg: %llu, lowest_reg: %llu"
> +			"nominal_reg: %llu, lowest_non_linear_reg: %llu\n",
> +			pr->acpi_id, high, low, nom, min_nonlinear);
> +
> +	/* Read optional lowest and nominal frequencies if present */
> +	if (CPC_SUPPORTED(low_freq_reg))
> +		cpc_read(pr->acpi_id, low_freq_reg, &low_f);
> +
> +	if (CPC_SUPPORTED(nom_freq_reg))
> +		cpc_read(pr->acpi_id, nom_freq_reg, &nom_f);
> +
> +	perf_caps->lowest_freq = low_f;
> +	perf_caps->nominal_freq = nom_f;
> +
> + err:
> +	kfree(cpc_ptr);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xen_processor_get_perf_caps);
>   /**
>    * cppc_get_perf_caps - Get a CPU's performance capabilities.
>    * @cpunum: CPU from which to get capabilities info.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 76e44e102780..2281110c00b7 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -164,6 +164,7 @@ extern int cppc_set_auto_sel(int cpu, bool enable);
>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>   extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>   extern int amd_detect_prefcore(bool *detected);
> +extern int xen_processor_get_perf_caps(struct acpi_processor *pr, struct cppc_perf_caps *perf_caps);
>   #else /* !CONFIG_ACPI_CPPC_LIB */
>   static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>   {
> @@ -249,6 +250,10 @@ static inline int amd_detect_prefcore(bool *detected)
>   {
>   	return -ENODEV;
>   }
> +static inline int xen_processor_get_perf_caps(struct acpi_processor *pr, struct cppc_perf_caps *perf_caps)
> +{
> +	return -ENOTSUPP;
> +}
>   #endif /* !CONFIG_ACPI_CPPC_LIB */
>   
>   #endif /* _CPPC_ACPI_H*/
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index e6f6074eadbf..18499cc11366 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -214,6 +214,7 @@ struct acpi_processor_flags {
>   	u8 bm_control:1;
>   	u8 bm_check:1;
>   	u8 has_cst:1;
> +	u8 pcc_unsupported:1;
>   	u8 has_lpi:1;
>   	u8 power_setup_done:1;
>   	u8 bm_rld_set:1;


