Return-Path: <linux-acpi+bounces-20073-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D84B8D03B6E
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 16:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D2CB302551A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC1B4F05DB;
	Thu,  8 Jan 2026 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r4OMaUnC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235644D4F7F;
	Thu,  8 Jan 2026 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882641; cv=fail; b=T3GGQrpDlk27gblbsGKg2Ffc3kJzGO0nd+z2BLNjB4FLE4kVTw7iEa06Me+l41QfRawun7EPzbbDeVmQpGsi0Ll1yYbvoGIFjhLYz0tqzVrXgV5HLn547MNH6OGMbJ4dU4n1ttYZecGZmXs88cN15Om/zdPWT1z/GDVMppsxi38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882641; c=relaxed/simple;
	bh=EVYUkg9ND52h4INdS24EKD+GdZTFmd87XzhWduGvUqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cJkW5M+3hwckY1bTUW5bkAn8fPd1mtwLXjPDkZABUsRBLbS7inN5T58IV8X3xSq/uOxG+9QqJ1/03HcAMjR8bRm/w2Y1JCR9ZrEV45EAVztggTc1jEbYKhxss4AqdhwCXODcUW/ltFyEgE6y1L73ZHaex7Q5t11v0IDuyQAlj7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r4OMaUnC; arc=fail smtp.client-ip=52.101.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coAGv1IanGlXSeEaT518wUjbqnsBQ0R7HQyZDuURry7mjFtgTaBhAJuUfj+zQeUM15SoZPfs1lru9QV78UwXqAlFhth5IJyh77vSbOkW1t8WzW50HGDipm8A4FUWRoeELsA0KbwozZYLWCEbjPFJbL8m6B0xghx7gMXVntZxGHrtexKIZTTB+7uNfSdFwGANmy2N7jrlT7LKuIpGAKQqj/CguW9fiUUgsWBv5q/i9utAgs7AhPi7ojaYXyg7gdOcS4wci2efzFOgr/77sRchtZAD/Zg+1Vb2qYZgn36LqUSyO6/t0aX2YaDL8o9KtRd1RlFa0bKjGYExrrG4TJaeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U8Xl0Ss698P50JkD8hL0r2xdhbD/vkyyLvC4S3VbRM=;
 b=iQ3feQecpBn8G3YMpvhYHI6yzWIK/n0+XAsgFU6+592/TAy34ML9C8FIHWRS5Z7ptLQqV05Tltit5wZKJC1dZH472i28+AtyR2t8i9DRDZEwXnRRJoj7gwwB8d53Aj65t0acxU8EmMCnMPDRYgSR5RQ2ufBPVl1Fe7oxjNdQOipqcOChsiF6GfjgbNEfcS/vKvn3IY/VVJDR946qRblxIhORkwsl4bFI3qUI2EXmhn4hqRATp+cE9kl4ypXS+0RYCPaVtTzL1FwYE2DUJruxaTIZGBbUTmfCLlyzbq/rgdyCR45Z2q5yNSA8nYDm0qfntDMER/15i6i/hfPryYUsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U8Xl0Ss698P50JkD8hL0r2xdhbD/vkyyLvC4S3VbRM=;
 b=r4OMaUnCu5DIcK6i+0MxtiK8VvFLNFW3QuPKD5SDuj/KvHW9mnZWGuKTGCWa8JEHKqgG6whKye9p8qeI8RiW7grQHpPDA5qqTMbeFjcKBlBorjp5bMAIUvd1zfRC/I+j/gljIez0CZUKU46qxynLPJK3wUUitE+9dgSNGp+1goRr4IQD11ZfmLIgphuAz6E6cgfjx0lFHefznC6C6bWLZxFZdnIsidt2wUbk9wyMNSFT1KF22iv4XVtD1HNiLV9ZsDOKRPRkbOCORqaSQywvjqdM7wlMz1zmepTAQHX43ijkzlXsWM3XU3EnJkmjfpr6eukSNQdhXO4iR1VIcieMhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by BN7PPF7B4E3DFF8.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:30:36 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 14:30:35 +0000
