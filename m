Return-Path: <linux-acpi+bounces-18186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F7C06781
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 15:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5551C02577
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD8831B13A;
	Fri, 24 Oct 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nrkvdaps"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5E2D7818;
	Fri, 24 Oct 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312191; cv=fail; b=mfgivU8d4iepTuZhQLrOBIFTkdiovk0YSiAfl911oD0gOTdDuCuZ9acBK04WrMyMFc6H2y5Z1bjkBc+NzFboGzOy80dt4z/RXeMIpOB6FL9QEi+Zn7LrAkEXjgvCmLiLyjI1o7FPY7j691P6oJeNa3tcZ24YqhosrmvsHiXoxEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312191; c=relaxed/simple;
	bh=CCiDXMA1r6AzGuuWoVCoDvIOuVVXhsmcF+qjSTeZmQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AGExKg6czNDufs4bHK3M+JH6nE5wsS6dcu4G9yyxEGtE0qNBTVDhyk3ZajXNU2jGxApStDp3CAsnSphPmNjxRPXxExHbxe2HQmia4w5VfeL8no4stmEylrM8Qgu6sv3JH9Y2yT1UIsuptiMpiXuoxVSpqlAf5JNBOJelIGEJuyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nrkvdaps; arc=fail smtp.client-ip=52.101.61.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1kbN2l1Zk3xFTMYlZSS5U2NX1XT8c/RdsPEle7kPaAEcxtdcmlPn5QJrWflWxpoqjkZHCB7QvO+0UHSO51xmyKMCiVNuzwKUxCXtkr1Q/pkBYqISWMYwK6L2gigYq/wvx33dYTNUmdgxwXPGBFUqE0HzkJQi0tHqkLdsGT2wRDmwP6bCUp0OUZgC3EQWdAhr+MKC3wGqez7dWTvHFfWeWAWrE/+JOdOUPBAj0zpLjjEXwaegCf0zlrZAM3Xp0dq144aXM0WZMaSKUWVBjhwS0rx/I1IJS1ryaDWq14B9K2TzYKWkfVKz/pA/PcDtzZjhlWKMj9094uK2hPEb7uvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwQDYLe6VEeJqS0Hq8KmSmvkJSn8Ol8132pAMDlgkL4=;
 b=cymwaq8gBDO+IwCsFIEVf22I4noNtKHs3XxzD2z6f/Ai1pcMbjSxvnnBGpJH5L2phRgwbRSuJ5d/hkmbGq7gC1vGDFN8uLlrF/uawGRgsMpdVsGrId+AeR8mXIO/TA6S6v5qv+O/GcOwD4o3Ge1sCN1KCLhgH5KpuD+jWFifuVCcVC4ayLFt5ftmTzWdHtxM6gBZzUUkK1/9GWbbCcfWgdGKnv8UpMYUXvicjyWzt6NIPoPHeFho9BJSsf91Dlv0ojHzGPzpXcFQDogTr6HFlNnQ6d3l3HB1tjqnbCrbKdxoMBx3EnixhuAGIXp6xx6Ba49tlFxJSWn+iloGdiWpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwQDYLe6VEeJqS0Hq8KmSmvkJSn8Ol8132pAMDlgkL4=;
 b=nrkvdapsFIflveC/6pppGHGKNKeVF2aXc1MOHlskQolKp3aoUkjR2FX19DxBztEJkQRfC0ZEcpsD1rC6eMdJwxrmpDK8c6FbOSkotSy1FG2wIvtXcdbfgmw/zgg7wBxaluxs9xwl5i4KuoZW0jekU8Iay/BwlYwvbTkBXYAInZ0jeAaBjGOW0lzG37tnom7xAG6XIzECkZkbZDcqnH2lPEh9B0SgNjz7OpomMKsl5HfkR18gSzyEymO4/RK3hiOgD1n0hfedT6xELrXx9EnUqztKYwB4arScxJQArVmc9/OWVsdstBgkChRrWQWNZWk5YRt1Y3XaSroN1+NwqjaJbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:23:04 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:23:04 +0000
