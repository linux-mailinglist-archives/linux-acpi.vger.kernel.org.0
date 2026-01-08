Return-Path: <linux-acpi+bounces-20064-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F93D03C89
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B38331FC93B
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A885496906;
	Thu,  8 Jan 2026 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ke1qpgRw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4B492F0F;
	Thu,  8 Jan 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880458; cv=fail; b=CTUmFp3wQnrdrtAN/8+rR7JAo6IbMO90vVFYjYxP0JRNa0kQPyipWgUg7k7zWe9HJnO+y9ZqNCTzkluZsVoKapd6jhDFLiUFBoqfbmEUu/cecHkZ/4ULeFSFE/c06ltnQOMn/5JbqNfSR3LNl02rjeW0BlnV01VjQBGEzGtiRpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880458; c=relaxed/simple;
	bh=492va/EQUNZtJHjSaY3I50FAnoMTG1jg1NIURBVyZP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EnrCQWPHTMspAPxdAxeKNT44ssfgqTnYIimCbGaZGXwzocA53Jnm2lbooFtn4/n7o5ZEhWav6HkKnMdg1PsWdt1h8zmcnqbX2B8PWF8tX6CKtW4iwE8YiC9ZaGQiSMQ/7cIBvg5qALjfwdpQWUWyn1Mpahqu+s90pesl/NMtoJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ke1qpgRw; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgrQ1fFTJUbyB41/3/72MdoDhWM1+UPIjb60TzljVOM8inU/FYv3sm73U1hNO9FpUM/vhrLbVrAZ/h8U/mXab5pMFh+k0O430CtpgoX9HDkJKOFKDKeuZrZZTAZkEIVC0pQ+nKSs45/sv0q4AAP2PDE15Rn1KDxPbhW5U4ENbUZA0enN1264lG5w5QKQF3JdnWFPh5bmFnG3ETD4PB0kVZfqDn/zeiiXzrwcOT0RAfk4VyREed2sGz6CiPHW+PoIafMVCQ6sA61yZvXVr8SgC6i5+QoAUbDDBuc2vQRMWNeHNZ+XzyPmALcot2BIkXw3JLBwtWyzzLmdSmoyoJiJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjoM0YEQgPwiGoT2kBGgSM7bq6XafEN3Pn1+AJl1/bw=;
 b=KX+Okx/vOVchBoyx/wpbPbMGdFdFOsogPmFo/UrTJnEyfvAGg78Mq/XIqcQe3f1xGAZF+Ehat8B70Z8qpVzv8cAdKk6x87EZIAi+6wxPOkhVEJL6ZvQGacbokuoj+kDaYzz63lr+cprqmLjaYc0vau6KoBLsZ/6dWxqcW5CXTEqu41gougDJDr1u3nnDChCeBTNj4/VVtGgOF2s7utsHHt8rgnZj0lbd5SouPiujYlBND0XAA7xwD8snnoUNB4dwiAw6RGOgkrl4GhIXfLPAbslk9wYAECwvp4CZjneomfjlG0Cw8/EFlEM/983AGsqgYfPqyt972+CPzoF8+VGCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjoM0YEQgPwiGoT2kBGgSM7bq6XafEN3Pn1+AJl1/bw=;
 b=ke1qpgRwAEauRr1RoqMxpNsh2C+xhf1BPx2rBym5N+Y8Mu8mqp9hAhKnCYXZdPZJ1i4bHvdVE/9w7FMr5kB0novyQRlThJOPhdUMpCRgzTG0CdbMVVI2Lno0jnLVxDihS1qSOTz+a61adN0LlIU+V5O0bFsQl22GX8lwOAUPctVBvNZqnoIiG/M3lWJl6J/xyrR7xD4xT4TPK7MjbgfMjBp9LPvyQx5t9U2+pVlg9v0dfnoCUaefUuL9QTOfOn4lSLaJNM7JXT+KIqin240r6F5YC3L2R/bcTZgeBNSU/wW1oX/a2jqhW/TnjEeFtXpG49Mk7knPRyTLpqMnkIvU0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 13:54:06 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:54:06 +0000
