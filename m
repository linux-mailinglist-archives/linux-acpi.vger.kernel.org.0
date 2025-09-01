Return-Path: <linux-acpi+bounces-16253-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F016AB3E5E5
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFA11A848AC
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204BB321F26;
	Mon,  1 Sep 2025 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bKMjdwHi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922543D994;
	Mon,  1 Sep 2025 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734389; cv=fail; b=B73EJ1ZXUOZ06L7gjbfVloNFkhUJgRYsiopwR05EDffw5N3/WmW9qfFFwTyYlG5/SlXWPadN/r+KOmCQysd78zZkbzo/trimLC1zpo0PABmXEJJW77m0YGBOjwtXSkSIRpIMCps7sNVZrwjI/1OnTLcWHym5+dlbaTmCwX6ymuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734389; c=relaxed/simple;
	bh=yJ8cfCVQDiaNQHntQxK98jPMC9aC3mIZRQbMmmNP0as=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KT3OmglEZxpauSVttlSSO0ALCmjBY/twh6KzcFFs3VQsGyuRpRwt8n0yFz4P26A9pdaGBgx7SoskTM26Biu2fC40C6jEqDZz2aIdw61JkI7D4exX8y/S/RBV2xFJ/N4yq+eV7e6HL/LhCezgJlem1MLiI77Qe+J8mNYza4wKSOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bKMjdwHi; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8Ps2bw54xuicXFpy22sQzaNt6prDfvNI5kUOZS7MNPTRA58lsRGJHUdEioYPhCaJRUm8Xel5Hdc8omiQOENRUFtDPO4jeLMO6Db0efxvYdFJbr3OlMyrWfTVLDkMup8qkyxZM3tu/Dj1cQGucHtnsgzEseg5Wo5l4st/9lg39leHzPvJS7VomPvAMI2FpZpeg7cg4qycjGY73sompbs+6NHIPpQGg75qZbvy/LHY/U7dqR4OvyLn4uI4JD6fiZY9UoljLcup2nynLeDqj1vy69C9oAdKlbcLz/8v8iE2pnOBDz9pxfWiCLtTv81ylMmgDBbQPrXm+2w27WELbDw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp77hjU7BN5FVY0DUQ+J6TO532XtR/1O9Rc1YJUs8xs=;
 b=HHfFDQZhNhBMnz5CmAGf9E9sOj4ZhCm/pj1Xa+Zl+6+PRxSyWitixa3JjwAvBL9uCvWN5r2VQwexN4KjffKvJzyNgsMFgeW1ChnBgRwMJCNvl8B3wGDVdgVjEzAuTy/l0siJvfbFilop+gVCJO0vUKThqiEDgHVTZcg9ZVnl1Oa8XFXJQmsO/MLyXuRTgShzBwE9FV+9d0vRlrX7pxtA0Y01+942oipVZpJJIbLm2TiLN5cyMtqFFJuvIztiPmtJ5G/FXIvSv5Y2a9WYSwcHV+yvJGZ71nmfqPZdwFkjEo2vi8xQGStNaj8XeUpcAbRsp3/aiAk0R24usRDDX2WWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp77hjU7BN5FVY0DUQ+J6TO532XtR/1O9Rc1YJUs8xs=;
 b=bKMjdwHim4C3EEUQTDxS6od4B82pcyXR3v86vEbzKihSp/7rFi38zyC1mo6bvqhHJWxapCAyM9B/DfEJRH7FPYbL+sguqFjVRepWpH3zyHf5564D7RwrsaP9+e968gWMjopqO/7J0kbguf+vAcFqeULwvLbVAsX7svndJAwKjrxPmZBbHekvjxpXKIXS/2ato/k8b1JhygEzF8UE/tU/c4Qv2LdFKIspn1fI/lCzt0z/c9w6ZaKL7hu8mCp6/MA5bm7GN2LxzUzNeaXPm6sw1gLbBZOtxtWlTGouY0ymWRwrfZz85jXW8KamzW1x4lZILpodxdctHwVIXSDU3P2uiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by LV9PR12MB9808.namprd12.prod.outlook.com (2603:10b6:408:2e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 13:46:25 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:46:25 +0000
Message-ID: <694a85ad-8b55-42e9-91fe-06d40fe8facd@nvidia.com>
Date: Mon, 1 Sep 2025 19:16:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] ACPI: CPPC: add perf control read API and clarify
 naming
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com,
 sumitg@nvidia.com
