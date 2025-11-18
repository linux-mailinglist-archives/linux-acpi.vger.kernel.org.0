Return-Path: <linux-acpi+bounces-19011-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 024DDC68E58
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 11:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1901B28AB0
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 10:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D251D325704;
	Tue, 18 Nov 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hTxrcesd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0232690D1;
	Tue, 18 Nov 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462830; cv=fail; b=BdB1819HHDc0q4vmBEDfRPocJgwzy1A6bcYFJPud/fTbWScM5DPBRpdvHYoPKniYm9JN1P6NE64RmQC++yyloSsl28pi8L8FsXhzT3MNdzSBRdHcZ3lyi22zUtscAdmMQfAKLRx55IM3chvXjfsE6XnOPSGPyonnDcq/ZTj1KnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462830; c=relaxed/simple;
	bh=bF1L3L6VQhCc9NmGAjh1h3WsMLPEFzx+hRGXTQ3KFOY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bppnZAjHlOoIhb7s4V6ikXZP/aA2azRn+l/COVFIcGnR58yAyYQhmP5gsOpo9Wsau+k/NT6cu4n9wWp9TXb5hmhvC/KbFP01SF/NopjQuOHI1ZCJld/zu37JV6P+E6mcqYpIqOj92aRaOn5Dskqdouoi5ZxspSFHGIxA8wB8m5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hTxrcesd; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2u6K+NtKqrWchVXj6ZHr6GGleBoDk5aN6E/St3sIyzpVUL6W7PZfMGgUYM0NjDzXnghAYHLFQJNOHd+WnoHg388unOADyxgHnKfTnyQ87c5KJCaw4kyLF15tpJU6HogSbL2e4nWSL5hcGJmWcLPpc/84EcrkM4IyuKfQcIPCrgLPOepbKJNPcnwXhWBJJLwsTV5J26GdhdfV5Eq9dDxC/4ogOTB+VbGn2bKytzoXArmomFkT8FQ3Q9hTs2k/PlIiR7TPZ8OpKfl6xuIpss403GNgi7voTLfcIcZo3O4n5+750bBWucZ3RhtxD912utzpGEGfNBN7BgdEfwWk+Y6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSy8Dod6JL0v1k/RwwlQawuMNNiUKvQ13GKLeGsUHQE=;
 b=pw9+kkrp/NBnyEYm5R0QSmqvbxoM2y+kKCx8nYuD3pCFHdJxGy5KOKjoJBco+liYGXwLyJdcEYeXPiXiehn2uB+GGhj1E9Nw6ZqNPlflmMsPkQRcoKXpk6RWF4aZEHFim+AILHU8g9kXSCLsksH5Geo8IZmGqSkvnh2gulkaJ66SBGTPBTXYM084gDpJqBpzFnntqOhNh+DNBKfuBDp7RJIO4d8S+t9HQpO+PgLGUz1UphwNOJufOiHtBlhy8XGvLT8GiNBH5XLS4Pm7X3bZrdT0ZPq/z2cpOukEYAEd5Cq+DeSexeTVgIBfWLWjctieqzlaHbX17mjcYACQuj3RDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSy8Dod6JL0v1k/RwwlQawuMNNiUKvQ13GKLeGsUHQE=;
 b=hTxrcesdV8u7JN527Lyz67dIafi50hmBnhx5JI+peGqXvMgWvFNfjEaOVtRGmKuy+uI8tInIgA0BkTD+JUfsAsXPwrcIr5lIgLqEOupGjMgWJ4t6+HNYfR6uG+dDDzLPZwlxKk1qeWzyNjeHyGIuHxwHsxemCfD4fTPmrkqQrNSTo3Ppo0iJnC4D7IQr6v6BU3YE+1BDbT2hv8jDIJzkVUg6FZdn3/tNgi76JRr8NMzKEjsWev3NN40kgFthLk/Fd0pdLUSHN12+TsrNJqA26NUDscy9oxqNzgiNHQvaHD+WzsqANnYm0cKObM9Jl+nEXu7/K6H5Z5xDcDS1ittLNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 10:47:06 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 10:47:06 +0000
