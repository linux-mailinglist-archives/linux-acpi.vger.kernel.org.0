Return-Path: <linux-acpi+bounces-20062-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADEAD03299
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 14:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68BF130069AE
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECDA4DA55A;
	Thu,  8 Jan 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p4Inyj3x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17384DA52F;
	Thu,  8 Jan 2026 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879591; cv=fail; b=cKETf9lt2rQo2SGCABCZWeUnFbK2hT9xbxfbEtBxvDzcNnWZoqZ2SZmlY3enwzjy56kJ3AdMiRyydX3YqiCLN0VGrsY5KyKXzZTPTBdfzPwE4dyCvNNJdnxj7uPNiJFJd6j7By+eevngFAhcLIdL1zosVK3jxdiHRNev543IesE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879591; c=relaxed/simple;
	bh=ymvHXU/0a8Y0K8+pcJkq46RQnk1M/zNq/g4hGSnu458=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IOZyLYhxrXRBXoXmGSh1lDig9P1MVV0mLfYxVkzWh4XhCSPmFPaemD3sl1v+x7atxElW/lIGSeRFiC/YzpVPl0yinWlHemwMgV/8phaRvt2rSX1kcUaWvfykp0EUVH1kMyQYigOjvIQGexQ8+NWtq2JotULwIQYfY5mJZrwRcx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p4Inyj3x; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAw0DA45cPh7yVR5RgDRhhfKs7uJH1WqmrZ8ta+8L/9kyVX5cACAZQTWDcGMFUlzxDEg3X457L3Dv+QKFGvZ3cv0nUMnJFlaSTCAPGTi12js7aAiYnPhdcZjxkCqV7pMpJESSVIMHHXjWhRaLghDGmPc2dBouLrUzMaOPJ7KJJRUxRhnGw+v+ekBn4XADTChLLKuhMpFx5lSyCnSsEpgdaLXOAkQu/KnxzuTnTDfHWg2FaCxEvQoOi4OdnjDS3TGWG+XrjgKgJG3WQs+qoFuXFXdwiwjynHiCRn9cbr+eovEuOMeOzl9l7UBy1hNZ6XP0so9zm6HERekNmGHGg6sGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TgZcC2CUjfuSHX1Q3n2veh++g1mKZr4Dwmwk3O6d0c=;
 b=i6LLmpOan301awMN+JtYR2cNw4BacbKNuw6T5xdqO+6RHUOXWSh4hEGdt5k8dT9fo+B1GbzTrxqo55J6lUnS/9siOLJzjbp5yX3Or39aYsHrYBXTWGQhqrpk9ueECc6AwBPCw19vmNHVNjB584YFl7e3+o2QvW6nrseP4/I7l1iUZbENn0WA1Xuv8X4n0zmtw/G2CSKRjbZYdoXe58z33yLDbBc3s/30/6Bjjlj2JQvtDv/pdFzFSJgYKpy0KTHHaMGxyBLc2UZj80RCnrbBVm3azh0nGcS5SCRb1/DWpLhTFMiO+3B7Yj+m3fZFwMzOAUEbiqbDDKB53KJA45vmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TgZcC2CUjfuSHX1Q3n2veh++g1mKZr4Dwmwk3O6d0c=;
 b=p4Inyj3xjKajnuGkGZs/ZXn2xfxoM2y+i3o/fvqy5kI08pXQC393Oh3qKmMVBXOaq6DfSAoA+8aUMP/TXEoozvGgH38890Z+LxmWztZJKomgfNM8lWWyCLt58r5oMn/wQmsAwYuKYPy6xCR8ii1SXVhok6zk+nYiqxskhroO+rqlJRASu2XPX1i2/oicD3NFEj7iaBAhHBmfK1iB3onUa64luSU87nIS1aIUjyUW3cNLR/EHTOx1yiGzIygdBJ3C5/65D/tVBfF2KGQeMeJUJp36XEFBI1+K+vlah3zxRSw3Ha2qw863YDipl0BvSpJCumpkNiLsH2O6WZmVq/iwXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 13:39:44 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:39:44 +0000
