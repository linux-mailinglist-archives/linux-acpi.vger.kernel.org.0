Return-Path: <linux-acpi+bounces-20066-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA86D03672
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 15:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C6FF301BDF0
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04EB4D3DD0;
	Thu,  8 Jan 2026 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LlCk6o3g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F24D3DA1;
	Thu,  8 Jan 2026 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880885; cv=fail; b=cIX0ubKv+pJhZDRLAKYNdr/TIBtZoOMHtaCDwX/f4r+zO7MNgJYXRH+YMXWc+uZGel8LEaEUT3wsb5FYXGS7h9GeKCOPmF5uL2Hj1nczbKCBxT/tdB8yRbmbPgemBQQYfK9fHDsGJJYg+cLfOCgxrSJogVjaFY8/OHFe37nZH6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880885; c=relaxed/simple;
	bh=oaa5C+JgKe6AC70HzLNVtnRpcV0NI6Ng1FsrucUdqYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PeohW43z59yM9W4Cocms2/u23Chnrgc/V+7bW6NxJX0zsxZ464htL1gemSpWCbSThnf9jTP3OrQNFYjlUtuqHj91RWZEHcP/p8wT8sE7YUtXnVhDk/64ayKIGGspCKdCWSn6rC2SR0JJjdL83t1O0N3hoLte+Op0C1WmhCuF/wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LlCk6o3g; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpzs699+b1MOgq3fh0UXynqcVPZdagrARmcfkHcRZHda+ZJFcttKwC9oQxnZuXGKWfcDpRQVeT9yIRUL0RRBTLkFuN7upRxuJnj9ryku7x9JmtUSgjL5nNMgRvRuJQuRveMVmuBf6wbmJKrxuHVhh3jHMuuq+9cPmwABlcwPqbtyRRC5NdveMuSTOQdJb1S7gs/0FIbCld153yfqFC7NCYwKm3pEbprNCj6KEp3FqXGUlSECKGeaqvB22zI++GXDFheHM1u2TQYhbX1EBiEPSAMUipUrcjbXYMQrl4e1DYDXOVwlR0O/DBAhFDO8jRF9DriBHsKLhPGrlP00iPoshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYz0nT8FhrCh0JCQYceNCwFBYvkYJJpmqWkpuYHR32I=;
 b=OTiLYjWuH5J/Dj/BCT3q6B9XfZBvJf1AYGbJ1ZGMRg6y2y+O9i2x9s++9jzrdvo+Lrvmgvlz31aemWlhYFHBe0WZLg5zYVaR58MzH8DrX551kCjdnnw49KOvJABUg5bfold+gIppizkwI+SCodolvq79Rg38RGdeHuYi4Wx5xN/4RhXVBuOJ33KdxqqlM+m3Hc+3RFjLGwszcC3N9CyoA1iw/57WWdXq6A/aoycbS/rI6uT1BP604P0AT4rWXvVOlYtIAr9MdbL1nOUN2Z6KBIu6hnw0j09EQlPCQxF0Q1AxvqDULiwDdHacPDjwbT0JUTD2ZefqJoUsiXJ91abmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYz0nT8FhrCh0JCQYceNCwFBYvkYJJpmqWkpuYHR32I=;
 b=LlCk6o3gTA67aTrcLhKRT3suBHMi0mS/3Xfaiy4MnE7fNIQy+LGyYF1ZFhpppkuGqGIWCLOKYh/TiergjTimSMWJSTdCqo6pZAoAM6LTMvbDhQw2ijf2EVUQQhRlBzyNxzIIyQVnp+RNQWd8Xaqb5KD9ua0/euVbFJlYt0Gw7ZYX7HCp3bRCFl15zNlXmcdfxY8POGrmhlVta/mqaeo7kRxB1XDyTnaV7aKGDeT7JnIlzEgunom+tWee7Fjmo0HZ9Mb4NymWOdse25UhS6BcYs4rBqe+A/tl3e7rfptEyjLtjVgFlN3cQAKwf95tFYcH+py5jhrOeF7yO82JmlwIYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 14:01:21 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 14:01:21 +0000