Message-ID: <dcf18694-515a-410e-94c6-b79039e31358@nvidia.com>
Date: Tue, 18 Nov 2025 16:16:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
 robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-7-sumitg@nvidia.com> <aRXR7yKyG6l1Agfq@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <aRXR7yKyG6l1Agfq@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0207.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::6) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 783444c6-3821-4e28-e206-08de268fd0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlgwQ2Z5TElHRWVka0pVc1pIOGZMQXIxYUxPakhwWUZUa0NlYlZUaWVQeWhW?=
 =?utf-8?B?RFl0UFVMNEFpT3Q4dDNodS9pMnJtZkc5WDRhQ1hyZEgwRDdrdndyb3JPT1Rl?=
 =?utf-8?B?SDIrdkhPVnlHNmtWbThiaUhlWFVWZGdreEh4eHNGSkl5Ylk5L0QzRk1zU2k2?=
 =?utf-8?B?a0ZpUUljdVRudTJHQngyaXF3MkVNMlUxc2xMZHcvU0wvUGdxWlJ0K3FOTmFG?=
 =?utf-8?B?dWhPdkFna1FGd0JnUHRpbXhxc0ZqYkhCYWVZTThhdTNRSHlsRDJUcy9RbTQ4?=
 =?utf-8?B?NU8wUkNVMitvV2k4NlllNG8zYUp1bHNObllaL0UxRWJ2ZHBHWlROVDU5MFBL?=
 =?utf-8?B?RW80VktjU1hwTy96cnVZd3J4ZkJ5b1Y5ZzU0SDI1SW8rZGUxa1YyTkEwbDlW?=
 =?utf-8?B?eTlteitNMjdyMkdCSnBrejlQK3padjl6aTFxbHhWREtBR05qL3d6a0d5WmJK?=
 =?utf-8?B?aG9wUTZLZDZhY09UdnZXL3lWMFZYNC9nZEo5TjcwYVFPWlhqaWVhc0l3bUNo?=
 =?utf-8?B?VFcxWlllaUE3dHpiZ0ZrWUVkQy9SUGVyQzNvandaUDIzdHcvNk8zSStvVmc1?=
 =?utf-8?B?bUdmWU9qakdvc3RWWHM2YlZtNThucjJyaGQya2wvOUNwc3dERDZnNnNncUJr?=
 =?utf-8?B?QXhEV3lqWnN4dGtYRCtKVEN0Vjd5Mk1VN28yTFg2SGlpVFlIaExKSlc3Tjcz?=
 =?utf-8?B?Z2taUVhMS0ZrT1JhWTRTQitBQU9PUkxlT1JlTm00SjJJL1NrdGJvRHBCM3VF?=
 =?utf-8?B?R3ozQnZMSlBFT1p2cDQzUXdXenZsa0J6U2hia1ZucTl5Y0ZiRzBJOVNjL1hs?=
 =?utf-8?B?TFNobWhWN0UwWDJkdXB3QVZzZkhrMmxDUmNCaVJmR2ZMMDZHYlh6Vzhvem93?=
 =?utf-8?B?aExnTldoYmJkbVhGc01Ubnd3c0pZb21QNmtCNWhqdjBTQ0phc3BCZkxBN1ow?=
 =?utf-8?B?WXZJQmFTdmtBR0RvRkh2VHpNdC9KdXd6TWdhUnh5a3B2SGx3R0ZRQ0FzS2da?=
 =?utf-8?B?aFVtbDZmOUhjb0lUNlF4ZXlpNnRqOWJINnk5WmljakgvSzhvbjgxWlhEeUwv?=
 =?utf-8?B?UlRGN0o3OG9UNGVpaFFhQklRVk0xdG44R2JVSFlnK0h6ZDlLdjZ6WXB3a2tk?=
 =?utf-8?B?UU5HMHNQdEo0RWY5UUR3cld3TmFHY2lObzZwVU1MdUZnd3M5Sks4VENuWUgw?=
 =?utf-8?B?a2VQOVlxUFZ2aVhYRWgwZWVMRzJCUjR2UlB5b2dBZjJVZHllYXR6b2I5T1Qz?=
 =?utf-8?B?OTlEU3FublA0UVN6TGFrTkhRbDdzWGpOK1VBaWsvekhaRU8yaFFrSzRVZTRn?=
 =?utf-8?B?U1BoSEIzTm1zQ2FyaEFOa2tuaktndTZMbXBHWldpM2ppencyQ0pPaE13Y25t?=
 =?utf-8?B?OHFlUkpoRnE1elNPcE12NndWVGQvUDB4Sk5POWsydHZ4czRuclBRMTNRTEgw?=
 =?utf-8?B?bEJrQ0pMSXZKaUExbkRYODA3TEZqSzZaQXladTlJQUFQTXdOSTRkSkxuV3Zs?=
 =?utf-8?B?NWFvNkw4NGZ3RENtbjFYbUtGNXcvbytUcnJhYzl5Y1E4K0J1eEk1WVBQNkZq?=
 =?utf-8?B?UmZpOGhiQUsxeWIyTFR2VDVNeW5IUFBGakRNNmlxTFMxdnNCaXFZVnZoY2tL?=
 =?utf-8?B?cTFMeVMxQVhVWTV5Tko1WjAxdHpFNjJxclczdkMwVGtRL2s0cjh3ZGlUdXZJ?=
 =?utf-8?B?SDBiakJXc3h0RkdFaG9BMDhob0diMUhMYjRJckFHeFIrOTNNWHlNSk9nUWox?=
 =?utf-8?B?S2hkV3F0cGU5OE9FekZsRTFJZnlUU0xqeFRjQ0VJVEtHVFMyRnpsVHJHV0FH?=
 =?utf-8?B?NXZsMVowc0FBZDUrVkVWRnVCQ2dYZFlBOVZUSDBEeVB5Snl5clY2bzZTb1BW?=
 =?utf-8?B?NnFRMC9oM3FCck5qKys2MUxIb1BuY3hkazNGMnVIdUhFcEZJL1pFWThSSEtB?=
 =?utf-8?B?cmlWTmN6VUhYV0FkSFY4Q3doQ3BZU2NHcTh5UTVzOThSbHA0VlZkcXA5V3o3?=
 =?utf-8?B?L2preCttd1V3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NW1SWEZvdnpTWCt3TG1rUUFiUldaNk5icFdnWGY0QzAxSHVpb3g5aEtlZDVt?=
 =?utf-8?B?RVUySlZBbUI3TDF1RDdOV1cvSmJCcVVPaFFNaS94SXJ3YWNYMUdKWU1VZmF5?=
 =?utf-8?B?Y0RTclRicWJqdG80VmxMNE1FejlTWmNEZ3FHR1BFazRNV0xJT2g2R0RJMkht?=
 =?utf-8?B?cEVJQVpjS0IxVHl2bnVCZ0dnbElPeEgzdmg2aDM2WEd0eWxDemhHOFRLa3pt?=
 =?utf-8?B?bmpJbXNoUjJiWGExclltc1lSMkdLR25qaU1JL3llc282UHo1VzFhejAydm9P?=
 =?utf-8?B?U2psOHdvM282amxEZWxxd3V4bFpTMS9TcTNwTUJJS3hpaTMweHowa2JRZjVO?=
 =?utf-8?B?NTYyMWxJME14eVRYYjI3WXludEwrMjRmM1ZqeGxLalQ5SmNtb2NHRXZCZ3Fw?=
 =?utf-8?B?NTNZdTZiTW9iS0JrRndQbnlWSCtSTkJXRkJJbVRrRmRrVjB3M1dVMWkyTXhn?=
 =?utf-8?B?UXB4aWJVcDBFN2UvQ2MrWVJ4NzJGdk9QV2VMOXBkd05Fd0llK2dvYWRTYXJt?=
 =?utf-8?B?ZFBzU21iOHJBajAwejByV21yWDdnbllCTjBsNlJvdERTVkpwUEZKVDArTWJR?=
 =?utf-8?B?VUdMQmZvMDN0Y0p0TVluVGFydW00eTFKYWl5dHc5L1VMbzVTMGNvWllVbDJt?=
 =?utf-8?B?UjVzOWtOazFuWm1IdzBMR1hLa2U2R3VMb2RGQXNNdjFDVnhaYlJUS2RmUTNK?=
 =?utf-8?B?cEcrcWFIdkJ4aFdXRG5STkl0SzJHM3FJZi9RYWl1ejdCcEZ2WlI5OHdRSGtl?=
 =?utf-8?B?YmFsR3BPU1haNkxZYVo1WlNPaFgvSS9pY2xpWmMrQjZJdE9vWlVBeEQwMXND?=
 =?utf-8?B?eldCaDVoYlZ5b1plUTBhUlk5cTVOZ0dUQkQ4dk13YlFENG9GU2kvQ29Od2dP?=
 =?utf-8?B?R1pWT2pKMDMxWFBGTWtubW5NYXFlVENxKzdxRU5pTTRZVmJZL2VyRGdwVWxQ?=
 =?utf-8?B?RGdtdFFjMmpJWU9EY1pKRXhHVEl2TzVQYWUwQ2NIUjFCWmhidEFIRVk5ZDBk?=
 =?utf-8?B?UGVMaWxEN092TkJqZW02MDVHMmF5eEY4dDVoclBRSjd1V2tub09kQnI1bXJ6?=
 =?utf-8?B?RDZ5T3A0NTZoeWNWRytwTzFRTE5zRWdXZWdSaGZvY2xvQWVkZnBGTG5mK0V1?=
 =?utf-8?B?VTlHOGl2ejNyU2dzYkU3U2tLbWk1eXA4Q3lzVmMxMHJSdkxzZWVEOGFURFlm?=
 =?utf-8?B?Q1hmc3N1cVBiYTJDbFNHYVJtMkh4T2g4bXdNMkRON2JFamRkelpRT280eWdt?=
 =?utf-8?B?aDEzNUNDc01CM1RYdXQrbWRKbFFLTHBrZlFITWVUcjVlZVVTM0c5alNaaHIv?=
 =?utf-8?B?Ymg1dlVNaTAyY0RzSHpYMGw0dzNydG05alJVcEJkRVg2YWUrOXNrODFPV2la?=
 =?utf-8?B?WGxOcElmd1ZLZ0ZFeFdlRVY4ZGs3eXBwZTkxcDlnMmxyT2tnc0gxTEhobTRI?=
 =?utf-8?B?TWh6V0w5ME1lbnNSNGRaRlJTaWVHWmhtMnM4aWhMZEk1aUxYVUpRdkw0SEI1?=
 =?utf-8?B?VjhKL3VGMU1rL3E5ckdqVzFaL3FIWVhtM0NnS1ZPNUh6Q0s2ekJtNDBiZk00?=
 =?utf-8?B?ZWRoNmtHbkFHKzZxTTR3SGFZMjU1ZVYraWRPUGtvZHZUWnk3aFlNQ0VhT0E0?=
 =?utf-8?B?UVJMbjd0dmtMMkRISndiVGlRenU1RkpkRkUzQXhxRDcyaSswalA4Y2VNVjVn?=
 =?utf-8?B?cXorcG55OTN2djBVQWMxdlNCQ0ZrbGp3YkZCMEtheVZzaVVYRlhVRENXRjRp?=
 =?utf-8?B?OHRCWk95OXlZQlBCeGtjUVZnVjFjSXM1NXdMZDQ3QzQvL1FpcTM5SDhGVW5y?=
 =?utf-8?B?b1lxOGJhUDJ2eW52L2V2REszdUVpMXVEa1g3U1VPL2R1MmVUVEZ6MkxHK3Br?=
 =?utf-8?B?bTVKbVA3dkdpbzBDcVFhc2o0UEdGd2pJa1d6ZVd3OXVXUWg4NTBZUTM5ODlR?=
 =?utf-8?B?R1lYc096QW9sekMxeVAvREl4SFo4Q1R3ZTRnS2JLZnJNWmRtcStHcTdUZHcy?=
 =?utf-8?B?RCsxNGF2WCtIVXQweEZqMUxlL3RqTEJJUVFUY1NLQ3MyckxBTHE1SHBab1Yx?=
 =?utf-8?B?VXYrMTFXUlVYWXplbnFxTlVGbHBLS2ZoNys0aHZ5L3VablgxUy9lNkVZNys3?=
 =?utf-8?Q?9/w+0aCuQOJokpCRkkGSV4qOP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783444c6-3821-4e28-e206-08de268fd0ec
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:47:06.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5Gq4lzcEIy2MrJvz+Ar/HvP9tv7KhU6f1f+beWtNPclxrnw6vCN/AACwPRvxI7XJrQzzoje0hc2ZjAVvh/2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020