References: <20250823200121.1320197-1-sumitg@nvidia.com>
 <20250823200121.1320197-2-sumitg@nvidia.com>
 <CAJZ5v0jXq48petXAcf1prb5iuHbh3i8XREJBscs88xs5RY_j=A@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0jXq48petXAcf1prb5iuHbh3i8XREJBscs88xs5RY_j=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::15) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|LV9PR12MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b5ce2a-c7fc-4ed0-0da4-08dde95df14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDM5ZzJuUFVlVm51b2F2R2Rhd2VRMURGeWl5T3FOaG5TalNRYm5ZRWJnNG0r?=
 =?utf-8?B?VVFFc2loZUlWUnA4emgrcWNRRXFMTWNXb21aUjdxUmxjUE1BZDQ1d0R4cFYv?=
 =?utf-8?B?M1liQWpKV1ovRHAzbEdjalk3WWFZZUU0a29FMVdtYko1bERWblBnWnlWQzBN?=
 =?utf-8?B?K1ZDdTBwVUR3T09hTzNOb0hQQU42eFMvRElKWVVMdnhRL29uR3phME9PUWds?=
 =?utf-8?B?VTBOeUk2NnVtMzE0TWRXM2lEN2xWakZhY2tEQmQ3UVZFSjVEOVBYVjFQVkZ4?=
 =?utf-8?B?WEtWSjZTY3FPKzVZWGF5ay83Q2VVcmFmRjBaS1JyZDNGZSs5MllFWDNxSHpt?=
 =?utf-8?B?d252RjBVc0o5S0V5dnQ0T2g5L3hlTUU3ZWx5dkQ0Rm9GVFB2SnZBR1dsS3Zt?=
 =?utf-8?B?Q3dOWGVNVUF1UjJaUnhvamF1dHdjVndmTlN0d1ZYOGdDbk1Nc0R5VVZKbGJt?=
 =?utf-8?B?YXJDRGx1em9mb0tscmsxeEtEdGRUT3l5R0p3d25Vem9IZmhENSt0NVAwdVJE?=
 =?utf-8?B?ejczUmV2ZEFMVzNDTkRyaXVZSW1uVXdWTy8zOUVHTFpQU21LZ2dDcVdtY3pi?=
 =?utf-8?B?cW5iNkRSaEMwNHpwQm1nb3VHMStCZ3BiV0RQZmJPWEFEcWt6d0F0Q1ZKVVpl?=
 =?utf-8?B?ZkRqc1VUc3Uwdk9ha3VRR09TNnhMaUJycTBwTk1mQ0tDNE0rWW9BZUtxRlNw?=
 =?utf-8?B?ZUxhTnJtUUo2dHgxVWh6Mysrb1NKN3dkYlhKUzBhRGQ1L2NGdCtVWkVNVUJt?=
 =?utf-8?B?OW1RV05sQVI3YnFOSWNIUTlzQ2crdVhySGFqZ2lseEh1Y1JLVDU4TTlmYWpE?=
 =?utf-8?B?dFBhcWxSYzVZREhvOEt6U2RWMWdoSDNnd3ZCcGZZM1ZBRDAweTZlU1dLWWJE?=
 =?utf-8?B?ejdBemVnYkFRNlM0QlNnVFExeFlDM0JKN1ZZT1BFbmdyUEZBbGZwb2h5bTNS?=
 =?utf-8?B?ZVFhdlNkeUJtVG9TNk1aalRMWG4wenh4UkNhckNGODlUYVBhQ1Z5dmttOFFi?=
 =?utf-8?B?cXpMVUg5cExHM1pVRjdZSWlheTMwa0N4ZlhhU2hSMVQ3alF4NUgwWE9OZnAw?=
 =?utf-8?B?aCtLVTBNOG9zSDU4K2FFNHpsZWtqYUk2QVBFb1NoTnVKVzBZM284S082aCs0?=
 =?utf-8?B?WVprRHZvWmlmbVdab3VqdGxIbm8rYzVLcFNIaU5OaTR5djNqekptaGZlVHdz?=
 =?utf-8?B?SmZBZHQyN0RnNGdEMnNKdVZ6YjcrdVdvTEJEbGtObFVNZFFjZlBvYWdWa2ZB?=
 =?utf-8?B?a0RXRm01dG9CQ2dZSHppZE9pWW5nSHdETHp1Nko5NjhzaFhLN2pSVXpLbTc0?=
 =?utf-8?B?OUR5NG12Sm1jNWRycENuQmVDNndjVlRWdFF1VHN2R2FxcUxWci81dEYvc3hq?=
 =?utf-8?B?VFpqOXhIc0RBNjVvaEY3QjNNVkdxVUdkQWttNzVrQjliLzhLT1hHL2F6RUhU?=
 =?utf-8?B?RmFHQXJ1NHRUU1pKL3pMWUh2YldsbW9oOUhHQS9LUjROTmZVVHA4ME9wRVhv?=
 =?utf-8?B?UXpnZHJLY0J5dEJTQzJEOHRCSVlTc0Y1aVU2ZGc0M0xNb1dpZFpmVU9uZGov?=
 =?utf-8?B?NFI1ZmVLRUV2NnROblBteDFxQk5uNjVrWDhrZ0JROWoza1BxOGNhVnkyRUV3?=
 =?utf-8?B?VzYwcDJLeEhTSjVvYmQ1MUNpSDlBS1RtbWd0Z3YyUFA4L3RUdnZDeTJRMVhl?=
 =?utf-8?B?OFpHYkM4QTMwUFpZb0kwdDcySDNVN29lNXQvSXByZWsxUVR6VURrTUFBL2hp?=
 =?utf-8?B?a2g4cE5GN2V6M3VVQm1VZkt4Vy9XTXhZajk0VWhyaGY3N3pTTE9TYyszNVEw?=
 =?utf-8?B?UE5nN20zT0FJcURoSjhqckVhYnd6L0F6QklvOGdKUEJ2bzJlNzlPWlRmcitJ?=
 =?utf-8?B?QWROdHYrcmRxTnliZFJPTXFsRmRQR1Vzbnp1anNYNWpqeVZSbTVLS2duQXMy?=
 =?utf-8?Q?mrDkWPsoFaI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG56ZGlocjVWeXc3ZWIzV2x3Y0kyNzhLUEdlOWtmNk9PZWRBQi9NLzhjbmRa?=
 =?utf-8?B?TGJVWER1WHI5NnFPbERqOVM3aFBrRWN2WVBNV1o5RlUwREo0R1pVNjNEeFhO?=
 =?utf-8?B?OW1IVVFqc3ZCZXVsWkJHZ3NTU1hXVXhsTk1SQXpFSmx5b245QVJCdjdvTmtG?=
 =?utf-8?B?VDlWN0NwMUlDQWFIc1A4dnkvcGxiWW9rV3Y2a3RoMVozM0RQa2VRNTNxcGc0?=
 =?utf-8?B?VWdjdDBIZ1ZYMTJGT0ovUytocFhXL2gycVZ2OXRHcklnRnJuYW9tZmFJM1VM?=
 =?utf-8?B?dVBMQm56Yk5SYkJyUjhtMU5OSXRDUzdOMzBoTWRUZmQwcXVLVVFTYlNOZlN1?=
 =?utf-8?B?VEhtYytXbzlUTEg0dWM1em9HRG5TdDdTZlhTSXo4ZDZ5RG5PcUVmWTFOM2E5?=
 =?utf-8?B?STFRVUVXWC85M2I2NHBsZklkTFVaTjZrZk55MjZ1YklpNjYyZVRxUjlNeDlw?=
 =?utf-8?B?c2ZCTDZYVTkvZjk0TUtnWis3QmlUZFByM011RE5Cd21oZUlGVmhJV3d2cmV3?=
 =?utf-8?B?dWNoTlZRejBCK1czRUExay92dEJUcnFoc3E3b29KRDlBSi9zN09ybSs5MmhK?=
 =?utf-8?B?WjhBRjlON0dWdE1ERy8zd0QxOExqV1Jic0hWL2dsMytqdVNSelgwekR4Y2Jk?=
 =?utf-8?B?ckV6bFZsQ1RFNmlUN1NoMHJueHg0N3RnaVpZa0QxaEQzempZTUdWUUM3VDlS?=
 =?utf-8?B?cFU5Zmo3ejJ0UnR1bnQ2VW01WlV6SmNsY3A3NzVTeHViRU1qR2ptSFkwK25X?=
 =?utf-8?B?L2NGc1lWNG41K2pxVm9DbDd0SVZYOFkxZmJCYWQrbWtNMkxnRk96ZVkySzE2?=
 =?utf-8?B?M2l3SkFxNEhVSlFNRURsV3h5SE5HSTZGaHJyUG0rS2xmM2lQeHJGU3VyeHVw?=
 =?utf-8?B?aGZ6VkhSTUp5RndCcHJRY2xqczVJVjExZUN1NVgzbERDY291QytSa0tqR2Ez?=
 =?utf-8?B?citvNjF0Y2l3K01ralg4UjFvMW9pVElvVTkyc2lwYmc1UVVHcEZ1VDc3Y2d4?=
 =?utf-8?B?MXY5Z01iWGpNZ2crQUFsR3Y3UitUOThIZFRKRVBucFBaM0xwOG9sUFV3VVBw?=
 =?utf-8?B?WkhJWnF5OWJudDd5cUlibVFJeUVGS1dTblNSUHFuTWNvSjZsWXhIQ1E3di83?=
 =?utf-8?B?WmdvV2FjOHlPVlBUbFBVUk9JN0hlZS8wSEJDeUg4NSs2cWVia0J0RWtrUHVZ?=
 =?utf-8?B?WjNrYzRidWR1ZGN2d2ZJbjNhNTFpNk5DUlU0MnAwK3FhbVRwdmFDSXdtSEQx?=
 =?utf-8?B?ZGZHcGxQNnJZM1p5UTFvNHM4d1ZyOTZLNzBtTmc0YWRLUWNSN2tWbjZBQmhX?=
 =?utf-8?B?eS9YdUptS2hmRzhoc0JYM1V2d2dGR3lYSERCN3VGN01ZZ05zTk5yMFNwLzlJ?=
 =?utf-8?B?T2Z0M1RGR1NZNkI3bFRsTUtjcEwybE8veUhTcTE2aVFnVHplN2RVTzFOcEZp?=
 =?utf-8?B?dTlEYWtzWjhITURCalYybzZTdGZxVWkyTXJDZEZOcVF2QXZRaHdnSG9xRW03?=
 =?utf-8?B?RWppOXVCQ2JXMkl0U25ueGFlaGFjaFEvMEpuUXpGVFQ5RFNVRXREeVYzakpm?=
 =?utf-8?B?Qys4alJuN0Fyd1JaQWlWUjhKVjlCT2dGMW9HYWp4cG5SSXRNc3NNR3cvVTVi?=
 =?utf-8?B?WVQ2STJlbldwTjFNYm9oRGVUbVhITFJ2ZUJjRE1BbW5TNnppUWNkbUpMUkNl?=
 =?utf-8?B?MW0xMzRWdWpPbzFLaHdpZDJCOGdpUzJ5RFBqVnVSUm1zTWlxZ1d2SlExcFMz?=
 =?utf-8?B?cGhBTDJheUVZbTZFN2x5YjI3cEFNaUFDbmNTMktsNk5jSURNZVNWSGJ1bHI4?=
 =?utf-8?B?T3FZdDNINFluZWVNMklrb20xOXNkV051YUluRHRsaXhzVHdGdW9PZFkyQzY1?=
 =?utf-8?B?alZYOWwxcm9WdmYzbVZURjVBZUt2bVhnelBMeEVGc3B0RytpSHZMVHBscEkr?=
 =?utf-8?B?Sy9TWFVkV2pKamlIQjhhSEtESWlZbGtDMmd1Y3oyMHFSMndMTDhGbU94bVA4?=
 =?utf-8?B?eTYwQjFCK2RiZlNKa1U0L0gzY1Jsd3czVm4xbmduYmRUeUs3aHVGUm1mekZN?=
 =?utf-8?B?bDB5eEJ3RzlzbkVRc1gwN3BZaXFZeFNBN1Z2bkYrUG1RRG55aVdZWVgrc3hW?=
 =?utf-8?Q?awiGIoy7WaZ9uQIPS1haQX/s6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b5ce2a-c7fc-4ed0-0da4-08dde95df14b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:46:24.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fVmqLkibrBLN6DSG6lkJE/RNKCXeuGQI0Nq4HJX4kmie5D3q+zK0ZX9mpFKH+o6GXkdREHWZJlHlkviMLG+/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9808


