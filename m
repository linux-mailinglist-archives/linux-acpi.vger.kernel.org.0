Return-Path: <linux-acpi+bounces-20078-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C7AD05253
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 18:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A797D3118DE8
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF932DB78E;
	Thu,  8 Jan 2026 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VBMQSrZr";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VBMQSrZr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD2500949;
	Thu,  8 Jan 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890950; cv=fail; b=EWxMWPxoB3eN2k3NpVapoc09U6uiK2QDIsbPS0C2oGndazCjvqRxLuFM6l5Pzvt7xHzNqWEo2t6dtFd3+aHBSK8P5rwYJgU8uRlpTvwQ04q0rd5SAgf1BXCOtM/hsZhZ5pAnDrnNI03WgaOp72EkEGrEdtbUe0xTyMK2eq7etmI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890950; c=relaxed/simple;
	bh=G6yhgby2ekXMUp8kRQw61nmRamzgh7u4oDGCYmEgfrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r91b9iUxwDTP9DKrPmTBrwmijXOfogp8sK1iOjJtjAxmAp08d+/ERr/E27Yxz0Tw0cXv8VEO9MU06XWParZtWdbep1+8zFJrvy//TCw+CksKPNJe8volHyYFTHWGnSTxvCpeFM6i8Mio+tp4Bf+AK6utlXarErJL99tSyTWOC6s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VBMQSrZr; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VBMQSrZr; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OPVaik9alGB5zcb1r0M0z/fOQbML+udNDl0uroa2c/WBk1mowrHJkrb3sW6H5Is2HP7vlXqPRtnWEfzCIBRmZYm6/Ga+0Ij/Em5+NAq3SZRKWg2APJDX1wW4nOPmSKk8UgT4sDJHSKX3nHmny48A7AR/xRzPN4ooOsZkMOZNR9s7gZatTm9CjVE0n8RnVIUwQ39zu7tEPOkCjdKHSzQUJfKMMOdq6AUmGtP7y+SUwXLD/JCvP4721OcSHph5h1btvUw9izCwpwcBdZxTau7ZuzdrnS1b1qfyGVMDrXP4ePRU+IRtyBUQisE1i9upZYZAu0vM+ga4ukRtpsn+hQM+Og==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D05YHSka1StVM3jnM9rqEBsBB80HKJAyNE6esd7FbDo=;
 b=mfov6n0/zO/oxTN/oDr4VoGfDGBW0c4/vDBBECSqAGy5S+Wm6RUWKcBY+JANZFUx/hVtehvH8HKDFyK7KvN7WvsTCgn6unSlsJfzWo6QZMs/jN9owvqslM1X5vPJzK6Na6tXDPHQlQfhm5ThAiueTg25WI4IRgn7GX81jx3hNUg5NOo93l3x2KJkdc9jww61iAGdqDEAzp7WNjwLDpuSH0Dfk4LFNwomCCoptnnqn5p5ejk7HdT2/E91KOQvzBfYbSbCRCa82lbLjBXKnrpdxOOdMu+Yjyd3TEjPDTSlvEYxajblz019v87KcfVX5UC4Bnc13DHMt33md21wohyP6A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D05YHSka1StVM3jnM9rqEBsBB80HKJAyNE6esd7FbDo=;
 b=VBMQSrZriRdJTq4m/twhq/AUXw00B85FPLO4r3rmwVWmaJpQnr2mmehBTDMp38GpypIHvLDXmuoIXr0A0gXA4vUhr7RUuIR0I7v7GA1mTX7lDonUAUxOrLO8xWW4V0U8gWZQ+DSu1izzEpNQw9JxQiH+HQEM32ha7TeSrdV7gAk=
