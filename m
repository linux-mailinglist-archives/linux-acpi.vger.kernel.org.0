Return-Path: <linux-acpi+bounces-20392-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4EBD2548E
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 16:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDA7530051A5
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23DF3B8BA9;
	Thu, 15 Jan 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oC124BX9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC23B8BAF;
	Thu, 15 Jan 2026 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490575; cv=fail; b=oJ0Zg7weUGX2Z8szrIXCdCAHmf27N8zE2nlr/vFA+bnH0D5eZrLH7fWS9Esu4qkbG8wACyHkOkc8c00iHvOZqlkL8o59pBryXEU2OieQ21xCzQf/2zdlxg1QY9za4qXp9EeRQx/rVFlwQOm+F4HSWwqqUqBrQChWWuMxjhm62i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490575; c=relaxed/simple;
	bh=NfXp6ERTs6dBjYcito1raxtC4zzU+dHKqcNPmlHgiG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UVLgGyIsKt78Uw0mc/m69XVoKUQwbD5ASk1DPvKTQLcnoqe6kaMPCvw5nrNEhtGA1mLA6tM95KKEwdV0LmrvIawJNzf7WZpNk+ded4Gac5oR7f80+lo4Fci/rhqOH8BcFaPAgY5glB/18c+n/ndyQ1EjX8Px+3M6q9+FCca19wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oC124BX9; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ektuc9Z06WWHwuWqDXuLi9ce2oJIZKl4bCqZRgUfIu7kO/u8QeccBERj0XIjoPZZZsb+wOCgIa6kiN4QDFGSdhtcW9tEJGmrQPQ4Nu33WEBt5/Y/hrvETuO5r33RRJ23RlzyozLT6zOENl69jN5ugObYsohi+d9ml0/mzymHNoI9IuRGIfu0GqWRT3F07JF6tyI3/ChIjRGqDFO4h5RcKA6IlU3BOlu5SmcEzQsKnukhHDMZ6+iR3Rcpgp887n0XIcGRXb9GnP8IRJsNv4BnLdiCMHPJDkRVLNn46YuUbMmlks/dBhYwJgdSV5RM7vRgi+PxgnxrIafy/L1awiCERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxncVbkA2AX+GZX2EKdZRtoAA6DbhSKhGrchAItjfeM=;
 b=QZw2zj0zHGnp7Suf8eqmCPPQi193Iifc/1pqZBdHY4rcO8IkrDMilVRxoFIxmFE1Jg/ykeQ6Q6ccdAqyqaYWa4YIi1UhYHo7aYQm6hDm7lGdwOodTod6RODm/iIE9bQ7Bo+E/QcnDoAz68FTK2/S1EJ+HdUlrQq9zuhns9ozQbRFR/GglAb4Tsu2ZvuiI/Stiu62pD62Ih59MXJpuK4s5mSWzU2nBCPyUFi5op+p0ecoCwF2T9IEz+IEuIFIiUFrLQ0zT17CC2Ftj+nE9/8sHYsZMeAEREvbFEhNISiy4hsHoVq5UNws6aeR7h8dIMC8DviAfCfcWglAo6QTSHZAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxncVbkA2AX+GZX2EKdZRtoAA6DbhSKhGrchAItjfeM=;
 b=oC124BX9MYMtxTPEAraZEnPOSlMlix2TnOl41IOQG7gZoqX4n9JtwbgPECSu6sNjDg4ETNRZMlKdZMjk4Iu/7skGD2k2NijgS8hOmCcfnMOUGsoK+1qnLH1DCn/dP28fygyJ6lLjQ7RFUvIZdxb0DuyIRFfHl2jZjvvQ2XBlv8/l8IahbHBoU8QTp5KC8jDBu+ZRdbnN4YDM1J+lV28fzLQac8rhbaG8SR95Y7qS2qJmLAE4du3/mQkjDyZDBT/GwPXnboJjGEGHtS7O6k06jT9IwviOqfW/FulkwWxCrC2YpB2GXwQlIYU6IWMXjHXkb3m/j8jJKko4e6uVpS6Ecw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 15:22:38 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 15:22:38 +0000