Message-ID: <80e16de0-63e4-4ead-9577-4ebba9b1a02d@nvidia.com>
Date: Fri, 24 Oct 2025 18:52:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
 robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com,
 sumitg@nvidia.com
References: <20251001150104.1275188-1-sumitg@nvidia.com>
 <20251001150104.1275188-5-sumitg@nvidia.com> <aPi48fm+cMDmQBN9@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <aPi48fm+cMDmQBN9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::9) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cefceb7-ffe3-4a9a-e204-08de1300763b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czFIaDRBM29aN0lnWTFrcnZLWm9LS2djTkc4cmVDaUcrTXZ4TTZhQWdqWnpo?=
 =?utf-8?B?MHpkYjRIZHBMYTZ5WUFMNUR5anpPTXcvRlRXMGZ1L0dtMVcwVmNFaHZZZ2R4?=
 =?utf-8?B?d1JHQXJtNGVaQWVFaVdiK3ZwdmIyK3pzTW9tZlJUcm5MQVNtMWFqNVh5b3lz?=
 =?utf-8?B?OGxRdGxJSTlvT3prcllrcjZPQU83ZUtWdTZ4MS9tTStKd1pTMzBvbHVhZHVZ?=
 =?utf-8?B?RkhEczJvQlpDaVp6VjJCVFhCL21pSUNhK0twbTY5N0NnSVM1am1CME9vdFFB?=
 =?utf-8?B?UG16Q0pGYi8yd1BvUW13cDJFYWhMcU55ZDhIZ3JDdGE0b09IenhHcFVCcWNa?=
 =?utf-8?B?RVJTemhEV25TWUVJZmFqUnpGQUZBOW9ETy9jbXMrcHQxKzd3UWVDMUJiMUlp?=
 =?utf-8?B?SE9GM0FLUW9aZmoxWk5DT3d0VzhVUWxtKzBRUjZJWG9OM202WG9jVEJGQWtN?=
 =?utf-8?B?Q2ZOc0VFbUxrakhNUUttYzlyS1oxQU5qeGVvTGlvS2NZWjcvYWJ5dWNSR2tr?=
 =?utf-8?B?RWhEZlFPZVZKU0hIbjJ4TnVyaHBkRFE2a3YrdG40QmkzN3Z4MFVTU3E4L1BU?=
 =?utf-8?B?MElRNG5aNS9zSWNzWmh4TElhVXd4T3RoRTNJb1RIVGYxSmVvWDZLQXMwc2tW?=
 =?utf-8?B?UG1vbi9rWVFpT256OSs2T3ZGNnRweWxIYjBUaEx5RUcwWjJOeWZoTVd1V2pB?=
 =?utf-8?B?THV5MlVKbjlhTTRQZ0VMb2Fhd2hCZERLbUJQT1hTOW0xOWtsM0psQTg2UWQ5?=
 =?utf-8?B?aUVRWkhSL0FDUmNzd1hrNUo5TVJBVmZpdDlPOHNaNWJ2dkw2M2thd0o5QjBV?=
 =?utf-8?B?NEtQQ1ppc0Y1eU5McklRLytNYmYzWXMwYko0T1FOeVhvYTZvUHk0bThpQ2JG?=
 =?utf-8?B?aWdRUU9vRlAxWUZvZFQ0SU01azc2bHo3VGhxaXgrMHpZWDdPYUJSaWtNVnls?=
 =?utf-8?B?TVh1TTFMNGlPSjRTZU53NHZ0Rzk1Ync2T1hnSHYybzZLaGhleVJzand4NE9O?=
 =?utf-8?B?TjAxWFNNVXRwOWdjSkV3OURXVVJTZ3M3aDNTSHJQdW94UCsvZzBqSlgwUktE?=
 =?utf-8?B?K3EydlhzbVFYYktNaTFTYmlyOG1MVjZKOGNxY0ZMeEUzMnJjTXFMaCtkMndS?=
 =?utf-8?B?L214Nld5N0h3STJaVGdZV1N3QnBwcGRHcjdDSi8ycWMxdzFsRDlvYVNXRmV1?=
 =?utf-8?B?U3hhOWJaRGZFc0pNTG16UG9OeFhMNGRIZ0l3eU4ybk84Y3BZMEhJdnZKZmln?=
 =?utf-8?B?MHkxODh2K1hQTHRHTDBhVjQzZUtLN0gxNVN6clJwZndhSDVsRHprek9oK1Fn?=
 =?utf-8?B?WjFLcDNZdUlVTkkySHBWWm8walNHTDJqT28wZTdlRHM1ckxEaUtQVFk4dnp0?=
 =?utf-8?B?MytreldpK3d1SVZxUkFzQnpaaXlpamxxQlhza0p2ZWVhdWtnTHlmQllIYVU2?=
 =?utf-8?B?U25KRzZLeGVuL3JvTmdhVXJPMmV0K2RXdFNzVllqMW9lVVI4bGg5VUkrb3I5?=
 =?utf-8?B?RHJwcmpvU0RiV2doaTk4dHlYcWtzUVc4cHBKQzRnVytNNWgrSE9MTnBmSUUw?=
 =?utf-8?B?ZXlGNHoxVldld0ZCSVd2TDFPUHROOU9EandtaWZsaWZVbkIzSHAxMk93emxO?=
 =?utf-8?B?aUs3QzlWR1VwWGZaV0c5WTlSN0Z0RCtodWlGTkIzcVZOWXFoN0FLRko3MFJj?=
 =?utf-8?B?RHNMRXo1RnNYTUZLWGJxZjdhRlROUFJJL0dBZUxqMmpWenR3TzhMdHFLMkhB?=
 =?utf-8?B?SW9FbURSYTBoMUVMSFREZ1BuVXF1QnFYeTkyTnRhYlZzeW4rWXNBaElBVExt?=
 =?utf-8?B?ZTBmWGY4SHh0RmlPZXJRVGcwMlhGblBRYnNucU8zbk9GL1g3TW16YWhoT1Zz?=
 =?utf-8?B?ZVQxeHd3Q2gyN3Q2TjNLUUpoVzE5Y0IrZndYQVFDZzQvbFQralp2ekVqQmJM?=
 =?utf-8?Q?iGwiPCiFEPPvxWGgSPaNpcTTYoMiur+V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YklvNnRrQXFFcWJWVFpnTDc3dE1CY1BwT081R01BamNrdnZjZ3o4bzhPUzBv?=
 =?utf-8?B?c29XOVVGWTB1LzVmV0pIcDNMOE02Y1VPNUxKTnJqbkYydUVoQ3pDbEJZMlN6?=
 =?utf-8?B?MXJaQU5CWlRTTUdsbGg5WS9DZmEwaGcrUG5XaGFqeVVsTXlMZjlvYmU3YTI3?=
 =?utf-8?B?NmRPYW0wT3Y4SmFvNUh1dDNpbTY3NC9GQUhndTB0MllWY2VGZzVIU3BjL1FX?=
 =?utf-8?B?eTAxOGtka3FtUjBidTNVYnQ0a0tZNEVhUjkvTTB2azY0T2JQSERPd0prbW56?=
 =?utf-8?B?WEhCdGJMNjQ0dm9VN2VTTURlMUx3RDN0M0ZyRXA2aUl4WG1pVDFmZGwrek9h?=
 =?utf-8?B?OFFXU3duclVTOWpyY0kwc0krM1pnMFdveXNMUytIVXNwaHdzaWZrS1NGZTlN?=
 =?utf-8?B?NEppSE4xdUVLRnZ5cjZ6U2FwN2RiWVRoWmQ4SmplVjg2Z0dhdzh1UjJZaUNM?=
 =?utf-8?B?cFBURGtVMUhONnZrRWlrL2thTGgvazZ5ZnVGYW9MUW8zRW5Hd0dOQk8rRjdk?=
 =?utf-8?B?YUZJMlhtemxIeWlWTlVGckl1bFhTaFFPeGp2QStLZVdtU1FoenZVejVrQ0lw?=
 =?utf-8?B?MTd5S3pkTFhQaU5GNGlkNVVENjFKSjZBTEVtb3VNUng5L1YvcW50VmtJUVZV?=
 =?utf-8?B?eld4VUFCenp4ODdTQU9tcEhkdXZ3YjhJN2NrQkpVQWhHeXAyVlBXc1R4MzdU?=
 =?utf-8?B?WUw1MEh1cFljbFBnWFhHMG1CSWE0YWVGZnYyckxlK2hLMzF4dS9EY3UzalRl?=
 =?utf-8?B?M05uS2hrNHp5VUR4dmV5aWJZR2dvbkJ3cnhldWFkSE5LRHcxaVRITThWUkhK?=
 =?utf-8?B?M3ZsWWY3VUQwWFZESkU5UnBGempSSlYwNExsWFBFT2wwSHZRbTRqcG9aSnJI?=
 =?utf-8?B?Q2FzRlJVRHRCUWhXRDUyd2RCejM2Qy9MVVp3aHZham5FN1RSUXY2V1BZcENh?=
 =?utf-8?B?eXYrT0FJb1VhZ1JBdGhYNTdRUldvR2VuWnpZRlJDMkVtVkpaRGFQMWxzMGpH?=
 =?utf-8?B?RW9lMGxZRG1mTlBiT25CREFteWJtVEhWbW04Q3M4d1hZSDlZS0RTK3R3VVBp?=
 =?utf-8?B?WndwU3RjUXhPTE0zcDltV0lDcWs2OWFveDRZcjNWYTNGSjYwMm41Zm50SlVu?=
 =?utf-8?B?a0FqYU9zcVRuNXlkV3owM3dzU3ZlRFJuL2s2VXRrOVkyWjlnUm9jelRzL3B4?=
 =?utf-8?B?dzZ6OG8rbWpVdVB3YnA0anRYUm9JT3lNUFFhaWp0NVdvdVRzTmhXODVUd3RH?=
 =?utf-8?B?bWx5Y25SRWZ1QW5TN0txSkVYYVJKd1pzZnJmSVA1ZnZEdFBHMDhTTlRiRkpL?=
 =?utf-8?B?T1hMOEU4YWVsMnk1d3NBYnhvOTE5bkZkaFd0aDFEQis1VzF4ZnhJYjNYU3BL?=
 =?utf-8?B?RHE0NVhVbm1uclNkbVZuaEE4QlJaWDZYUUpCNE5FVkRPZHMzN3V6Sld2NTRD?=
 =?utf-8?B?cTlibnRsTGhqK1A5aE9Zb1plRHlwcnk4TjF2bHpnUkFYRjhMQ21kWXpYUERp?=
 =?utf-8?B?M1gyckNzVDBEV2VBMCsvWjNXaGJlUDA4VzNIRlpLa0VhTG0zeUdNVG55UWxT?=
 =?utf-8?B?ZVRJdEJKWEhaUTVsbFBZN2E1dUROUVlTd1FNcFlPemVOdWJMaC81ZlRTeDRG?=
 =?utf-8?B?WDJwR0xkNWNCMXlJbkQ2MmNDYTQ0MmNHdG91VVZPZkx0M2tSeUJJUkY1TnhG?=
 =?utf-8?B?TGZLRTVHWDAyd3lQZmZqOU1TRzdoMXFGbFA2QjA3UktFWGN6d2xscmtaTUE2?=
 =?utf-8?B?SEp2MURZbEUvcjJxN2lQakcrcmlXNkxJb3FvZW1XNHZLTGUrcGExMEllQUdq?=
 =?utf-8?B?aEVEbWdwMFdONWJnSHJ0OHQwVGlWd0Y2V01nTTdUclp5dXFwMncrYlZOSFI2?=
 =?utf-8?B?REl4bDMyak42UlZaZ0lTOU5ZY3lURVdIYmU2a3NaV2g1bTZRZHEyYm5mU2Nn?=
 =?utf-8?B?QUlEd01rYkhyeVFPVkMyM3NkcDdBNzJIa0dxd1BCM2ZILyswUEJzUFJoUE80?=
 =?utf-8?B?ajF0eENvQVU3SlNuVzJxSThrQ3NsdndiR2JXMG5JN2E2MnhjRXRJTDNHSEVu?=
 =?utf-8?B?OG1ZZkw2REVac214VlM5dEI1bnhCZ0lOWHExeHVVQWFCSHYzckFGdWM4TlZV?=
 =?utf-8?Q?107mVrWHt/gHuMBVpONvRwhgW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cefceb7-ffe3-4a9a-e204-08de1300763b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:23:04.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjhLL0oVo9iaJeXIt7ihkzFbafPaTeLE0o9i1yY2+rnNj61y9vwLNX0Rp70hXYDOUte2LdZPEtBcpmNKShGwew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771