Received: from DU2P251CA0020.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::29)
 by DB9PR08MB6684.eurprd08.prod.outlook.com (2603:10a6:10:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 16:47:49 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::d4) by DU2P251CA0020.outlook.office365.com
 (2603:10a6:10:230::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 16:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 8 Jan 2026 16:47:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPck8azfBpwWTtiarV68hVh8RTMbFI/7FLmMZxMilYaQEbIOxWHyvKL+5niUTKsjQKCHn3lhX6u4d4QeZDFQGRpBhRFBdv+ABKuiPYH69JNV10+QeWC9h7H2iecF0SbRdCIId4XtLTAhN5iHivwJ/Erqkls29nDmY75tOITr30RnTRSp2TAc0vPHwKJGlthdYzg02RfSbBYqIQDp9YlYMjZO76Ks14GAhFixp6L02NKAa4bzpMZJ6/v/n9XhfkS0/i90i4ExLu+mF8q37ewxc/ZFv0mgDkDCSsS/T8CrIdrqfx76QGjplAwrUl+Ua4UABWZQXJCoSUmneSntphnL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D05YHSka1StVM3jnM9rqEBsBB80HKJAyNE6esd7FbDo=;
 b=CKDjtSPKodtPjpkGG5ZOEru5V9sPogFjxLZh4WgDPUkR4kc3jgd638ALDEPHdDSWQNO764XH9Ql3zyaVtIvqc/ktHvgz1t9Fj/PDGVT1lL2ik/B7J90MzZ42tWjUc2ZPMxq0j8uIY5I/VZoJWTEgpVOSTB+ygqUMgYNLmCxBWwlEQHsmj7g+xnIM4N4SP9cJWgRMyh2zrjtcQx2aRTLNa1qKHvIP8hlFiqxREgcWr4e8noomMp/q4nLydaBnZHKWY8lGSYirSgqXgjcnZIW6jEnqlkXCeM7DYavyG9xPXTsK6gnwvEutejI1psZDQSDd2K9ZdG3rtPLKSfKcCLw0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D05YHSka1StVM3jnM9rqEBsBB80HKJAyNE6esd7FbDo=;
 b=VBMQSrZriRdJTq4m/twhq/AUXw00B85FPLO4r3rmwVWmaJpQnr2mmehBTDMp38GpypIHvLDXmuoIXr0A0gXA4vUhr7RUuIR0I7v7GA1mTX7lDonUAUxOrLO8xWW4V0U8gWZQ+DSu1izzEpNQw9JxQiH+HQEM32ha7TeSrdV7gAk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by GV2PR08MB11255.eurprd08.prod.outlook.com (2603:10a6:150:2f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 16:46:43 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 16:46:43 +0000
Message-ID: <ed9015a3-42b5-4c0e-af6f-2b4d65c34cd5@arm.com>
Date: Thu, 8 Jan 2026 17:46:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] cpufreq: CPPC: make scaling_min/max_freq
 read-only when auto_sel enabled
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhenglifeng1@huawei.com
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, ray.huang@amd.com,
 corbet@lwn.net, robert.moore@intel.com, lenb@kernel.org,
 acpica-devel@lists.linux.dev, mario.limonciello@amd.com,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
 sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-11-sumitg@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20251223121307.711773-11-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::8) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|GV2PR08MB11255:EE_|DB1PEPF00039233:EE_|DB9PR08MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bd78bf-5ea9-4f1e-718f-08de4ed5a7c3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NkxxS2ROb1BIbE8yb0I5aloyck5GOFBRZUE4aHJFajlia0szWEo4Zmh5UTV3?=
 =?utf-8?B?b0tUUURYQks1S0pUUUNPd1lOcHllMHdWM3kzbEhqWVBJSTBzVVY2aEtnY0dU?=
 =?utf-8?B?WUtzT3RnY2NtK1gvc1preUFjRFpkWlRyUSs4b1gyLzR0SUVGMVhhVVE4ZDhy?=
 =?utf-8?B?OExMeGEvd3NNTm05Vm1Md3pVY3FqR1ZNSzJzejhsbFBQMUhkY1ducDVKWDhF?=
 =?utf-8?B?dkZJRVZ5NDRyTUU0aS9DWUxhNy90NVd6WWxpeklCS3M3alZPeTNsL3ZBS243?=
 =?utf-8?B?bHVYaDU5d0ZpbzliN0VLQVB1dG9BcmlwaVBCMi9iNFpXUUtUZGdSS0NhQVlY?=
 =?utf-8?B?dmY5UDZGWloyTlBUM1pCVXh4QUhSOVlLSW1wcnIyd09vdDBGSlBoVmtEcGVy?=
 =?utf-8?B?MFg4U214V2Zoakt3c3o5REZrRDVYQy85eHlKUCtCdi9SeDdCeURCVUEvekZ1?=
 =?utf-8?B?SmpCMEdOQjBCUGY0VCtHN2tqWTF5eEZPck9BQTVZSnl6N05xamlKdHZBaUtJ?=
 =?utf-8?B?eHlEU1BDamY0VVJjYk9rMjAzK2xhUUJlRmJOcXNWZy9OUEJuQzJNK0xFajc4?=
 =?utf-8?B?Z3VmSkVVUVphR2hTSVdqUThMUDQ0YUxJeCs3Z1I0NzE2NUZVZUpqaDQ1VFVY?=
 =?utf-8?B?eFU5RVArdUFqeS8xQ2FKY2dxYXpuQnRxZ2VVd1o2NkxaUnZUdVgwc0JScGZi?=
 =?utf-8?B?bzVNazZiODBTYlZYd1d0czVzclg2M3hUN3BxVUR5SnNlaklBY1VNYTMwZmRv?=
 =?utf-8?B?NDdISG1CVStLc0h6dmx1RUU0N3NVdXZvQlpZelNWelFMVWVSQi8xU0Y1WVMz?=
 =?utf-8?B?aEhHeTFxR3ZreDlJUTFYUDdnRmRUUXhuYWdvckYxd1NFM1JSY1ErK0pQZmd0?=
 =?utf-8?B?SVJVY1oybUhwU1czQy9iWWQwdEtTb1BYU1N6K2ZqZXBKRG95L3JFTlRPWE91?=
 =?utf-8?B?VDFXWU1aMmpCb0lSVVQrZ25yV1JEWVJjcjgvS0VTOHBsQjdLVG9JQXRHTm9j?=
 =?utf-8?B?bCswRVNNd2R2elBWQjZrbFBZUjVPZVF2SVNsRW9vT1VIcm1uS0w2eDN3V0hU?=
 =?utf-8?B?RVkyeEkrNHhUSUVSN1I0YUxndDJodVJydXlZSmZNZFEza1pLbHd3RWtHcG04?=
 =?utf-8?B?UXhPeWZZRkVPc3JGU2ZadnBta1cramREQ1JiWHA4TU4rakdaOTIydVdkWlVs?=
 =?utf-8?B?YmY5UVA2ZHk4c0Z4ZnZ0R0NZZE1zNzlqdTBsSFNHbC9UK1hGZkNTU0J3QVJ3?=
 =?utf-8?B?bGRYZVZ6dEtGdjNTT0QrTzlEOSt3Rkh1eWd1MDdpWnZTVGp2R0ZETHhPbVFG?=
 =?utf-8?B?S1JDdFlobXBKZ21OVXRpVXkyZDJJaDAyQjBqMWIvWi9nSW1ZbjFOaHRnbkQx?=
 =?utf-8?B?ZnExbUFzaVc5d0p3S2IvSjhqYWpQZStDem4ydWVMTkVNTXZzaFdYS1pkMGJR?=
 =?utf-8?B?WTZmUUttR3h1WklCWk1tQkI4R1dDM0R4QlpYK0RlYVBmcVdrT242eGx0bStF?=
 =?utf-8?B?RGNYTFVxa2dWZGM1akVaNzRMODlJQS9tN0lIcENVVWFiekRGWk5wTzIyNXJB?=
 =?utf-8?B?SVd4K1RINm9BaDBRMCsra1dkTUwvMk9sUUhiM0NyVHY4a0Fqdkgwck9tR21L?=
 =?utf-8?B?djREYmZJRUxQb1dxa04xQ3l4V0VDTExYUXVNZURDZnZhaUxlUER4bVRRT28w?=
 =?utf-8?B?OVpkaGlLTEZrSHVOZzZlOHNFUk9hU3FuOFNjVXlwTGVrOGZQSkdJWk1NNWN6?=
 =?utf-8?B?S0NhZ044TFdudCtEekVPcUwwVVdQTDhMdXVCL1pBbmJXZ0VjQytDMXQrazIv?=
 =?utf-8?B?NWZKQXBvTjJqa1RjM1FOT1FuaGhSSmR3Rnkwblp1N01qMkpIdFJHODQ5SWd5?=
 =?utf-8?B?NmNJK2labHNrM0RvRGpxTUg0aWFJTHRGNmlYbGlBSWwxcHRFMkg5MGJBYUdT?=
 =?utf-8?Q?ogHY2RiAhB6pIDvgrEtJ6cawXagqL/HG?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11255
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	33a4afc7-0654-430d-224e-08de4ed580a8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEl5MWtjMTBCYUJSaWFNSExpb2pEbzc3eGZhM3dBckhNZ0poL2VITXJpQWpP?=
 =?utf-8?B?MkF0U2JjaTc4U25hdWtiU3c2T2dHT2ZtbDZOcVJzYlE2WUozQXhCR0FNTy9t?=
 =?utf-8?B?akxFWjBONEk4cU0rVVpJZkZrc0tweWxDWmpBWUlyZjB0dTRPejVIU3RxZ0VI?=
 =?utf-8?B?ZXp5L3JHbWVubmJWYUdSSU1vbjE1UzRSYzNWRTZUVGlnMXBSUTdzeWw0ZHpt?=
 =?utf-8?B?blhpcVRHeFlIYVgwR2wzbUVkWnVVZDMwdHl3bWgzeUxDYXlDT2dDcnFoTktr?=
 =?utf-8?B?NFZ1RjhzOVhZb0krT0N4MU9lUWVrQ2tmRGxXRjQvQW0wY0R0STY4anVaUEE4?=
 =?utf-8?B?bW5nZUV3MkVYV2RtOGhPQWRtaHF1QmV3akNVQjMvNThwbVg4ZHNwUm04NERS?=
 =?utf-8?B?UGdWVVRPc2hWejNJeEdlVDF5MGpsbUliTDRrdU0vNE8weUcyb2g4UWFJMThY?=
 =?utf-8?B?QndhWVpyL1ZtMEZXV1ZROHE0VkZXYWV0ankxTEh5TUtSSVMrOXRvZG5KTkkx?=
 =?utf-8?B?Sk9xMEc2SW9LeWsxdDhlZU9hdFZKRlFWdzk5WDJvWTNGc0xzNi9kUWJIMlBD?=
 =?utf-8?B?ZFhtVlQrOUo0djcvMUhBOHJ5K2J2QnNBTUlwdmhhWE1GVGhXQUtsWnBjdDdH?=
 =?utf-8?B?cHQyY0hSMzZqVUZFRDhFZm9VbkZlaVNvL2JRNlNWN0prSSsxdC8wOHQyL2FF?=
 =?utf-8?B?VEhFSExZSGVzNHhIOEgzaTJXU2djV0F2MnpqTjY1SmxvQ3FteGZJbmxpVWhr?=
 =?utf-8?B?SXliaEM0N2ZjT2lpRUdSMjhoeHR1Rmh3OHJzY0NGRUFSWEFYSWpWNHFGZzFL?=
 =?utf-8?B?eWxlMmtoa0hqSkQwWnliTzAyWG5kWGI2R3lyV0JhTFRpcm5JdGhSOFZaSFp4?=
 =?utf-8?B?cW5pSnc5OFVPcmFROHU5QjBDMFcvME9aYzZVZjBDc29zc3VXMTZNTlcxWDZz?=
 =?utf-8?B?eE43Y0NtVThOMzk3UGZtOWZEUnJVNkhkQXliT0ZlcnpGbDdNaGxteGZPMXlI?=
 =?utf-8?B?aEIrQzJlMHNGQkN1ZFpNVUluVE96ZHhlbEpMT1l6VjFtZVVMN29UVnp2bkJW?=
 =?utf-8?B?bHBsb0pKTHNET25LazBQaW5PWUxaeG15eWJydWYrM3RBejh0QTYvMGZQYUIz?=
 =?utf-8?B?ZFI3bVVQcjIyZkY5NW1HWEsyYW9iNUdFdG9GY1pscDBMQm82OEdkcEZPZW9s?=
 =?utf-8?B?SHEzUTN4YlljeGtsNklHQW9PSVJHcjQraUE4dytQbDF1Q2cyVEY3RFZta01k?=
 =?utf-8?B?VnFpK0RFd1lxbzlVS3JLVm9lWC9QOTlNeUFEemF0dWU2WVlCQlk0SWdlMTRD?=
 =?utf-8?B?d3RjeW1LVDR4YlVqZjRlVXpRazYzT0cxYWs5VlpMVHNOTjFlQ0pXU3RCVGZM?=
 =?utf-8?B?ejRaQmU1OVBxMCt4bXJLbTFjMkVSVGVUaHFuSmlOdzJ0Qk4vZUxXVHNKUm9Y?=
 =?utf-8?B?d3cxUlhzUkxXMVJFRVFXSmdudDY2N1N3K09NMnR2eWZud2JXc2JiOWh6ZzNC?=
 =?utf-8?B?b3A0cHlLVXZUQ0FEbUJ0OTdLSStuZDhKUG91dmdqdHBYVy9tZDZmZS83VjhO?=
 =?utf-8?B?YzNSZUdGK0V5SktqUWlwSE9pUWcvZUhDL1NnRUFkQ2xpT0t1VXhhbHpVVWhh?=
 =?utf-8?B?d3lCZU05U0VieGxHZGYvUVZJRUZJYnVIUHFCa0w2YzE5TkV1MlBTT1djL1pS?=
 =?utf-8?B?THNjYTV3NDNNUHR4WUlEOXB1Tm1Wa2NPOVExUTZRUmN0a2xrMndSZDN3cTNM?=
 =?utf-8?B?ME96TDB4ci95RlZhQkhGOERDWUhCRkpndnd0Y0lpM2VtL21POFNKMk91VnQ1?=
 =?utf-8?B?T1F0OGorSm9hYlFUVkd4T3pyK2xZYXE4UHFSZk5LTlFsYUZ0eU9Gb21JcW9C?=
 =?utf-8?B?dXdGWHRVRDloSjdtT3VReG9BeE1Cb1RRTWp5MWJlVG45OS91M1JQVkJEQUFa?=
 =?utf-8?B?bkJCOTY4R010cThHMTE2UE91RCtSbzVrbnhlSE1tRTlFTmVkSjZDK2NDU0Np?=
 =?utf-8?B?L2NGWkJwS2YwT2RZRXEwa25SeEFCTThFKys2WHRPdVhYRVVQRnNTUVpnak1o?=
 =?utf-8?B?RnZEVlJnNVlmWmYzSHBTTG1lelJ2WU1oU0dMdFFadUVheTU4N2xCMkkrS01X?=
 =?utf-8?Q?+1Ss=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:47:48.1713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bd78bf-5ea9-4f1e-718f-08de4ed5a7c3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6684