Message-ID: <0d1a10e8-a8d5-4d27-bd16-0443d5408ca6@nvidia.com>
Date: Thu, 15 Jan 2026 20:52:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] cpufreq: CPPC: make scaling_min/max_freq
 read-only when auto_sel enabled
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, ray.huang@amd.com,
 corbet@lwn.net, robert.moore@intel.com, lenb@kernel.org,
 acpica-devel@lists.linux.dev, mario.limonciello@amd.com,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
 sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-11-sumitg@nvidia.com>
 <ed9015a3-42b5-4c0e-af6f-2b4d65c34cd5@arm.com>
 <0fe78528-db0c-494d-8d5e-b89abdc993b2@nvidia.com>
 <f85ce68a-91cb-4b8e-b67e-413e5b62cd03@arm.com>
 <27750fe9-8b0e-4687-bc5f-21e4ec38bf66@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <27750fe9-8b0e-4687-bc5f-21e4ec38bf66@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::11) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: 45877c72-6830-4ff8-fe7e-08de5449eae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2diRHNEMUU4Mkg2dlJJMkVsaHhIbnM2VkRoUDQwcTNrOXFJYVhUOXVEd1ZS?=
 =?utf-8?B?OGdSb2lSYldsdGR0azFxbnZqdjI5U0hIVldxVmt2TGU3dkcvSVdWUHBEcGgw?=
 =?utf-8?B?MjBUVzdWQ3d6dGFUU0Y4am5Od3NGZkpkVEdSMVRScitCQVVmZTkzWVVGcnV6?=
 =?utf-8?B?ZVg0OWkrY3paNWYzV2wyeHJDdmpUejUySFcyT0F1RHlpNHlxdXJ5dTZzYnpK?=
 =?utf-8?B?UXJrZXBvekxBcGUyU3IvbmczZGV0aENUcXhlZU9jbkcrZmF1REVYdFhBd1Jx?=
 =?utf-8?B?ZHpSUktZeDJYZDE5WGxtdUw4Umd3L1d6aEhmK2NQS096cVNidVprOVJNV2pu?=
 =?utf-8?B?R2dMZkd3NmFleHJKVWhJZlkxZEViQ1Q4WlcxejA1UVBLc3A4ajdGajRZQ1RU?=
 =?utf-8?B?T3p4Yk85OCtSRzNJL3drZDNzTDcxZ1B0am5ydlNoRU1QcjZsMXhEcDdoRGJC?=
 =?utf-8?B?V0FFRnpWMDBtYzZRbkRacGdWM1BRMEhsbk5CYUM5S25wSVllSm5iMndDdjNM?=
 =?utf-8?B?c2N4dldUWnRIdjNoWWRQcEp2ZTY3ZmZxb2ZDMXRhWTJqbmJHWnp0UHJnMnpW?=
 =?utf-8?B?TGZ2QmQxNmlHZ2JKT09RemdSRGQ3d3hBZTBaMVRuRlZlTHF1cmJtanE5UjE1?=
 =?utf-8?B?Um5zUkZvOGx0OHNxVGZqWWpnY25PYUtDNVRDcHFiWUJoLzh1L1JnYkY3SzVn?=
 =?utf-8?B?dzg3RldWTjFrdHI0WkZZMGNjb1lsNzd3SkF6TWdUOStXaEdlVXRBVUJ2d1Z3?=
 =?utf-8?B?MWY3Y0d0QURCQk9NUDl3ZkdhWEhCVys2VnVzbTZtci9yMHZJN0FTUDVtUWNz?=
 =?utf-8?B?aENseklSMStQVmNUcWxQSWlrOTNoZ2crVHBKUzBLR09ZZVdRTUx4VVhBbXlG?=
 =?utf-8?B?Q3RhRXUyeUYxdjRyRndCS1lkandtQWtMT0ZnV2xRYmtoQ0VKRVJSRHFDYUE2?=
 =?utf-8?B?ZkZGZDBHa2FQOW9hVmEveHhNa29FNDVZTXhjVFBmaGFuTC9Gb1VDY1grSUpL?=
 =?utf-8?B?UlE4WFB4V215UUN5MlZBcjVVQitLTmZGeTJwSW5KQXN6eHlDV21IaG9MTldl?=
 =?utf-8?B?R1JwekpBSzBxTkx2Z2xMbzExcytrV0VVcW5tNzFBR1dqbXpEUXhXL25mSEt3?=
 =?utf-8?B?SGNubmNuelRtMWhwWHM5Wm9wWHpGSDFzTVNvd1lPa2lpRVJENU1JYitzVTNR?=
 =?utf-8?B?Tk91cUxrOWdUcEhPY1UrR09zYzlXejhWVDRXT1VJREZ2d05HVTY3MUZ2TGFi?=
 =?utf-8?B?WE9WRUVFZGFrc2VEcWNNUDlmSmVWZU5zQkZWUmViUlFpNjlQcjE3a3NWRFk2?=
 =?utf-8?B?T1M0Q2JhbFlrWFFCck1lSkFJaGVzcFpHVkJsUFE0c2RBK3d4UXZZOHdLU2tX?=
 =?utf-8?B?b3ZZZzZuRTFHRHA3S3NzVWVzUktoRU1qay9lb3creXlaejVQbFpteUFVNUFN?=
 =?utf-8?B?MVBWamV5TXZRUFBpeG8wYnJGRk0zalJBYlA5L1crR2x0Wk9rWTRvSjgvZDdT?=
 =?utf-8?B?ZTVOM2N2K29uYTlxazVoVTVLTDhvNEx0Z2krenJ0TjVaZndsY3NDTUFFRlFK?=
 =?utf-8?B?eDdxVlVUdng1eVl2N1d0NnJEczYyd0ErL1M4UWlEZW1seUs4K2VPc0tXWnNB?=
 =?utf-8?B?VGJKdGNXa25LNVJ5Y2RKajB5M2R1S0VXWGoyUGNkV2VtMHVEbDZTeUFOenl2?=
 =?utf-8?B?RWdmR3BTcUhDZVU3UCtBbktnNkhIUmdMK3MyNkFzdkxDTis5WDgwclVheUxR?=
 =?utf-8?B?OVRVMEJsZ3FlUzV6Rks2QXAwYnFjclJpTDN5RW1QTlFJZTQ3YlhkeUFXRVdE?=
 =?utf-8?B?MGQ1NlNKU2tQRnd6RkluODNQTXZIb1dGQW5NNGZqb0tnMUtFcVNmN3RMb1k2?=
 =?utf-8?B?YWRMcTdWcVVTMmpwSTdDVDhTKzJMdjU3Q0w5aG0zdWJLbXdCajN2NFJGbW1S?=
 =?utf-8?B?Nmg0NmJJbTlJcmhMaXNnZ1ZLWFE4ZUl5RHNDaDZhQlZBcmZQQ2lWNTlXVkI3?=
 =?utf-8?B?bXhPclpXUzVuVEFwTm5iZFUvaER0SEx5SG9KWWY2SlUyTjhaZDZjbHBmTysw?=
 =?utf-8?B?RVpSUWh0R1NzRGRMbVVMa1RXS0xVVmZRNzdmQnNoajlFUHdzUDlaQnZ6MDZs?=
 =?utf-8?Q?Pn8s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alYwYndFTDM0Mi9FcUhWSVJpdmIrdjF0WTc5bXEvNVdsSGtpZzJVdTNrSmls?=
 =?utf-8?B?SHFZWFJVTVVtNzlmd3FkZlBIdjdXMDZGeUJxSEo5TkQ3ak80RXY3ZjFJUjFu?=
 =?utf-8?B?ZDUvNFBwdXBlSFZXc0FwNVJrY2h6MnEzN3A4a29sVXpGVTNrazhCR0RuRUVZ?=
 =?utf-8?B?MmlhcDhsNm5EU0ptNzNmdEcvSENXNVZMYTAwekM2UXNWZHdLam0xb1lXaWFo?=
 =?utf-8?B?cUphdFFBZmZuZzY3ckVEeGVBVEFtQ3lmd3ByNDBsczdxeXdwL0FXRm5jUlFG?=
 =?utf-8?B?cUV5OG1uVlFTTkxDTUw3T3hTcFUrMWZCTm9mTGxDOWJGMk9LMVJSbFZLVWVV?=
 =?utf-8?B?QzdEMkdkVnRIWURGVFQ5OWVudG5LYjBpN0hIWDNRY3FCcUsxQzVDT0VIbTdu?=
 =?utf-8?B?UTY4Y28wZWI2c25hRjg3VG53VmxjbmgzdSthMjZvSEMzV0tSOHIvZzg5NHha?=
 =?utf-8?B?aDZVZ1pJZmJKRmNId0pkUWRZRkcwRkZ2WGZIYkZwdjBzbTIxdUkzRTQ2N25W?=
 =?utf-8?B?TE9PWFB2ajNQaVBuRTU0VjhlT2xwVzFlOEZPK3lSY013T1MyakhhZUprWXk1?=
 =?utf-8?B?UVJxWWFYVjlnQ2ZqSHR0emUxSWh6Um1hVWk1Tjdsb3JHbGt3bWFnWVk4b0R6?=
 =?utf-8?B?UDR6RjU5bkgzeUZ1UXpyMUNRd3ZvL1RpaGVzR3BPNUdkZERDTm5aQzgvNnh1?=
 =?utf-8?B?TWFOTHJMTmcwcXF1TWZVUkpsd1FuN3krc3BhZzRqQnoreTJmcGRXQ09uU2Ew?=
 =?utf-8?B?SnJyOWZ6V3dOdGs4ZFhINmVuS3NWR0JVek1ZVmRtWktiRTRnN2NxZmtRWXVv?=
 =?utf-8?B?ekdhM3BBQ2wyMXdKcGtYQlFDYUtYaXpLdkwwU25Ed3ZvZlNURkdpc0pGenBl?=
 =?utf-8?B?TnBHYUpqVHlWWkVFWEZXZ0VzV245d0w4T1NlUCtLUlB3QTgyc2JXdlFsNi9X?=
 =?utf-8?B?eVJkdHpjeW50RERBd1RHTkNwcHNZZDFRNXNuRVNVdHZNU0ZrZExUR3kyUUQ2?=
 =?utf-8?B?RTVIVnlXdlNQVWNrV2RGRUJoeVYrVmFoN3FaeGtmWUJWbk42MXd6OXRPMW9j?=
 =?utf-8?B?ME5ZSG1oMkRpZVlZR25ZdkpyWkdyQ2ZpMDJjaktsNVpHdFcwOE91YzNLektL?=
 =?utf-8?B?Ti9tNE42MERMeUFaemIwV0tLZmJRcjhDRjNuQWhFMms5T3RHVkxDTWFHQ2Jk?=
 =?utf-8?B?bC8yd1NXTWpJUUlCeXZETzhDSng2U0pMMzVWV1Yyam9LdFNGNGg1N0QyOEJp?=
 =?utf-8?B?QlRkbWh5ZldZZ1cvMjRmVEpWb3pJTllNbGwrOUpYZWV2cWUwVzkrRnlxd3hs?=
 =?utf-8?B?a0dVejBUUTdmWU41NHZLN2ZxNlFweEI5eCs2K2dFazNnZ1N4VmdYL05JSEpy?=
 =?utf-8?B?UXRXNnl6eXZNaTJqMmlUQS9sV3lDZ2h0aVJzb3p5a1dWSVVRWW1tS2tUSUxm?=
 =?utf-8?B?MGxpTkhZUEtvdGxESjVkVXgrOEtMdnI2TzdQRm1vUS9mSDh0RUw2d1ozUXpN?=
 =?utf-8?B?b0RMbDdGOFlESlNIazV2QjFCSE5nTkZSWFFCMjROZFV5czVMcGxBU3hhWDI3?=
 =?utf-8?B?MTIvQmlGYXNleTBpcWIyS3pHelNWM01kTE1nUzlKN1ljNHI5SkRrQW5Venhj?=
 =?utf-8?B?VVRUdDZIOHJZKzltODNsOUV2cGdYOEZvVGg2ZVRIU25iZSs4MUpKL0NjVmNj?=
 =?utf-8?B?L20wajBQZ3BIMC9QWFhkZEZYUEE4VXhRMUJTTW1UQUQyMVJaY3I2MjFpOTda?=
 =?utf-8?B?ZG02Tk5XNC9zbWNJWDlQMkk0U1lLaDkwM2hINkxFVmhGRWhDRUZQbTh4UjJ0?=
 =?utf-8?B?WjRLZmUwbG5vL0ZxSWVya2RocTRCN1ZVTTczbmRuSDFXbnI4ZGgzL1FPcExn?=
 =?utf-8?B?VUNHK1pVNXhtb0NZa0RGU3JaS1pQazJFOXZUeUtQTmRDbnVLQnZDWjVNdjRh?=
 =?utf-8?B?SWZvZlVmNVNsSmlLMEJlWG1tNC9Lem1ZWWNucHhGeGpxTVB1RmNDT3FoVmp4?=
 =?utf-8?B?Mkh5L2FaRzN2R05tK1d6SFdhVTduVlIrM3VBa3BOSXhMbzFwcjVnQ2t5eDJ1?=
 =?utf-8?B?NnRIMUZTcWFxWHFST0hjajZVUUhlM1JmWUJ0bUJaQUROL210NG95SDJaRktK?=
 =?utf-8?B?OHRrVUJOTXE3SS91TGkzSzcyT0hJNXN5dVBrRy9SYVpBZWhTTnZUanlTQzVP?=
 =?utf-8?B?bmZ1UUI5RlFncW1hcW5qK0pReitDTXdwRGIxZTBTaDNFRmNqaEs4WUZkcWVq?=
 =?utf-8?B?NWlDZGszclp6MFR0VFNjci9GSzB4dWFFYU5DN1dtbUxpQVdTL1FwR1RMRUg2?=
 =?utf-8?B?YUw1L3FQaVBuaTNGTlJxbUFDTVZiMEFSaVRLNWk5VHdHRkwyL0JBQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45877c72-6830-4ff8-fe7e-08de5449eae2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 15:22:38.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zC0sh8ZjWLm0HKubTOf6Kg3PMzyV79mcJCfE+fOQUVolcV2QEc0oTb8CVEDIbDem6mUkkjmYiyWo6tEDExJXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606