Message-ID: <4fa3d3bb-9853-4041-9db1-3d9728cbff44@nvidia.com>
Date: Thu, 8 Jan 2026 19:09:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/11] ACPI: CPPC: Extend cppc_set_epp_perf() to
 support auto_sel and epp
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, rdunlap@infradead.org,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, ionela.voinescu@arm.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-5-sumitg@nvidia.com>
 <81f6409e-7909-44f7-9618-5f263b297ce9@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <81f6409e-7909-44f7-9618-5f263b297ce9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0256.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::19) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 401783b2-b344-4c7d-2336-08de4ebb61f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?citzZzhwdENHTDV1KzdKclJnNi9JZVhRbVN1ODNzblZYMWpHMlNWQ0JoYmlH?=
 =?utf-8?B?NzFpdHRXWStuQUZTR1V2WmR3VmJzSGZoODFYbjgvcVBrV0dnY2xuRy9OaUhi?=
 =?utf-8?B?ejhCeUxER2w0N0J1Zm5jaE13aDJ5WCs4Q2NnM05jdnhMdjYrcnBRb1NuVHk1?=
 =?utf-8?B?QWl5VVQ5cjFJcE16RTYyK2phaWpjQ1hPMWJZS1FSRlRVNUVZL0hlRlo5RUdh?=
 =?utf-8?B?bzhJdEtLTEdQLzQzbzBOQkN1aU1vVmZHTXFwcUVUYXBKMk10MUs5VHBGTlZ2?=
 =?utf-8?B?QkU5bjR2RmdmWkdETE82WnV5YTlPODBKOTBGSDRiTjNWOXJRZGx4cDlvQjVs?=
 =?utf-8?B?TUkzbHNhcjZKKzloMjR0dEl2ZnNQNk4yQUpIUWYrUzJRT3BQU2JyS01RWUF3?=
 =?utf-8?B?d0ZhMU8rN3dpLzZwVHU5WTRFVjZ0TFFzcTFPNWExQlgwMG5PYzI4aUNKaXRT?=
 =?utf-8?B?dVlIQWhSK3pJVm1kaGl5U2xRR1FwWVo3RTc1RmVRUC9lU0g3bUU3bXBNby90?=
 =?utf-8?B?czZiVnBBWlpkK3lueFZSK2MyT1VKMDBIamRxc0hjOEorc1J1SERQdWJCUUl3?=
 =?utf-8?B?cUI5UW1aZDRJYWthMGp2VERQbEhpT0tnYUcreDB5c3c0UDNsTzc4Wm1rV3Vl?=
 =?utf-8?B?SWlLOWJMbXlhVzh1RDhEMlN2SGdkSUN2NTFCeXk5ZEl6V1lyV3pKdmdNVVJ4?=
 =?utf-8?B?dFlBZGphKzYvczAyVVBXczNObGRvNHlXc20zd25FTmdBNEU1Y2lyMTlxNlRE?=
 =?utf-8?B?MEQ5WnRsM3cwYjhQYXdJbUE2anR0bmM3YzQ5UmhxU3JZNnUydEd6NGh4UUFC?=
 =?utf-8?B?cGJrM3JVNTFvT2dhblFCVjU3U3pYRGEzdWZUUFZTY3FOcEtodWgvblMvV2ZC?=
 =?utf-8?B?Mm9EZmdRNEloWFhaWDJuVjZhOFVSWmNMVXhNRUI4Mzg5UW42cVFYRUlmcWgy?=
 =?utf-8?B?MkNoY014S1BGeVNUVzVsZXYvRnhjWkRlZWtWekpyanNPY1NVRERQeEpEM0Nq?=
 =?utf-8?B?bFdkNzZsaEtvaXYraVhScFMzVk5mV2ZvWXhwRC9wRkZVUTV2bGNHUVdWUlB2?=
 =?utf-8?B?bWZpemtiakZFTzR6Mzlva2FCVUJRU1V6MW5xUTBGL25lSTl4YlpWMng2RWRn?=
 =?utf-8?B?YjBCRW1XL3JhaEtMYkFCS1pXdkphT20vUlFuRmY0RDlvUUFxOU5TWTRhRDNY?=
 =?utf-8?B?Qkh1dHJKU2ZyM0FQMnVDRFFUZ2hwVjFEUEdVZ3JuRlZ2V2xpNlJZaWhJUzhF?=
 =?utf-8?B?d1hXZ3AwTUhvaVgvVTNvdkw1MDh6WThJQkFENitmT2hCQ1dTREppVlJUWWZU?=
 =?utf-8?B?eHZwUU5MNU5pRnFpNWhFOWtLS0Y5UnJSc012VzNLejhpOHBUeDl0S0Q2a0hw?=
 =?utf-8?B?TmVqMVJOWEpMamVrWFJPb3NnOS9WWjBRRnNtaHVxYjhRSDMwZGN2Zkd3Y0hZ?=
 =?utf-8?B?YU5LVUlzbFNHZUhJNUZEb21qT0FkeFozNDVpQTR2ZmYySFU3TGxXUitqUlNW?=
 =?utf-8?B?Q3A3SCs3Zkc4MWFKS0ZtcUh6ZFppajV0ZzQrU0V2SEZzVEhyUHRydHZybmo1?=
 =?utf-8?B?Z0RIcC9oT3cvYTZ6QzkyUnRhYVRIMmVuWUFRQk11M3hWblZDdTdqRGZMTWtt?=
 =?utf-8?B?QkxJTlpDVHIyR25jdmEwMFdld0JmVGY3dmkxZjIzMkJOK29pZFRmUTF3a0Qr?=
 =?utf-8?B?V1BIaVA4OFUvQWVMUjA1MklaK1VrRk1RUWI1RUpnRUNWMzNkRXlhN0kveml4?=
 =?utf-8?B?RVpuMEtDQ2RnRXNackp1b0V3WUdsTGltaVVQZXRzOFZQOHVKT0ljelVsWFg5?=
 =?utf-8?B?UkhXWVBKZUtxVGpUNWxuVXdsam9LWGxudzdOSC9ScDNGYm5ub1dKKy96cEdh?=
 =?utf-8?B?b3lsa2JYbzg1OENIa2hOL2QvU2FRRjNYOVVFZ0ZjOUVVNFhZL1c2bnZiVDhQ?=
 =?utf-8?B?MHZqVE9xZjZ1L0FsWXJzVkM0c2srRUZlQU9ibXZFVlNENENzbXFPVlA3SC93?=
 =?utf-8?Q?QuvCqUoyQXNLqy2QU0Xve+unjVKRPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlV1TWlhMmdtZk90SFBxQ1BjK0FNWU5EaU8vdHVZU042YSs4d2ZsWDRoMGdR?=
 =?utf-8?B?U2I4R0ErMktJUHhWZGhXeEczR2oxT1kya2MrR3AvLzJUWnNZZ2FJZ3VGRU5F?=
 =?utf-8?B?d3JvelZyNE51eWwzcjNySy9id0k4cmxJY2xGRDJzdG9Qb3F6RWVYRXJ0YzZB?=
 =?utf-8?B?dmc1dmJQcEtCYmRqSVg0c0hEaS9VVFJ2bHNkYmlJQ29yV1ZVaFNLL1dSMVBV?=
 =?utf-8?B?dzdKNXdMNDlkY3FNc25CM3NSNlo3bkVRbXZ4cTdtR29TWklaTUZ3emk0NlZk?=
 =?utf-8?B?eUVVczZmUnZ4cTRVNUtuU3NLWm91cjllamxLd2srbzFWS09pdEs4azl0SWRa?=
 =?utf-8?B?R2F3MDZrY0dzOUZGVGNma3pmSDM0eC9oVk5ZL2JJMW4wVTEzVkZEbExjWmto?=
 =?utf-8?B?eWVzTjFnd2tUc01UOTJTNTJTaEdwOEIvSWc1UytTQVpENGplOTlucXpKUE9Q?=
 =?utf-8?B?Njd3RFdBeVR4SFZvVit3RU9neXEzUkdhWm54KzBxS2FFSmF0bFlFUTdaeWNE?=
 =?utf-8?B?YkhRaTFjODhtYldRK3lTZzl4RG5EZTN0OGU5ZWhLbEgrMERXNFgyZDVqRzFZ?=
 =?utf-8?B?a0lhTmNLVExveXBHb0JLZkRBd1dOajVNTUYzcXJZYzBFMVpPZnFSYlV1VHBa?=
 =?utf-8?B?UURDL1V4aUxqbk01bjE3ZGg2RW9QVWgxYktVMVI1YUZjaGt0c1c0Skd3cUVQ?=
 =?utf-8?B?WGNVR0hFYTZNZUQ0UVVtOGN1SlVCaWIrYU9Pa1IzQ2J3dDhhNWtYdFhVOWZ2?=
 =?utf-8?B?eEFyVXRiUkZPMENhbVV4b0d1aG9QOWh5OWF0VWVpd0NwaFczNDhnVjR4Qk9B?=
 =?utf-8?B?Wnc1d1N2YTRMSE9jV2k4bFFMaUFwR3lDQ3A0QnhNb1JZUW0zdGNOZUNBRzhR?=
 =?utf-8?B?UEFNeDFVVU9yUjlyOXJRSitOL2R5QlRneXdxMHo0UXgvck0xVWRvR2tSeExX?=
 =?utf-8?B?REI3YnREUHhrRHNpdGxCck1mbVVCVDV4d0pVZHArVi9GTEV0SFZnQ3VOMGRO?=
 =?utf-8?B?c1YvdHc3anl5L2l4UGI3VHlaQ1ZtdzBxc0RkTDNVb0pMSE9qSGI0TU5HS2ox?=
 =?utf-8?B?emtxY3FhSGpmR3NJQWNCbitmeHNGS09wbEpPZGx4cFA4b0tOWDNaVEV1a0Rx?=
 =?utf-8?B?T0pqMUNxZ1R0Vk9pR3hVN2FtUDdVMUxGWXNpc2pMcDRYdFZGK1RoVnVjUHRj?=
 =?utf-8?B?STN0ZXluWGRObXlMY0ltVUE2Tk05cGVrYlh3LzNxcW05ZGRxdHE3ZHB2dTJm?=
 =?utf-8?B?djJTbStjdWM1VEQ3Y2E3Nm5FVXFjcE53bHQ4WGx2RUdqMnJkUEZaUVoxR3ov?=
 =?utf-8?B?VFE4bW1XNzZDUGVZMVhZcy9JZXBIWVUyQkJxVFJwQnFvN0crSFVyZ2VvTStY?=
 =?utf-8?B?MXNyZ21PWmQxbldzTXdTYW16cE5VbzRPc1ZhMUx3UjJiN2x0VW5jWkdaL3N4?=
 =?utf-8?B?TVMxYXlVb0ZsYlJuK3JNU3N2VkhpL0hlNXpuTmdteFlwQTF4L3NBS0NRdzFw?=
 =?utf-8?B?RVczOTA2dm9la2JJUm1KMFNyQm5WSU9SZjBURi84K050ZTArM1V1S3crZU5B?=
 =?utf-8?B?NFdqSk94M21RUXhFN3IrSlNaMXp1Z1BzS1RnWWlFYkNNcnp5VGgzRTdOQVpn?=
 =?utf-8?B?MkxVMTl5YlZCY2dLYmMrYWFKdWFyYjZaNUhaNlJuOW52TUJOYkpHczczc0RP?=
 =?utf-8?B?eERVaCttQnlYMUZ6UGEwNDJEdmJUK1dXOEcwVGhodmxMNmtQZm1VVm02YkV6?=
 =?utf-8?B?MlR0dUtnYzZoY0srUkg2WTJ5cDV6NWJqbEk2ZGhmNVFXR3RkcTgzVm82cExP?=
 =?utf-8?B?Njh6MkJjVU5XUUt2V0Z3YkFiTGRscm5HeWpFTW0yRHhCUkNkdkxERGtwMGl3?=
 =?utf-8?B?dFRVckJWV3R1NWZkcU9OQyszQi92QVJpMVB4R1dEM2sxQ05FSW11ejVCbGVj?=
 =?utf-8?B?N21EdlhRUWcwc1JnV242Tm8zY1VaUFpsamtRQ2dGWkRHMG1FbXZ2bFB3OTY3?=
 =?utf-8?B?VkdhelZDRUVDQ2l3RjAvUGM4VFg0ODg2bnBZUThFZVprcmhGYlRIV2ZLUnhj?=
 =?utf-8?B?b0RZcDFyWGRmSFVxaE9FOU9UalB2cTZjYTh5Q1BHTjI1cWVSdloyMFJFK1JI?=
 =?utf-8?B?R2Fva0VBNUl2MVcxOW5NbHYrV0hwMDVyK3Vlb0hHTE1vTUxlK1lKV3dycUw3?=
 =?utf-8?B?L0VVUWxlektvT1JPd0JSeFBJd0IrYzVOdUs1OEhpUzhZcjBlemxVVzdTdXZJ?=
 =?utf-8?B?S1U4dk9tUjVBQ0NPVkdmeTM4NXFxbE8wWTBkT2NaamhSaTkvdkVRRFdSZCtj?=
 =?utf-8?B?d3NSeldVNWRUSUFuWGZMRUtIajM2TkU4dEVnNDE1S0N0c2pCMU80QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401783b2-b344-4c7d-2336-08de4ebb61f6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:39:44.6212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFSFiIKfveW3F6cZZ8Zk8gqRJOf+/Jr4A1Dw2exTM5altUHZHatP3ZKMWL0qBzn3u+LT8ACk0T3a2LncbnHLGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529