Hello Sumit, Lifeng,

On 12/23/25 13:13, Sumit Gupta wrote:
> When autonomous selection (auto_sel) is enabled, the hardware controls
> performance within min_perf/max_perf register bounds making the
> scaling_min/max_freq effectively read-only.

If auto_sel is set, the governor associated to the policy will have no 
actual control.

E.g.:
If the schedutil governor is used, attempts to set the
frequency based on CPU utilization will be periodically
sent, but they will have no effect.

The same thing will happen for the ondemand, performance,
powersave, userspace, etc. governors. They can only work if
frequency requests are taken into account.

------------

This looks like the intel_pstate governor handling where it is possible
not to have .target() or .target_index() callback and the hardware is in
charge (IIUC).
For this case, only 2 governor seem available: performance and powersave.

------------

In our case, I think it is desired to unload the scaling governor 
currently in
use if auto_sel is selected. Letting the rest of the system think it has 
control
over the freq. selection seems incorrect.
I am not sure what to replace it with:
-
There are no specific performance/powersave modes for CPPC.
There is a range of values between 0-255
-
A firmware auto-selection governor could be created just for this case.
Being able to switch between OS-driven and firmware driven freq. selection
is not specific to CPPC (for the future).
However I am not really able to say the implications of doing that.

------------