Message-ID: <d5f8e139-a31f-4913-a9e6-ed071c5c89b7@nvidia.com>
Date: Thu, 8 Jan 2026 20:00:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/11] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
To: Bagas Sanjaya <bagasdotme@gmail.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, ionela.voinescu@arm.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-8-sumitg@nvidia.com> <aU3Us1NzlpVQcyii@archie.me>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <aU3Us1NzlpVQcyii@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0128.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::18) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|BN7PPF7B4E3DFF8:EE_
X-MS-Office365-Filtering-Correlation-Id: a7698e94-58c7-4405-1d92-08de4ec27ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0s3K0RLM0gzVG42d3VUMWRuRkwxRS9kT2xKc2ZqZkU3VFlLTitIZWlmSzN5?=
 =?utf-8?B?SDM1SW91QmNMeTlkME9HMm01VURFaUNiZGZxRWdMcDhrakZ2YS9wR3VibFkv?=
 =?utf-8?B?Z1lCY0gvQnhrMnlZMDc2VU85cHBIY0M1T24yWURPWTZJRU9ZS2hrMFF3eG5v?=
 =?utf-8?B?UitIMjJvVXRCRW1qdGR0WThRR09nZE1VbTZkUVc1Sm1vMFFuaWxHRU9xKzRN?=
 =?utf-8?B?ZDR2RGVmUmovaDBrbVRlcFFxUkZONE5MRTdEMnBUa3JnMnZZcHdVelkzWUZa?=
 =?utf-8?B?bURZNlZoS2psUFc3dkVSOWV2R0FRTmZPd2VoRUdhbHpMV05uekRFWEp3NG9K?=
 =?utf-8?B?bUhCYUQrMkZPNTBybkJqWk1KVHVFeUl0MjlEK1pRdVE2L2NNRENTSGg4eE9O?=
 =?utf-8?B?c1ppaVV2VGRzUE5nNDBtRGMxdVpWMjROWlkxb2tkbXNlNFovSGQ4Y3dKWmZl?=
 =?utf-8?B?SzlqbnphZFVObHRVOEdjL3BTR0s0K2JsdHZueGlPZi8zakZIZzVFdVNlWkNJ?=
 =?utf-8?B?TWErN3hRTDBaUkgyaVdqK3EvTG4vakk0YVZQQlRoSThUYVc4Q1lTbUJCMWF6?=
 =?utf-8?B?WGVwT2lCZjBlbitxaWxETmJzRjZaTVZGdFRVVGpWbEhlRWxaZ3RvZE91ZFBp?=
 =?utf-8?B?eTYyV3B2Nk9UZmsxOVBZL1hWQlBlYnBla3pEV0htRWdMM2o5OXBhRVJvVW8y?=
 =?utf-8?B?aVI2ZTlyVnRad2ErVGJKQlNIOS93amVraHFtSXl5Umsrb1FQdGZpSVJyaFdn?=
 =?utf-8?B?RzQ4Z3JqWElIRnlzd2RkYXFjNVduanFoemRhalJvdWpzQXNOcG11SEZPU1JM?=
 =?utf-8?B?QmdGUVFHTVVJK1FwRC85VFBoeWMxaS81KzVaWXhRajh6OXROMkZGZWxidG1S?=
 =?utf-8?B?bzMvdXFRbUdNSVFGeDcvRjBKSzVoK1pqclNnelV1aUpYaGJjZ1k0alBkVzBQ?=
 =?utf-8?B?Z0ZFdEFlU3FreVNJWVJUMnF6S3FSSnlQUjdsRTJ4cXFla2VoMTc0UTExTDda?=
 =?utf-8?B?YWxRZGJDRTJPbWp4RWNLVk95Rkc3c1FWQjE4WGQ4MmU2RWZXR0RHN1I0RHRo?=
 =?utf-8?B?V0pGbis5WkhKSEhoenpCSzN2aGxGaGJGVXNGTkRzaW5mM0I5d2xGL2xEUEJl?=
 =?utf-8?B?RnduamxTcElzT3JhdlVoZU1wbEg3cEtYWlJwQjVvejU1SEViQ1BQd09rOXdr?=
 =?utf-8?B?TTE0dkgrQ012b3hlaUIzSlVlR2tubENIRFNwWHhOVEErMVY5NEpBcXBUS1NN?=
 =?utf-8?B?dW41VWpxdmh0UlNHYUVnakQwWmhYamVjTW5lN1FEVXJsdkRpTzF0Nis2QVVZ?=
 =?utf-8?B?bEhsU1lSd1Q0cFRIQytUQTJ1VlNtZ254eWVCeEpoZGJCYjh5NVNIa3Mzd0V6?=
 =?utf-8?B?MHRHN1VwQ3huVkh6WFoxWExPNjI3OHArdk5WeVNzWi93U0JkV3B4SzBCYzJZ?=
 =?utf-8?B?OXhzT2lTV3M2K2FOYjZHNDdkYzFKRDVnLzk0anVPSEVsTUJ0amRFb01pMm8r?=
 =?utf-8?B?TjVzSHJ1bnMxdWI2K21PUDBqdlhpeXp3R3FIMW1XcU5kR2g4NFBEeS9qUGd0?=
 =?utf-8?B?OU93bkcySzVINWlQWDkvZzBLNzdzNFFLTzVaVEVPb1I2TXEvY3FHVDhaQXNt?=
 =?utf-8?B?OVNhRml3NFkrMi84elZkOVFzZExEK0FVc3pNY2E4eHpDKzN5QlJkUXkxRmw0?=
 =?utf-8?B?dTNOVXFQZEhjcTJqMWtEZkJmeTA1UjhVdldLUGF3UzdVcVlVVEk2enhNalBK?=
 =?utf-8?B?VGRzc1RQRnprOTBmUmxGcHY1N3lOTHhJZXRzU1NZTisyYW4rNC81ZkRuNlI2?=
 =?utf-8?B?czhIeEpMVytCT2VtVnNYeS9uSWRUdWV4STNKVFduZDQxQS9GRkFmd3VLNXc3?=
 =?utf-8?B?N1N5VU1PTmROK3dQdDJuZmtxSHVYU3VzazBmYmFMODlJNHpSeDFJNHlTMVZL?=
 =?utf-8?B?VDNkZTZmbGdXa25EYUxGMlJGZExicjNKNFBHeUMyOHUwWjk1c2hxeG1hQ3NZ?=
 =?utf-8?Q?P+swnUdfy/143CGt6mVqKKzDfzmerA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzFXNUJaK0UrVUJ5UUdhWTNYSFlDWGtIUEc4dDROVUdxY21kUHkzU0lFREF4?=
 =?utf-8?B?bTY5OTlwQW9xN3grRWRKTktJQytDY3czMXQ0M29mR0Fkcy9BbmZuNWtXTUtl?=
 =?utf-8?B?MkxHUExWUkVQNWhLekxrdEpxMEtPT3lnSGFCWm0zWXRSVU1FWlplZE80bTdv?=
 =?utf-8?B?NURJRU42ektPTnRsQ2p2RkVOZTY2OE11ZjduLzFsSWNSYlU0eFN6SUp4Mzc1?=
 =?utf-8?B?ZWZUMFp6ZXdpMG5vcWF5YzlQNENsVmVjVDZFdFpUMlFTRXp0YmNNU2ZxUUd2?=
 =?utf-8?B?MFBxSjFwS3dWcDQxVm5lcDYwb093T2g3bklCVnJVb1RsdURCZ2Eza251d04w?=
 =?utf-8?B?UG9XQStUb3RPYnJWRzRnQXJzOXBPaUFMdVNGZzhPOFBDTkVWaE5FOUd0OHV6?=
 =?utf-8?B?TzB3K01POXJ5azh1c1ZGNXIwK0NQYUI3cjROZ01GcHBtUjlwOWp6cDhhRlQ5?=
 =?utf-8?B?aTBSOVB3K3VZcTVacDBaRjRkOXIvSHVwb0JFL1F6eXdyYXI3RUV3VlVtSFZ0?=
 =?utf-8?B?c0J3aURmRE5jMmRSeVYza1EzTUtrYUJtc3RNU0ZWaWMvMThHVDIwaDN2YzNl?=
 =?utf-8?B?M2p2Rk9LeFpZUWttOCtGZE1Wa0ZjWmVqU1IzRHZER1AzVWY2SDlFSzlnYkRL?=
 =?utf-8?B?OEozaTV0b0dyaHpOK05oZ0xBaUViS3VBWHB2Q2NWWmlTZFNZSzlQM203ejlW?=
 =?utf-8?B?a3hpTXc5Zzd4a1RBbGJ2RGRhY0krQWFTZGJPL0F6M0kybXB4UXJqeEpFcnA2?=
 =?utf-8?B?OVVLNTdGUGU2QUJnZ1k4emNuWm4wYkFldWdJRFI1YnEzRTZmSkI0TC9XMVZ5?=
 =?utf-8?B?cGJDUzVHSmJURFFpbklFTUxwWjhNTWV3OGY3SlhRRUhPdi9lOFM4UFZSUnRi?=
 =?utf-8?B?dnZNQlpPWWEvWEI0SW5TVTQ2ZS9tQ1cxRkpuYlh0bnpYSmllWWNrNVVZRjJn?=
 =?utf-8?B?S1NieVQ1R2ZWaDJGZGtoNEl2bEZuNEIzZWMybkh3STNWTzJXYzhQQ3NkOWVV?=
 =?utf-8?B?NGNUaWhBVkZuektvakVSV0ZSZXErU1U3UVRHdDdpQ24rYkl4dDlySmh2WGl5?=
 =?utf-8?B?VHIxTTRaam4zbWpMRjh4VjhyUWpxbmZ3aVFnL2Q4R1ZSSEJoY1Z6K2Y3M1Ix?=
 =?utf-8?B?SEVIRzlhZ1E0ancwTGJwZ0VEWkllT0V3ekY5MHlYRVRGTzIyeG1RRVFpaGV2?=
 =?utf-8?B?aGdRa1B0SlpEakFOVEU4aXZQSGM0RjR5cGZlNFBhT3M3WWNpeDRIak85aUtP?=
 =?utf-8?B?RktQV3FRdHFoZDBteENRRkR3S05ySzAybkxYYXYvMDhwSVUvN040R3dNZzIy?=
 =?utf-8?B?T1ExaVh6SC9MVi9jYkhpSk5ENFBRT1d5ZEJ2SGRKa1JQVjZ2VGdTYTdxdExR?=
 =?utf-8?B?UlMzUmppVGI5c1ZnRk14K0RpQ01JK1lHQWhMM3hJMDdHK0FwSTI3LzJKZXYz?=
 =?utf-8?B?TGkySUUyR0xzSTZIeksvUlMydVFuTnY1THUxa1RrUTJtQ09sNURKMjZEWlR6?=
 =?utf-8?B?WjdwMUk4SzZvZ3RpeDg4bEV1MTdTS3BwelRGOUNqOTFoSkFqTGpnaUZMUkJk?=
 =?utf-8?B?bHcycDhzdncxZFNFRWxhT1ZWMDNXZ0hGbmZQOWRxb25oZ1RoR2RzMUtXcmVR?=
 =?utf-8?B?ZU9NcVVUbHFXZllRcTd1WVpLZS9seTRaK2dMbXJUSkRGa1RIb3k0WGxEZzFQ?=
 =?utf-8?B?SFY2N2hKUE44VWoweE1CRXZGUjRYdTI3ZDl5TTdtN0RnbjNDUXRzejZTeWJP?=
 =?utf-8?B?cmtOTnpXYlNWR2l3aVZCQWJYWmpMNEhKSmlDQTVQalM4UExrMWcyUHZkMTdL?=
 =?utf-8?B?TWp5cmJ1TnZFUHhWaS9kUXlTYWxheTlPWk14dEJVM2ZoeUVDWmhtUGQzMVdR?=
 =?utf-8?B?bVNueFZiZGZ5ZDZwRk5ESWxxQ2RpZVBxTVlFVXM4QzNrTUVLZG1uZXZaVGdD?=
 =?utf-8?B?dG4zWENhZHpvbkg2K0pia1JMVWJ0VGloVStSZXhUSERDRnBLSGRpcE1mVFZN?=
 =?utf-8?B?UHJacC94VTF0VVV2MW45TlZUQkgrc3FBOWhRcU9IQzBqdXZ3VmNrZmFlTUl0?=
 =?utf-8?B?UGkzR3BJWTNwN1NhQkpaYTNZYW9HVTlKRDNPWWRLN3pST2ZyUmgxZ003L0Zk?=
 =?utf-8?B?WWJ2RU16QjI3cGlGbFlha2JMRmttUEF1cDdEQ3ZOalYxRzRWNVM3Mmtvb1lj?=
 =?utf-8?B?cHptaVhSRUhvSGdlNjJ2ejJlb2RtUm5haTZ4Qk5FZS9kVW9BSjdJc090bHVO?=
 =?utf-8?B?dzNYT2hwRDdJNnQxQk5LVGF3TGJWUVpnSjBVbVZZQjltUm9kYWVmWmhHd0dY?=
 =?utf-8?B?cjNBWlFsYXlIOEk1VVFrR21iSXY3V1NkaERMaWNPTkRZeU9ycFV5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7698e94-58c7-4405-1d92-08de4ec27ca9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:30:35.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUXZVF3SJkSegPGzs0BG8ASNJI6auAANNG8uidyfkfzca4ZdOIoOQ1m052rW9fIbSym85RiNa9xVHQKEG44VUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7B4E3DFF8