Message-ID: <d7639de1-a5b6-40c1-9d12-1606b558997c@nvidia.com>
Date: Thu, 8 Jan 2026 19:31:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] cpufreq: CPPC: make scaling_min/max_freq
 read-only when auto_sel enabled
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
 <20251223121307.711773-11-sumitg@nvidia.com>
 <66e5ccea-9cc2-429e-856d-e3f420a8b2b2@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <66e5ccea-9cc2-429e-856d-e3f420a8b2b2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::15) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c42e62a-3044-4780-810a-08de4ebe66aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3NxalZFZnpGVWR5L1JKbHRwcGxrcWpmNWlKWHBqckJJcnA0eEw1cVViNElr?=
 =?utf-8?B?aTl2bTdCZWVKRGxla0RSa1ozZjdWVkJqVDNhTWcyMXB5TW95Sm44MVh0aUxx?=
 =?utf-8?B?Um9aZUJ3TEtXRHlPeXJLQTcvWkxlL2RKalJpMlc3SG8ybzlKNHRRUXFQVVEv?=
 =?utf-8?B?NG5jQ0J0MExiZk5YeGExQ1ZidWQrMGxpNnF1eWU4M1FRQ3oxOUNUWDJjL0J0?=
 =?utf-8?B?YXBtUWV0aE8vM0p6WXUwUGhmUnJwL3lpL3dCWmZ3d1o0RmJNTGFVcmQxUDBn?=
 =?utf-8?B?WS85SlcwSHFld3ZxZ2VaRzZhUmhkSFFrNy94V1phUG0xaCt6dXc2RkNUdzRN?=
 =?utf-8?B?amNTRzJGeEltVTRNaWt4RDFaUjlwUGFmd3VMTlN5cUk0V1hTQ3U0RmJyQ0xJ?=
 =?utf-8?B?VHhja1hkK0hvbFBaeXlhYmVTVUNEd1RtZ28rMDBqR0hiV0hRWElKWDB4TGdz?=
 =?utf-8?B?VjFoTVBCTFViWk5lN093ZEhmT1lFb1NCeVNjcnd2TzV6N2RLZ0lQUldSdVZN?=
 =?utf-8?B?VHR6a3AvYU05ekhZQVRZTWlJcENKMnlzOEpickd0ZGNBUkp5M1VUMUF6NkZC?=
 =?utf-8?B?WUxCVUhkU3BiSFhBcWV2QTUwaEYyQ1pwQWRpTXlGSXp6dm1raDduZ3N0NFdH?=
 =?utf-8?B?QkQrNFVtUjFZQjIwSWxXbjFoWVRpc0l2N2R6aThZeFZwTDVONEowZnhmd1g2?=
 =?utf-8?B?MmxwSDNocERlL25PbzlQVXlvYUZUc2hXMWM1NzArRHpPRERxd1ZEcjZGVzRQ?=
 =?utf-8?B?d0w1akFHRmJnUFQ3SU9jU1h3eHNNcnRhamp3OS95L2sxNE5TT29RSnBXSFE3?=
 =?utf-8?B?ckpZOWRlNnhGZlpuUlcwYnpjckRmajBRanJqTTk0Snk2Y1hIY3NSSEJueTFL?=
 =?utf-8?B?SHc0OUJtYXZEVG1rZGgxT1prcXVuSUpTZmdTNXNQbFV5TTlBSXZMdnFpTVN1?=
 =?utf-8?B?ZW1VM2ZGeU9nRGtOYWVlWDFMK0FRUlU5YlBBTzZQSHZyKzlZSkVjelJ6eHkz?=
 =?utf-8?B?QTd0Sno2ZmlOY0M5YjJETGpSNlpObjZ4TU8rUENoRmJITnBZNjk5R2EveDhn?=
 =?utf-8?B?RVBFUmxjcklLdTZocVY4Y3BmdHhVeDYrVnNHQjgxSVRtUWdyaTk0bDlRaXJa?=
 =?utf-8?B?MDNGRHJyMnJuRk4zbDFXQWxtbEx2OXB2YWJaK1hDQ1J5UUJnRjE1SjEvTEdY?=
 =?utf-8?B?RkNCOHhMa0E2U094Y3l5ak9NRm1rbVVoMXlJTWE5TGsvNTVLK3A2bi9wbTJj?=
 =?utf-8?B?WWRSbnMrRGRYYmlLcDF2em9DL0dwdmdIckNjT21YTWdpK1pLR0FoSWUxMWxu?=
 =?utf-8?B?UVV5bEwrZEhCSTBvaGpnQWxJd242aTRabEN2aUkxTFhZWWI3Y0xMa1VKSFBK?=
 =?utf-8?B?TlBvMDRtWmhucjRZaldIUDB2Wk93d3NlYVNYQ08vR2hvVnFFczFTZVFmWXQr?=
 =?utf-8?B?VU5SbTZVUkhVVzIvS3p6d0lnNWNEN25jZTVScllIZzh6dy9ueHF2a0ttWS9N?=
 =?utf-8?B?VnFDVlU3Y2dmNWpCWVFoWUdkdlBhdjhzMmU3NFg0Y2Iyd2ZOK3Erc1JlMjR6?=
 =?utf-8?B?UVhTTFBtUURQS3k1QUUrZlMvUU5GQVZ1eXdmVFlDaXNCdFJBR0s0a3hjSzFV?=
 =?utf-8?B?M3NjQW5PZDFjejNXMSt0TytDaTNBa05GRTZnOHM4N1lKdndpcXZLbEdGQTI5?=
 =?utf-8?B?N3hlVmtRd0thNnF3Wld5TWVraGJxN2llR3MranR4eFJHczJwYWRLTE1vUkpU?=
 =?utf-8?B?K3ZVdnJYSnliU1gwQzZVcWJvaVVqMWpqNHh4S2ZzSUl6V2ZTcytpU05IWVF2?=
 =?utf-8?B?M2h2VmZhMHkwd3BLT0NEVklaZ2daRFgvSXhHVVJPbi81dVhRVzRsT0FNUWtH?=
 =?utf-8?B?Sy9Nclc2T2xOajZjbGpYRk82VlhKVzN6SnlpK1Z3Z1FrMUlETUpsbzZENCt5?=
 =?utf-8?B?d1pkVXNSbERZbEdZR2ZNMENReVBob1BmWFlVMjdpQ1JxUUlGQ2lQaGJhR3lT?=
 =?utf-8?Q?WxDGpKoN0nDHh8KcerKg9cugEtXjFU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmxCc1BzbUcrVENiR2syWHRkMTh0SDVub0laYktFNVZrV3Axb1NEVVhvMU1Z?=
 =?utf-8?B?bktHbFc5RDBidzk5RW9SS1dzWlQ3WE0yZTZUaXFFRXpXOFAwTlVhS0dNRFZT?=
 =?utf-8?B?Q2FjWEtxTXZDbHM4WCtlVk1yc3hHblZKYitNTHRmK1IreHlnMFhQU2RGaDZY?=
 =?utf-8?B?dkROdHU4bHEzSlNtNktUTThIdTVBRXZLY1FCK0VaVDN0QlVOMTVsU1Jqd3c2?=
 =?utf-8?B?bkZHZmsyQ05NU1kwNzlhdnQ5cU43VUVJamorRkoydklhSlFlL1h4R2RITlFr?=
 =?utf-8?B?US9La2hCWkVOOHZKcGE5VEZSZmVtMVQ0S3RFY1hPT3ZRNEpTOHdNWW43dnBy?=
 =?utf-8?B?Sm9NdzlOejAwTFhxc3JWS0xFUzZaSFBtTnluMDBBQlA3R2pOSTBTUmFNQ0xG?=
 =?utf-8?B?Yy9OcHpvbE5KODg0dm4rMnpFc2xFdWF4L05ZeWV6MkZhR0xFeDlPTmd4eE96?=
 =?utf-8?B?MzNwLy9STGRCOUtyM1FISEFhQXF3RmhhMENVS3p2OFcrOTZQNExsRnBOSWdM?=
 =?utf-8?B?ak9yOEhxVTFuMGxZdFdqT3RSZy9pTEQwam1iZHZIT1JMY01admxpNEZjWFRY?=
 =?utf-8?B?V0JNWkNwZS9FNlVpUWxyNE9qTVBqMFI4endYd2g3WWFpaXRPQ3BqUisxajNG?=
 =?utf-8?B?cEdFN1cwRFhOcGJOUklacjVBS0RaZ2ZvZit1cXE5aEZ6MmNTY0hQWENaZ3pj?=
 =?utf-8?B?b2t6MTRnS1lkRmM3NnlSejlXbmdGWGVhU0NhSTNWamNxK3I1aVlVTllYV3Ft?=
 =?utf-8?B?MEtnVGRZK2t2YWdqMFV2d05abEpvM2VveGxuYmdiQnV0aGFlM2xSVHd1ZzNP?=
 =?utf-8?B?Q0NzVENMUGNLTDVxSEJveXc5TTV3ekdZZG0ycnNhcUo1MkVSVnZUdXBEb3BV?=
 =?utf-8?B?NUcrKzU4bkNxdkxDMnVTNFdINDI0b2grWmJlQ2dEcVVHNUFLQlJlbHhNajVo?=
 =?utf-8?B?TVRvMkdyb1JMa2UwWkpTRzdjTGJhU3ppdXMvU0VFV2hjTDkzc2Y0bTJSWTh5?=
 =?utf-8?B?ZHN3KzRERkIyekRzRm0xWUc2VDBvNG0yK2R3RUdTNzNhWURQWHlkeUZDUVFp?=
 =?utf-8?B?RmxRcWxURzZhTVhZRHNSa0xEN0ViczdqblNta2xRd3NodGVIaXV2ZllNR2FL?=
 =?utf-8?B?RjQ2eXM3VGtqZzFEMDBrUnYrK1BzYnJkaElJUkxlaFRJU2Y2R3o0ZDJUdVlY?=
 =?utf-8?B?QjNvOVNabVl1YUJlcFU0bG15Q3Z2TzBBbUkzRklKNVNnQ3ptdzQraUIyL25U?=
 =?utf-8?B?Z1A0SUVDRHY2TVpyYkU3M2hGM1VrOXNGbWlBci92WU03MU5LMU5mTDRkR2lT?=
 =?utf-8?B?Znp6Tm81UUY0MHdLbW5RKzFTdEFiM2VjcUhXU2JIMXBYQzNJWlVoTkwzUVZq?=
 =?utf-8?B?QjZEYWVubmdxS2dLdFFMazFmZ2tCK3JURmF1ZWVnM2ZVK2tIcHdoZm1RQ2c2?=
 =?utf-8?B?VDF3aWMvaDM2WWZBWDJadHJRQTVHNmN4em16ZWY2Tmh1T3RxajdsNklIbmlL?=
 =?utf-8?B?NG1YdXlLM29WdVlYT243cjdLVmxwNU9lbkNKS0Q0TFVJeU9hdVJZRE5YSFZi?=
 =?utf-8?B?YjBHNE9reENKTnUyVjdXR2Q5a1U5a0NrYTdmWHl1UTFuZEs0Y3Jvd1pMMjNx?=
 =?utf-8?B?OTJ0Zld1djI0UGZRUVVnRnVHYWhVazdhUzIwaEFodjRqaVNuR3BxUFdocStQ?=
 =?utf-8?B?OURrdFM2aGxtemJIZklTWmhqRTNmT2RzYSs5UzFUTUo4cGFMMW1ZbkJBYk9z?=
 =?utf-8?B?cXZsd09JV3F2L3hxVDN2L0pPU2c5aHZaSGp0ZHhZUjQxUE1VVjZveW03LzEv?=
 =?utf-8?B?R2tvZUNVcnA0KzJKK0d6Z20zeG5mU04xelNIbWxxUjNiYUpvaTBLMGJ4aGF4?=
 =?utf-8?B?QTd3TERnWVNIWTh0RkRmdktXb3JSUTRRVXBpSjY1cGxKN2R3TnFCU0FHb3VO?=
 =?utf-8?B?aHFQaHo4RWlWcFh2SjdNVDg5NkpsYVdwSFltSHhNU3pabEpwWUtMZjRXQ3Fi?=
 =?utf-8?B?Z2FuM1cxTy9sWjR0c3ZxK2F5T3ZKUldqYkJUdFVpVTluN1Y2dGhGNVRwZXFH?=
 =?utf-8?B?WGhyc3BWTXR0TWluaDdOZGtjbmRFbTY1MGVOV3pEVHV0dWk0emQwSjhQV3JW?=
 =?utf-8?B?WEhqUW0yWVUvUnNsYVp3UFZSeTFEbk1ZaGRlR2JVc0V3bFV3YlB6Mi9zaVBs?=
 =?utf-8?B?MUFUOUhVd0sweCtlRUxuOWs5b3BPWDhMRHZCNnEwcUdlUm1kNEdMQVF1TG9y?=
 =?utf-8?B?VjNyb2dZYWtQWVFDY0M3RTJldi9wMjA4UU53UVpxRStSbFRwUjJsN0poWmV5?=
 =?utf-8?B?dEZ3ZHNtM2hwSGw4RVZLWi9mSkY1N00rTjJwODJmaXVmcEtWWHlFZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c42e62a-3044-4780-810a-08de4ebe66aa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:01:21.0589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0Q976U/ZbObpW3kzOD0F90oeiJqfnT2gS1OgHJ85FRRPhwg5aMN3igXPJOhFBJ319ch9v/v/5jJBNos7iBgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415