On 22/10/25 16:28, Ionela Voinescu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wednesday 01 Oct 2025 at 20:31:00 (+0530), Sumit Gupta wrote:
>> CPPC allows platforms to specify minimum and maximum performance
>> limits that constrain the operating range for CPU performance scaling
>> when Autonomous Selection is enabled. These limits can be dynamically
>> adjusted to implement power management policies or workload-specific
>> optimizations.
>>
>> Add cppc_get_min_perf() and cppc_set_min_perf() functions to read and
>> write the MIN_PERF register, allowing dynamic adjustment of the minimum
>> performance floor.
>>
>> Add cppc_get_max_perf() and cppc_set_max_perf() functions to read and
>> write the MAX_PERF register, enabling dynamic ceiling control for
>> maximum performance.
>>
>> Expose these capabilities through cpufreq sysfs attributes:
>> - /sys/.../cpufreq/policy*/min_perf: Read/write min performance limit
>> - /sys/.../cpufreq/policy*/max_perf: Read/write max performance limit
>>
>> Also update EPP constants for better clarity:
>> - Rename CPPC_ENERGY_PERF_MAX to CPPC_EPP_ENERGY_EFFICIENCY_PREF
>> - Add CPPC_EPP_PERFORMANCE_PREF for the performance-oriented setting
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       |  55 +++++++++++++++-
>>   drivers/cpufreq/cppc_cpufreq.c | 115 +++++++++++++++++++++++++++++++++
>>   include/acpi/cppc_acpi.h       |  23 ++++++-
>>   3 files changed, 191 insertions(+), 2 deletions(-)
>>
> [..]
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 732f35096991..864978674efc 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -23,6 +23,7 @@
>>   #include <uapi/linux/sched/types.h>
>>
>>   #include <linux/unaligned.h>
>> +#include <linux/cleanup.h>
>>
>>   #include <acpi/cppc_acpi.h>
>>
>> @@ -38,6 +39,8 @@ static enum {
>>   module_param(fie_disabled, int, 0444);
>>   MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
>>
>> +static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
> Should this be under CONFIG_ACPI_CPPC_CPUFREQ_FIE? 

Thank you for catching. Will move it outside in v4.


>> +
>>   /* Frequency invariance support */
>>   struct cppc_freq_invariance {
>>        int cpu;
>> @@ -572,6 +575,70 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
>>        policy->driver_data = NULL;
>>   }
>>
>> +/**
>> + * cppc_cpufreq_set_mperf_limit - Generic function to set min/max performance limit
>> + * @policy: cpufreq policy
>> + * @val: performance value to set
>> + * @update_reg: whether to update hardware register
>> + * @update_policy: whether to update policy constraints
>> + * @is_min: true for min_perf, false for max_perf
>> + */
>> +static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>> +                                     bool update_reg, bool update_policy, bool is_min)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     unsigned int cpu = policy->cpu;
>> +     struct freq_qos_request *req;
>> +     unsigned int freq;
>> +     u32 perf;
>> +     int ret;
>> +
>> +     perf = clamp(val, caps->lowest_perf, caps->highest_perf);
>> +     freq = cppc_perf_to_khz(caps, perf);
>> +
>> +     pr_debug("cpu%d, %s_perf:%llu, update_reg:%d, update_policy:%d\n", cpu,
>> +              is_min ? "min" : "max", (u64)perf, update_reg, update_policy);
>> +
>> +     guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
>> +
>> +     if (update_reg) {
>> +             ret = is_min ? cppc_set_min_perf(cpu, perf) : cppc_set_max_perf(cpu, perf);
>> +             if (ret == -EOPNOTSUPP)
>> +                     return 0;
> Should we return success here? The user will have no feedback that
> setting min/max performance limits is not supported. 

Will do change in v4 to also return EOPNOTSUPP error code to the caller.


>> +             if (ret) {
>> +                     pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
>> +                             is_min ? "min" : "max", (u64)perf, cpu, ret);
>> +                     return ret;
>> +             }
>> +
>> +             /* Update cached value only on success */
>> +             if (is_min)
>> +                     cpu_data->perf_ctrls.min_perf = perf;
>> +             else
>> +                     cpu_data->perf_ctrls.max_perf = perf;
>> +     }
>> +
>> +     if (update_policy) {
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
>> +     return 0;
>> +}
>> +
>> +#define cppc_cpufreq_set_min_perf(policy, val, update_reg, update_policy) \
>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy, true)
>> +
>> +#define cppc_cpufreq_set_max_perf(policy, val, update_reg, update_policy) \
>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy, false)
>> +
>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   {
>>        unsigned int cpu = policy->cpu;
>> @@ -873,16 +940,64 @@ static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *po
>>        return cppc_cpufreq_sysfs_store_u64(buf, count, cppc_set_epp, policy->cpu);
>>   }
>>
>> +static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
>> +{
>> +     return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_min_perf, buf);
>> +}
>> +
>> +static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     u64 val;
>> +     int ret;
>> +
>> +     ret = kstrtou64(buf, 0, &val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = cppc_cpufreq_set_min_perf(policy, val, true, cpu_data->perf_caps.auto_sel);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +
>> +static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
>> +{
>> +     return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_max_perf, buf);
>> +}
>> +
>> +static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     u64 val;
>> +     int ret;
>> +
>> +     ret = kstrtou64(buf, 0, &val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = cppc_cpufreq_set_max_perf(policy, val, true, cpu_data->perf_caps.auto_sel);
> These "work" on the performance scale, so the values read are
> performance values and the values that should be provided should be
> performance values as well. How is the user supposed to know what that
> scale is and what is the range of values it can provide? All of the
> other sysfs interfaces work on the "frequency" scale and the lowest and
> highest performance values are never exposed to the user.
>
> Thanks,
> Ionela.

Can do the change in v4 for these nodes to get min/max freq value from 
user, convert
that to perf with cppc_khz_to_perf() before write to min/max_perf 
registers and vice-versa.
That will keep the scale same as other cpufreq sysfs interfaces.


>> +     if (ret)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +
>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>   cpufreq_freq_attr_rw(auto_select);
>>   cpufreq_freq_attr_rw(auto_act_window);
>>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>> +cpufreq_freq_attr_rw(min_perf);
>> +cpufreq_freq_attr_rw(max_perf);
>>
>>   static struct freq_attr *cppc_cpufreq_attr[] = {
>>        &freqdomain_cpus,
>>        &auto_select,
>>        &auto_act_window,
>>        &energy_performance_preference_val,
>> +     &min_perf,
>> +     &max_perf,
>>        NULL,
>>   };
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 3babc6d6e70a..fc7614eb9dcb 100644
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
>> @@ -172,6 +173,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>>   extern int cppc_get_auto_sel(int cpu, bool *enable);
>>   extern int cppc_set_auto_sel(int cpu, bool enable);
>> +extern int cppc_get_min_perf(int cpu, u64 *min_perf);
>> +extern int cppc_set_min_perf(int cpu, u64 min_perf);
>> +extern int cppc_get_max_perf(int cpu, u64 *max_perf);
>> +extern int cppc_set_max_perf(int cpu, u64 max_perf);
>>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>>   extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>>   extern int amd_detect_prefcore(bool *detected);
>> @@ -264,6 +269,22 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
>>   {
>>        return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_set_min_perf(int cpu, u64 min_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_set_max_perf(int cpu, u64 max_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>>   static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>>   {
>>        return -ENODEV;
>> --
>> 2.34.1
>>
>>