Message-ID: <2e0e7b5d-e424-4a45-9783-178a1af24ccc@nvidia.com>
Date: Thu, 8 Jan 2026 19:23:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/11] cpufreq: CPPC: sync policy limits when updating
 min/max_perf
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
 <20251223121307.711773-9-sumitg@nvidia.com>
 <9ea62a14-46a1-4238-97ed-aeabf9f3ab77@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <9ea62a14-46a1-4238-97ed-aeabf9f3ab77@huawei.com>
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
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 24336ded-df13-4c05-cce3-08de4ebd63cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVlHczI4ckU0OVVQbWY5YkhMSERXUVdHT2c3b3hybVUyUEpIcnVWWndSU0lV?=
 =?utf-8?B?VHMyR2U1N2QyMmFGTUV0c1RRS0JTVG1lZSs4ZHIyanl5QzRsb2dxREFGS0JD?=
 =?utf-8?B?NlAxUmZHOENGSWVvOW1MR3JGUTJ3SWVwZi9xRXdlNEMrZm1EYlhEaUY0UG56?=
 =?utf-8?B?VFlFZm5ZRWpHcmZpeWRNekRvajYxWVVhMDloRTMzMDRLeUNMSWJnVmplQ2V1?=
 =?utf-8?B?d0Q5LzNzYnVRV3FRNE0wbE5wWUR3MVFjWWt3dGlDWlRnNUNzbHQ1T1l1dk1O?=
 =?utf-8?B?TUc1bXVEbTB0aS9tM3JJV3o0MG92YzdEUmFEalpBNTQrNXFnN1MyRWhQNTJr?=
 =?utf-8?B?YkVSMVRJMmpLbTI1ZjZSSytwOWxnN1N3OG9LZ1YvUDJJd2JoQWFyRC9TdUtw?=
 =?utf-8?B?Smd5NXVBS1VPYURmSjdwSldvdHJqUHlRRk1RU0ZucWxLbEp3YTRmSURsNWs4?=
 =?utf-8?B?eTAvRXpEb2VINWxPek4xNUVJNVY5cmRSMTVFQy9QZit2WWttalRBaHZIb0xj?=
 =?utf-8?B?K2lLRnJ3Z095L1VVb2prY21NR0FmQ0RwQmczRTNaQ1lOWTBtbVMxdXJnRFVE?=
 =?utf-8?B?aEU3MlVjRTNwUFVrRG0xTGNqM1d5bTVSOU1mWVAwam9YS205YWJ2Q3dGUTlJ?=
 =?utf-8?B?RHpvUmV3QjBQc01WUUdLSnRYNVZSOTd5R01KRlBmcjE2Q2MxNlkrVnVENU5k?=
 =?utf-8?B?a0ExSFhVZUlyYUc4TGlNY2ZFeElKbk9CV3lYSGRIQWJYN3JyNTdTVWc4UmVC?=
 =?utf-8?B?Zk5Gd2hoSEpnZ2NLY0FYb3pUUTNPelZLZ3FXL2d3ZjBCSGxxMVJla0hmd3Vz?=
 =?utf-8?B?Q21FZ0czdzJjOU5yK25SMXQ5T2JkWGdwNFk4UWp2cUJNeG5qTjF5QVlNUWJK?=
 =?utf-8?B?dXFTd2QyYjRVWlJ3aHFUYVMzMVI3SFQyNnBtMXVVRXd2VW52aGhXZDZlZ3Js?=
 =?utf-8?B?TnBhOWhZMjJDOGdvQTJ0dDhCZWRUSVNJQ3prWllHR0FoUDJtVkwxVXhrcWdG?=
 =?utf-8?B?TVUwTzV3ZGQzaXhISDkyU2JZczBya3h4S0xUNTBoOC9kZTZiaTBOdklHVHFH?=
 =?utf-8?B?T2thRC9kNElvUDkwNkJkUTVDRWd6TEhFb2xhcWFFbU5DalFJZXRabkFaSXJO?=
 =?utf-8?B?SVJXSHczSEswTHpXVlBISHVaZnltQm9OZWNLQWFFRXVtTmx0T3paazJjd00x?=
 =?utf-8?B?OHA0V2p0MHVRMzdReWRwcUY0OCswVko0ZHoxb3NGbHZpSmlPYUdkSnZFOTFk?=
 =?utf-8?B?YW1iMUp4emw3VmtlQTZOTGNvMUZWOHZmODV5Y2drMHJlcm4yRmVwUU45YWJ1?=
 =?utf-8?B?V3NscU5OMG5sZHlYc3RtZVgvK1k2VVRFdzlLT1NFNGJIVVZFR21tRjZHQ0Jh?=
 =?utf-8?B?bksyeXN5Vmp0VHVyYXVIa1FHbEVEUHdVYS9ZSzdoZDgxRTNDWE9KeGtvU2ZW?=
 =?utf-8?B?ZmpWREd4d1czNUxjblg3dlkxUXU2ZVBDNDJwVDhqYWlUaURzdTVQU0JNQ3dw?=
 =?utf-8?B?R2s5WDRRZ1ZoTkVEVUxRNzFpcGhGbTBuc25tS3pVMFdVUGVkU2tGZ0pXV2hI?=
 =?utf-8?B?MVBOZXpNRDcrQ0Y0U21nWjQ5dHVhd0JxMi82eVVVZ1hlMzMwWDlOVElrRmds?=
 =?utf-8?B?eEI2K0xlaFdXZFBNc21ZNmp1ZGhoRXVWMFdGNFV3UVdmTm0xdDFzRUFjMHBw?=
 =?utf-8?B?SjVnTjM5aGlJZ3ZJR3ovQmdCNW56bVNNSHBya2gzZXpHSlMzUWtMTHlXd1dP?=
 =?utf-8?B?aWlaQk1uZTEvRWZlYUJpT0NvTXc0N3R0ZTRDRVF1SnRPZlp1WXNTUzJKcy9J?=
 =?utf-8?B?VzUxUW00bnpNWG5lWC9PcytKYWpVRkF2a2FGWmdGOHo5NTNlUllWd2VTanM1?=
 =?utf-8?B?TldKalhmNWFGRFlEdVhVdVFIaVZrTlFXa1o5WmJpOUp4MldxOVg1NWd4SlZH?=
 =?utf-8?B?YmhESm5pbmJqN1AvR0lQNG9veGI4NFhTUjVyV3BCeGtTTVRwUXR3aDVSN2ZJ?=
 =?utf-8?Q?hJKiQbFsMkm7RhJJsEd6pZVV3mGnYI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azY1d2lFYWw1TEg3bkJmSk9Oc0hvTktOemljRnFacWtWT0NzMjl4cHBUNWdT?=
 =?utf-8?B?SXk5bWI0ck5EaFFLWTNuNDFyajBNMlpzSDBzZ2tLZnhsY3RhelJYMHFnSjFt?=
 =?utf-8?B?ajJiSHlhRkFqUWU2V0g4WmkwZjJFSnlSd3dPRUh3ZFJDRTZPakpoeExuNHlx?=
 =?utf-8?B?NXpWQ25lLzBoWDJTQlZUSms0ZkErY1Q2cDl4RkFxS244OEk0eVFtMFRLa2po?=
 =?utf-8?B?YWdpMkpaODV5b2VKWkNhUmdoS3dRb1lIU3EvSERFbUNpOE1mUXFOK0dSOEFH?=
 =?utf-8?B?Q3pTazdna3Y1dUNubStTdUZDaEFESkZ6UE9XUVdUVTF0THZoaENNdzdISjBV?=
 =?utf-8?B?QjRmUUEwWWlLR1NJaHRBS3JLNWJKK2FIM1l5Vzd2NTZIUkdmbzU4Q0RnSTZV?=
 =?utf-8?B?VTVNWUlwSnl3bHZLcUlZSHc0NHhwZ1ZDY0FTdWpiOTlaN2NWZzc3bVBDUnBm?=
 =?utf-8?B?enBBOElWNUhYVHRZRlZxcjZSTjhKamdiUkNubUtsVU9sS3dtYkllMDVLSmRy?=
 =?utf-8?B?WTlxanpURHk2Vjl4QnVKU2haRVAxV3hWWEd0eEIwWnBTUkpmQnZaQ1pYTWZs?=
 =?utf-8?B?ZS9KN09yMkxhSlZrMis1SlhVN3dJNkppSUI2Y3pFUEZuc2FORlFZUGFCMmc0?=
 =?utf-8?B?eFNLNmhpWUtkdm9ub2VFSng4SHAzNTlPRTFvRHI5UVlOeU43cnBUU3JoeFRM?=
 =?utf-8?B?anM4eVJudjlhcllDRktBSllsKzdQbGVYTUFSbGtwYVFrT2xMNHdLak04eWMx?=
 =?utf-8?B?TkhNbVo0aXo0bGt3VW5JV0tKM2pwOE1DQlR2L0VUaC9RMDU1a1pzU1JJdkVV?=
 =?utf-8?B?M3R0OFVWWFpzTXlRb01EcHJoc0NYdDFFRmtzT1k1YXFwNEpsWDgzbGNVbTVx?=
 =?utf-8?B?SksraWo3VVlMakJ1K2k4Y1F1TmxOWVk0cEU2Qm5yNEs0UzlUTXhuVnpObWo4?=
 =?utf-8?B?ZUkycEpOYlUxRVAwYkdURllNQU9PQUJrMDFqWlZJSmN0MU54d3p1ZzFpVHZI?=
 =?utf-8?B?Z0JzWnN6ZEt1eEVOR0p0ZzN0bmRGTjNqWG9CSjJqVWNoeUx6ZFcveldOUDAy?=
 =?utf-8?B?L0RpOVJ0emc3YkxWVkt2QVV3dldmempHT0Q4TTBacitoeUtya0s4dGtQbnYx?=
 =?utf-8?B?YktjYng5enNuWXU4eFVrdmpuaEdOZXNEN0JsZDhJT0JsQXUyZ3RKZW16S3ZZ?=
 =?utf-8?B?K0RvU2hxb3d2ajlPcEJBb1JWc25FUWlBL2hRMHFJanJvaDNpQzE2VXlhMyts?=
 =?utf-8?B?aWRiUExvNnVMWDVEQzYrTHYzU0xpNDl2OWpnbkQ3TjhDbkhaTFpoSWtmNDFH?=
 =?utf-8?B?cmZOZFFSQm95a3FuSEpPN0VvQ0pNWm5pbDVidFMzcjRjYlp1OUEwVEFsR2tu?=
 =?utf-8?B?MVhCTnpEdFRtdEo2TGEzdXRoWUhJMXRJWFM4em8wdWdyQUlEbFpZUG1sTzl5?=
 =?utf-8?B?WndJa0NpOXV1b1NvL3VTN3JJL05QUUh2cUVCemV2WE12TysreFlLYXl1OTQr?=
 =?utf-8?B?VURPRythQXdqaW12VFJ2T2JXVmpXdXNDOVdJOUd3RlBEM1hiUnVjK2hFSGFX?=
 =?utf-8?B?RUxESzVFakhHWWdDK1BiU0tOQW1HY3ZxTk9qc3N2bDJia1VPZzBPK0t4dUxq?=
 =?utf-8?B?RUZrVzlHZGRQdWhleFczcVlyeWZIeGNIYU9NTGk3VGlpenViZFFGdjB0M3Iz?=
 =?utf-8?B?VnNWU1c0cnBud2REKzVaRklqbE1td1JSbjJTalpqbU84NHFTNnlYLzdJb3ha?=
 =?utf-8?B?cTNBOEZLdHBvejZ4OUZpK285Q1dlSjk2M2wwTWU4Q2Zaak9yWGN1K21DbmJP?=
 =?utf-8?B?MWhHdU92RTFPaW5CelgzcVptN3dCWWRlcjBOQm1aZHVXVGJkQjZLSUxmZ0dK?=
 =?utf-8?B?WUJockhpbnNwT2lOa3BZQlo4QUlDWHhMZWtFdlNsZDVYYXdHbWFxaVNUMTZM?=
 =?utf-8?B?Nk9zSmQzbFNuekVXWlZ5SVIxeDlxRTBNYVVLWEdzeVhMN0ZOSGoveDNmdGIy?=
 =?utf-8?B?U3lHVElFNVRQWm1QYXJIUEljamhnQjlVcXBOOUttUXlnNlRIaTM5bmVvWWJR?=
 =?utf-8?B?SDl0NTBBd3BkM0kyNmtBY2ZKUTliSWYzK05wTm1DM3djYmRVYml1alE3Nkdp?=
 =?utf-8?B?Y3hRYzJNaXBjQUdGZUt5SHVpUTRWNG1HL3Z5UXh1Vm14cE9qSG8ydGdUOCtE?=
 =?utf-8?B?Y3JHRnVqazY4ME01bnBQeUYybzBOUzR6NVlFQzFENG53MXNhTE4yY3NLbE9U?=
 =?utf-8?B?YytxOElVV3RXUlZCT0FUdjRNT2RKdDEyVFk5cGtjOHRVOXdWRkVrbkRYYzZX?=
 =?utf-8?B?OEwzMU5sT3BtcU9oTlVSN01aY2lubVlSOWdJaWg1L3dyT1Q4MHpPZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24336ded-df13-4c05-cce3-08de4ebd63cc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:54:06.6677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1QqC2GWCsfWO9cXmfC4hEiDeyIVXCfGBQONm6I87R7VoPMYZ4yLClS2OoKU+w/B82n2GVbkKBPz1A6Qidr+dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062