On 26/08/25 00:03, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> On Sat, Aug 23, 2025 at 10:02 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>> Add cppc_get_perf_ctrls() to read performance control register values.
>> Rename existing APIs for clarity as:
>> - To distinguish between:
>>    - Feedback counters (fb_ctrs): Read-only performance monitoring data.
>>    - Performance controls (perf_ctrls): Read-write config registers.
>> - cppc_set_epp_perf() updates both EPP and Autonomous Selection.
>>
>> API's renamed:
>> - cppc_set_perf() to cppc_set_perf_ctrls().
>> - cppc_get_perf_ctrs() to cppc_get_perf_fb_ctrs().
>> - cppc_get_perf_ctrs_sample() to cppc_get_perf_fb_ctrs_sample().
>> - cppc_set_epp_perf() to cppc_set_epp_and_autosel().
>> Remove redundant energy_perf field from 'struct cppc_perf_caps' since
>> the same information is available in 'struct cppc_perf_ctrls' which is
>> actively used.
>>
>> All existing callers are updated to maintain compatibility.
> First, this is too much in one patch IMV and second, I honestly don't
> see a reason for the renames above.
>
> This generally makes tracking the code changes history harder.
>
> Thanks!

Did the renaming for clarity and better readability.
If we don't want to do that then i can drop the renaming and keep other 
changes.
Also, split this patch into two as below:
         Patch1: Add cppc_get_perf() API.

         Patch2:
           - Update both EPP and Autonomous Selection in 
cppc_set_epp_perf().
           - Remove redundant energy_perf field from 'struct 
cppc_perf_caps'.

Thank you,
Sumit Gupta