On 26/12/25 08:56, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 2025/12/23 20:13, Sumit Gupta wrote:
>> When autonomous selection (auto_sel) is enabled, the hardware controls
>> performance within min_perf/max_perf register bounds making the
>> scaling_min/max_freq effectively read-only.
>>
>> Enforce this by setting policy limits to min/max_perf bounds in
>> cppc_verify_policy(). Users must use min_perf/max_perf sysfs interfaces
>> to change performance limits in autonomous mode.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 32 +++++++++++++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index b1f570d6de34..b3da263c18b0 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -305,7 +305,37 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>
>>   static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>   {
>> -     cpufreq_verify_within_cpu_limits(policy);
>> +     unsigned int min_freq = policy->cpuinfo.min_freq;
>> +     unsigned int max_freq = policy->cpuinfo.max_freq;
>> +     struct cpufreq_policy *cpu_policy;
>> +     struct cppc_cpudata *cpu_data;
>> +     struct cppc_perf_caps *caps;
>> +
>> +     cpu_policy = cpufreq_cpu_get(policy->cpu);
> Better to use:
>
>          struct cpufreq_policy *cpu_policy __free(put_cpufreq_policy) = cpufreq_cpu_get(policy->cpu);

Will use this in v6.


>> +     if (!cpu_policy)
>> +             return -ENODEV;
>> +
>> +     cpu_data = cpu_policy->driver_data;
>> +     caps = &cpu_data->perf_caps;
> cpu_policy, cpu_data and cpas are only used in the if branch. Just put them
> in it.

Can move caps inside the if branch.
cpu_policy and cpu_data can't be moved inside because we need
perf_ctrls.auto_sel to evaluate the condition itself.

>> +
>> +     if (cpu_data->perf_ctrls.auto_sel) {
>> +             u32 min_perf, max_perf;
>> +
>> +             /*
>> +              * Set policy limits to HW min/max_perf bounds. In autonomous
>> +              * mode, scaling_min/max_freq is effectively read-only.
>> +              */
>> +             min_perf = cpu_data->perf_ctrls.min_perf ?:
>> +                        caps->lowest_nonlinear_perf;
>> +             max_perf = cpu_data->perf_ctrls.max_perf ?: caps->nominal_perf;
>> +
>> +             policy->min = cppc_perf_to_khz(caps, min_perf);
>> +             policy->max = cppc_perf_to_khz(caps, max_perf);
>> +     } else {
>> +             cpufreq_verify_within_limits(policy, min_freq, max_freq);
> Why not still using cpufreq_verify_within_cpu_limits()?

Will change to use it in v6.

Thank you,
Sumit Gupta

>> +     }
>> +
>> +     cpufreq_cpu_put(cpu_policy);
>>        return 0;
>>   }
>>