On 25/12/25 19:26, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 2025/12/23 20:13, Sumit Gupta wrote:
>> When min_perf or max_perf is updated via sysfs in autonomous mode, the
>> policy frequency limits should also be updated to reflect the new
>> performance bounds.
>>
>> Add @update_policy parameter to cppc_cpufreq_set_mperf_limit() to
>> control whether policy constraints are synced with HW registers.
>> The policy is updated only when autonomous selection is enabled to
>> keep SW limits in sync with HW.
>>
>> This ensures that scaling_min_freq and scaling_max_freq values remain
>> consistent with the actual min/max_perf register values when operating
>> in autonomous mode.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 35 ++++++++++++++++++++++++++--------
>>   1 file changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 1f8825006940..0202c7b823e6 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -544,14 +544,20 @@ static void populate_efficiency_class(void)
>>    * cppc_cpufreq_set_mperf_limit - Set min/max performance limit
>>    * @policy: cpufreq policy
>>    * @val: performance value to set
>> + * @update_policy: whether to update policy constraints
>>    * @is_min: true for min_perf, false for max_perf
>> + *
>> + * When @update_policy is true, updates cpufreq policy frequency limits.
>> + * @update_policy is false during cpu_init when policy isn't fully set up.
>>    */
>>   static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>> -                                     bool is_min)
>> +                                     bool update_policy, bool is_min)
>>   {
>>        struct cppc_cpudata *cpu_data = policy->driver_data;
>>        struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>        unsigned int cpu = policy->cpu;
>> +     struct freq_qos_request *req;
>> +     unsigned int freq;
>>        u32 perf;
>>        int ret;
>>
>> @@ -571,15 +577,26 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>>        else
>>                cpu_data->perf_ctrls.max_perf = perf;
>>
>> +     if (update_policy) {
>> +             freq = cppc_perf_to_khz(caps, perf);
>> +             req = is_min ? policy->min_freq_req : policy->max_freq_req;
>> +
>> +             ret = freq_qos_update_request(req, freq);
>> +             if (ret < 0) {
>> +                     pr_warn("Failed to update %s_freq constraint for CPU%d: %d\n",
>> +                             is_min ? "min" : "max", cpu, ret);
>> +                     return ret;
>> +             }
>> +     }
>> +
> OK. Now I see the necessity of extracting this function. But why not use
> freq_khz as a input parameter and convert it to perf in this funciton,
> since you need the freq here?

That will still need cppc_perf_to_khz to be called so that policy
has what HW actually delivers. Otherwise, there could be some
asymmetry.
Also the clamping is done on perf values. So, if user provides a
very high freq value then that will get passed to freq_qos and the
HW register will have actual perf value which doesn't match with qos.

Either way the conversion chain is:
   freq_to_perf -> clamp perf -> set perf -> perf_to_freq -> set qos
It's just a matter of where we place the logic.

Thank you,
Sumit Gupta

>>        return 0;
>>   }
>>
>> -#define cppc_cpufreq_set_min_perf(policy, val) \
>> -     cppc_cpufreq_set_mperf_limit(policy, val, true)
>> -
>> -#define cppc_cpufreq_set_max_perf(policy, val) \
>> -     cppc_cpufreq_set_mperf_limit(policy, val, false)
>> +#define cppc_cpufreq_set_min_perf(policy, val, update_policy) \
>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_policy, true)
>>
>> +#define cppc_cpufreq_set_max_perf(policy, val, update_policy) \
>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_policy, false)
>>   static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>   {
>>        struct cppc_cpudata *cpu_data;
>> @@ -988,7 +1005,8 @@ static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf,
>>        perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>>
>>        guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
>> -     ret = cppc_cpufreq_set_min_perf(policy, perf);
>> +     ret = cppc_cpufreq_set_min_perf(policy, perf,
>> +                                     cpu_data->perf_ctrls.auto_sel);
>>        if (ret)
>>                return ret;
>>
>> @@ -1045,7 +1063,8 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
>>        perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>>
>>        guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
>> -     ret = cppc_cpufreq_set_max_perf(policy, perf);
>> +     ret = cppc_cpufreq_set_max_perf(policy, perf,
>> +                                     cpu_data->perf_ctrls.auto_sel);
>>        if (ret)
>>                return ret;
>>