>>> n 08/01/26 22:16, Pierre Gondois wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> Hello Sumit, Lifeng,
>>>>
>>>> On 12/23/25 13:13, Sumit Gupta wrote:
>>>>> When autonomous selection (auto_sel) is enabled, the hardware controls
>>>>> performance within min_perf/max_perf register bounds making the
>>>>> scaling_min/max_freq effectively read-only.
>>>> If auto_sel is set, the governor associated to the policy will have no
>>>> actual control.
>>>>
>>>> E.g.:
>>>> If the schedutil governor is used, attempts to set the
>>>> frequency based on CPU utilization will be periodically
>>>> sent, but they will have no effect.
>>>>
>>>> The same thing will happen for the ondemand, performance,
>>>> powersave, userspace, etc. governors. They can only work if
>>>> frequency requests are taken into account.
>>>>
>>>> ------------
>>>>
>>>> This looks like the intel_pstate governor handling where it is possible
>>>> not to have .target() or .target_index() callback and the hardware is in
>>>> charge (IIUC).
>>>> For this case, only 2 governor seem available: performance and powersave.
>>>>
> As you mentioned in [2], 'it still makes sense to have cpufreq requesting a
> certain performance level even though autonomous selection is enabled'. So I
> think it's OK to have a governor when auto_selection is enabled.
>
> [2] https://lore.kernel.org/all/9f46991d-98c3-41f5-8133-6612b397e33a@arm.com/
>
>> Thanks for pointing me to the first version, I forgot how your
>> first implementation was.
>>
>>
>>> In v1 [1], I added a separate cppc_cpufreq_epp_driver instance without
>>> target*() hooks, using setpolicy() instead (similar to AMD pstate).
>>> However, this approach doesn't allow per-CPU control: if we boot with the
>>> EPP driver, we can't dynamically disable auto_sel for individual CPUs and
>>> return to OS governor control (no target hook available). AMD and Intel
>>> pstate drivers seem to set HW autonomous mode for all CPUs globally,
>>> not per-CPU. So, changed it in v2.
>>> [1] https://lore.kernel.org/lkml/20250211103737.447704-6-sumitg@nvidia.com/
>>>
>> Ok right.
>> This is something I don't really understand in the current intel/amd cpufreq
>> drivers. FWIU:
>> - the cpufreq drivers abstractions allow to access different hardware
>> - the governor abstraction allows to switch between different algorithms
>> to select the 'correct' frequency.
>>
>> So IMO switching to autonomous selection should be done by switching
>> to another governor and the 'auto_sel' file should not be accessible to users.
>>
>> ------------
>>
>> Being able to enable/disable the autonomous selection on a per-policy
>> base seems a valid use-case. It also seems to fit the per-policy governor
>> capabilities.
> I'm OK with adding an auto-selection governor. It's better to keep this
> governor only in cppc_cpufreq for now I think.
>
>> However toggling the auto_sel on different CPUs inside the same policy
>> seems inappropriate (this is is not what is done in  this patchset IIUC).
>>
> I think Sumit means per-policy when he said per-CPU.