I think it would be better to split your patchset in 2:
1. adding APIs for the CPPC spec.
2. using the APIs, especially for auto_sel

1. is likely to be straightforward as the APIs will still be used
by the driver at some point.
2. is likely to bring more discussion.


> Enforce this by setting policy limits to min/max_perf bounds in
> cppc_verify_policy(). Users must use min_perf/max_perf sysfs interfaces
> to change performance limits in autonomous mode.
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index b1f570d6de34..b3da263c18b0 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -305,7 +305,37 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>   
>   static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>   {
> -	cpufreq_verify_within_cpu_limits(policy);
> +	unsigned int min_freq = policy->cpuinfo.min_freq;
> +	unsigned int max_freq = policy->cpuinfo.max_freq;
> +	struct cpufreq_policy *cpu_policy;
> +	struct cppc_cpudata *cpu_data;
> +	struct cppc_perf_caps *caps;
> +
> +	cpu_policy = cpufreq_cpu_get(policy->cpu);
> +	if (!cpu_policy)
> +		return -ENODEV;
> +
> +	cpu_data = cpu_policy->driver_data;
> +	caps = &cpu_data->perf_caps;
> +
> +	if (cpu_data->perf_ctrls.auto_sel) {
> +		u32 min_perf, max_perf;
> +
> +		/*
> +		 * Set policy limits to HW min/max_perf bounds. In autonomous
> +		 * mode, scaling_min/max_freq is effectively read-only.
> +		 */
> +		min_perf = cpu_data->perf_ctrls.min_perf ?:
> +			   caps->lowest_nonlinear_perf;
> +		max_perf = cpu_data->perf_ctrls.max_perf ?: caps->nominal_perf;
> +
> +		policy->min = cppc_perf_to_khz(caps, min_perf);
> +		policy->max = cppc_perf_to_khz(caps, max_perf);

policy->min/max values are overwritten, but the governor which is 
supposed to use them to select the most fitting frequency will be 
ignored by the firmware I think.

> +	} else {
> +		cpufreq_verify_within_limits(policy, min_freq, max_freq);
> +	}
> +
> +	cpufreq_cpu_put(cpu_policy);
>   	return 0;
>   }
>   