On 26/12/25 05:50, Bagas Sanjaya wrote:
> On Tue, Dec 23, 2025 at 05:43:03PM +0530, Sumit Gupta wrote:
>> +		Write the bitmask of bits to clear:
>> +		  1 = clear bit 0 (desired performance excursion)
>> +		  2 = clear bit 1 (minimum performance excursion)
>> +		  3 = clear both bits
>> +		The platform sets these bits; OSPM can only clear them.
> Sphinx reports htmldocs warning:
>
> Documentation/ABI/testing/sysfs-devices-system-cpu:356: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
>
> I have to fix up the bitmask list:
>
> ---- >8 ----
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index b022cbf46adcfe..8cda698019922b 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -363,9 +363,11 @@ Description:	Performance Limited
>   		requested level. A non-zero value indicates throttling occurred.
>   
>   		Write the bitmask of bits to clear:
> -		  1 = clear bit 0 (desired performance excursion)
> -		  2 = clear bit 1 (minimum performance excursion)
> -		  3 = clear both bits
> +
> +		- 1 = clear bit 0 (desired performance excursion)
> +		- 2 = clear bit 1 (minimum performance excursion)
> +		- 3 = clear both bits
> +
>   		The platform sets these bits; OSPM can only clear them.
>   
>   		This file is only present if the cppc-cpufreq driver is in use.
>
> Thanks.
>

Thanks for the change.