Yes, it's per-policy.

Thank you,
Sumit Gupta


>>>> ------------
>>>>
>>>> In our case, I think it is desired to unload the scaling governor
>>>> currently in
>>>> use if auto_sel is selected. Letting the rest of the system think it has
>>>> control
>>>> over the freq. selection seems incorrect.
>>>> I am not sure what to replace it with:
>>>> -
>>>> There are no specific performance/powersave modes for CPPC.
>>>> There is a range of values between 0-255
>>>> -
>>>> A firmware auto-selection governor could be created just for this case.
>>>> Being able to switch between OS-driven and firmware driven freq. selection
>>>> is not specific to CPPC (for the future).
>>>> However I am not really able to say the implications of doing that.
>>>>
>>>> ------------
>>>>
>>>> I think it would be better to split your patchset in 2:
>>>> 1. adding APIs for the CPPC spec.
>>>> 2. using the APIs, especially for auto_sel
>>>>
>>>> 1. is likely to be straightforward as the APIs will still be used
>>>> by the driver at some point.
>>>> 2. is likely to bring more discussion.
>>>>
>>> We discussed adding a hw_auto_sel governor as a second step, though the
>>> approach may need refinement during implementation.
>> I didn't find in the thread adding a new governor was discussed in the
>> threads, in case you have a direct link.
>>
>>> Deferred it (to second step) because adding a new governor requires
>>> broader discussion.
>>>
>>> This issue already exists in current code - store_auto_select() enables
>>> auto_sel without any governor awareness. These patches improve the
>>> situation by:
>>> - Updating scaling_min/max_freq when toggling auto_sel mode
>>> - Syncing policy limits with actual HW min/max_perf bounds
>>> - Making scaling_min/max_freq read-only in auto_sel mode
>>>
>>> Would it be acceptable to merge this as a first step, with the governor
>>> handling as a follow-up?
>>> If not and you prefer splitting, which grouping works better:
>>>    A) Patches 1-8 then 9-11.
>>>    B) "ACPI: CPPC *" patches then "cpufreq: CPPC *" patches.
>>>
>> If it's possible I would like to understand what the end result should
>> look like. If ultimately enabling auto_sel implies switching governor
>> I understand, but I didn't find the thread that discussed about that
>> unfortunately.
>>
>>
>>>>> Enforce this by setting policy limits to min/max_perf bounds in
>>>>> cppc_verify_policy(). Users must use min_perf/max_perf sysfs interfaces
>>>>> to change performance limits in autonomous mode.
>>>>>
>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>> ---
>>>>>    drivers/cpufreq/cppc_cpufreq.c | 32 +++++++++++++++++++++++++++++++-
>>>>>    1 file changed, 31 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>>> index b1f570d6de34..b3da263c18b0 100644
>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>> @@ -305,7 +305,37 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>>>>
>>>>>    static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>>>>    {
>>>>> -     cpufreq_verify_within_cpu_limits(policy);
>>>>> +     unsigned int min_freq = policy->cpuinfo.min_freq;
>>>>> +     unsigned int max_freq = policy->cpuinfo.max_freq;
>>>>> +     struct cpufreq_policy *cpu_policy;
>>>>> +     struct cppc_cpudata *cpu_data;
>>>>> +     struct cppc_perf_caps *caps;
>>>>> +
>>>>> +     cpu_policy = cpufreq_cpu_get(policy->cpu);
>>>>> +     if (!cpu_policy)
>>>>> +             return -ENODEV;
>>>>> +
>>>>> +     cpu_data = cpu_policy->driver_data;
>>>>> +     caps = &cpu_data->perf_caps;
>>>>> +
>>>>> +     if (cpu_data->perf_ctrls.auto_sel) {
>>>>> +             u32 min_perf, max_perf;
>>>>> +
>>>>> +             /*
>>>>> +              * Set policy limits to HW min/max_perf bounds. In autonomous
>>>>> +              * mode, scaling_min/max_freq is effectively read-only.
>>>>> +              */
>>>>> +             min_perf = cpu_data->perf_ctrls.min_perf ?:
>>>>> +                        caps->lowest_nonlinear_perf;
>>>>> +             max_perf = cpu_data->perf_ctrls.max_perf ?: caps->nominal_perf;
>>>>> +
>>>>> +             policy->min = cppc_perf_to_khz(caps, min_perf);
>>>>> +             policy->max = cppc_perf_to_khz(caps, max_perf);
>>>> policy->min/max values are overwritten, but the governor which is
>>>> supposed to use them to select the most fitting frequency will be
>>>> ignored by the firmware I think.
>>>>
>>> Yes.
>>>
>>>>> +     } else {
>>>>> +             cpufreq_verify_within_limits(policy, min_freq, max_freq);
>>>>> +     }
>>>>> +
>>>>> +     cpufreq_cpu_put(cpu_policy);
>>>>>        return 0;
>>>>>    }
>>>>>