On 13/11/25 18:11, Ionela Voinescu wrote:
> External email: Use caution opening links or attachments
>
>
> Hi,
>
> On Wednesday 05 Nov 2025 at 17:08:42 (+0530), Sumit Gupta wrote:
>> Add sysfs interfaces for Minimum Performance, Maximum Performance
>> and Performance Limited Register in the cppc_cpufreq driver.
>>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../ABI/testing/sysfs-devices-system-cpu      | 46 +++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 8aed6d94c4cd..6f1f70696000 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -327,6 +327,52 @@ Description:     Energy performance preference
>>
>>                This file is only present if the cppc-cpufreq driver is in use.
>>
>> +What:                /sys/devices/system/cpu/cpuX/cpufreq/min_perf
>> +Date:                December 2025
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: Minimum Performance Frequency
>> +
>> +             Read/write a frequency value in kHz from/to this file. This
>> +             file conveys the minimum performance level (as frequency) at
>> +             which the platform may run. The frequency value is internally
>> +             converted to a performance value and must correspond to a
>> +             performance level in the range [Lowest Performance, Highest
>> +             Performance], inclusive. The minimum must be less than or equal
>> +             to the maximum performance. The performance range can be checked
>> +             from nodes:
>> +                     /sys/devices/system/cpu/cpuX/acpi_cppc/highest_perf
>> +                     /sys/devices/system/cpu/cpuX/acpi_cppc/lowest_perf
> I think information on highest/lowest performance is irrelevant here. If
> the user is expected to provide a frequency value, it should only care
> about it being in the range [cpuinfo_min_freq, cpuinfo_max_freq].

Will change it as below:

   Read/write a frequency value in kHz from/to this file. This
   file sets the minimum performance level (as frequency) at
   which the platform may run. The frequency value is internally
   converted to a performance value and must be in the range
   [cpuinfo_min_freq, cpuinfo_max_freq], inclusive.

   This file is only present if the cppc-cpufreq driver is in use.

> I think ideally all of these controls (auto-select, EPP, min, max, etc.)
> would have been better placed under
> /sys/devices/system/cpu/cpuX/acpi_cppc, but I suppose the intention
> was/is to have all performance related controls under cpufreq. But that
> means that the user should not be concerned about the underlying CPPC
> scale and only use /sys/devices/system/cpu/cpuX/acpi_cppc for
> information purposes.
>
> Thanks,
> Ionela.
>

In v1[1], added these controls under acpi_cppc sysfs.
Later after discussion, it was decided to keep them under cpufreq sysfs
and [2] was merged first.

[1] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
[2] 
https://lore.kernel.org/all/20250507031941.2812701-1-zhenglifeng1@huawei.com/

Thank you,
Sumit Gupta