On 25/12/25 09:26, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 2025/12/23 20:13, Sumit Gupta wrote:
>> Extend cppc_set_epp_perf() to write both auto_sel and energy_perf
>> registers when they are in FFH or SystemMemory address space.
>>
>> This keeps the behavior consistent with PCC case where both registers
>> are already updated together, but was missing for FFH/SystemMemory.
>>
>> Also update EPP constants for better clarity:
>> - Add CPPC_EPP_PERFORMANCE_PREF (0x00) for performance preference
>> - Add CPPC_EPP_ENERGY_EFFICIENCY_PREF (0xFF) for energy efficiency
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 35 +++++++++++++++++++++++++++++------
>>   include/acpi/cppc_acpi.h |  3 ++-
>>   2 files changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index a4e89fe6aab5..403ee988a8c6 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1556,6 +1556,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>        struct cpc_register_resource *auto_sel_reg;
>>        struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>        struct cppc_pcc_data *pcc_ss_data = NULL;
>> +     bool autosel_ffh_sysmem;
>> +     bool epp_ffh_sysmem;
>>        int ret;
>>
>>        if (!cpc_desc) {
>> @@ -1566,6 +1568,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>        auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>        epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>
>> +     epp_ffh_sysmem = CPC_SUPPORTED(epp_set_reg) &&
>> +             (CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
>> +     autosel_ffh_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
>> +             (CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
>> +
>>        if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>>                if (pcc_ss_id < 0) {
>>                        pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
>> @@ -1590,14 +1597,30 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>                /* after writing CPC, transfer the ownership of PCC to platform */
>>                ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>>                up_write(&pcc_ss_data->pcc_lock);
>> -     } else if (osc_cpc_flexible_adr_space_confirmed &&
>> -                CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
>> -             ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>> +     } else if (osc_cpc_flexible_adr_space_confirmed) {
>> +             if (!epp_ffh_sysmem && !autosel_ffh_sysmem) {
>> +                     ret = -EOPNOTSUPP;
>> +             } else {
> I think this can do the same thing:
>
>          } else if (osc_cpc_flexible_adr_space_confirmed &&
>                     (epp_ffh_sysmem || autosel_ffh_sysmem)) {
>
> and reduce the levels of indentation.

Thanks for suggesting. Will change in v6.

>> +                     if (autosel_ffh_sysmem) {
>> +                             ret = cpc_write(cpu, auto_sel_reg, enable);
>> +                             if (ret)
>> +                                     return ret;
>> +                     }
>> +
>> +                     if (epp_ffh_sysmem) {
>> +                             ret = cpc_write(cpu, epp_set_reg,
>> +                                             perf_ctrls->energy_perf);
>> +                             if (ret)
>> +                                     return ret;
>> +                     }
>> +             }
>>        } else {
>> -             ret = -ENOTSUPP;
>> -             pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
>> +             ret = -EOPNOTSUPP;
>>        }
>>
>> +     if (ret == -EOPNOTSUPP)
>> +             pr_debug("CPU%d: _CPC not in PCC/FFH/SystemMemory\n", cpu);
>> +
>>        return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> The code below is unrelated to the code above and should ideally be
> separated into a separate patch I think.

Will move it to a separate patch in v6.

Thank you,
Sumit Gupta

>
>> @@ -1609,7 +1632,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>>    */
>>   int cppc_set_epp(int cpu, u64 epp_val)
>>   {
>> -     if (epp_val > CPPC_ENERGY_PERF_MAX)
>> +     if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
>>                return -EINVAL;
>>
>>        return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 12a1dc31bf2a..2860a0252313 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -39,7 +39,8 @@
>>   /* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
>>   #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>>
>> -#define CPPC_ENERGY_PERF_MAX (0xFF)
>> +#define CPPC_EPP_PERFORMANCE_PREF            0x00
>> +#define CPPC_EPP_ENERGY_EFFICIENCY_PREF              0xFF
>>
>>   /* Each register has the folowing format. */
>>   struct cpc_reg {

