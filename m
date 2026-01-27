Return-Path: <linux-acpi+bounces-20654-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLgPCCOgeGn4rQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20654-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:23:15 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9D0938C9
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23C7F302334B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C13346E44;
	Tue, 27 Jan 2026 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nRmnVSq1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5033C19E;
	Tue, 27 Jan 2026 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512964; cv=fail; b=ZPPbksv7HQF5hwB57MBpncQTwIUMiFm2pXskA9BcFD9AiKhQwrZZ/oB9eeG0OfRjieezJEmDZ081MtbzL5vDmSKl0LD6SLUcOZR+Hp/QlLfuVGX68039nBOe4h9QM9NcUdysWBq0PfycdrjHofCBLUNYV5as1t+XuWjSZzwvy9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512964; c=relaxed/simple;
	bh=56obCBiEghcvXPsFp1mce5dvqec7utsZGjjE347jTcs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bjB8QMrO75di8cguoCZPfGaLWOaVCEg5Mdu0UX21VIvhYtj/nUOqj9d0OQ8m0i4Te986/l/s0JLtgoaIiHlDbX2+ugNL8ZCniZCpchHgyMcStdyawooQOx37Ky+YcM1eAUhbIiTgvz/0dJ496gQmhpkFrtmr/SVRSowg5qog2+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nRmnVSq1; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHXUi54J6b5+3/YIiuvuusIHS0Ea8bYJ0YgQdfWZ12VBnoprSvJJW2Z/c4RKpefKkdpBFgDe8qKAdQV3VNds4+eOZiX2LiBS1I39ZOMTlt41JFoe4m9yGtAr50vfGPJCIUHDGLIeKKELqaTyW30H8VmW66mhS9xjQ54rxaS6PX00pZcllBbbK3iw7PO/utVzVabx+19Y23VDqwg7LQ7KlvAVTT3n7wicKqne0QtuoNI7VRY4GFL/ySvg5uv6cS7uKWzGyQ5ZUM0jwX9Apx59YkWqmvkIx+f3nKKr9kdvPtj1vHfWs87rDvk/ctpBe2zKdGuzaZ50WKrKC6FWDPjnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K/LQgPjEeyGHGxPgZiwyMgd6hWCMhG90mm18lN8tGY=;
 b=jksTNDnGvfEMSsAlTphoOvABtg0jdBei3ImaJBuLLJ3fdUhypxLkx8AIlD1sX1VkJC7dwRMCDHu8wCV75mQTBmB1RWVk7M1dfQ7iiaFnkVk0jBVZzn6gHE1UFN+glozr0HmIITzD1DdQKsBaRMXq0udYEvCEBB4+DIolMLr7tL39+fpnMayfpwhLdUq9IYtaPx6TwEZ7iMatmdf71iUNkoj8lZpS/NjM6LEfwg2KGcoghOv+Igizl9FICRBCDMxQTZ0UQPo0hrRcpC86IRYX7EozVYqX2ocOVmSF2sx4mntpsbZozzXjD1W6qaDf40ydwZz5jMKlUx/K5VvymAvTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K/LQgPjEeyGHGxPgZiwyMgd6hWCMhG90mm18lN8tGY=;
 b=nRmnVSq1HjjhMJaec41VGF+l+MVa+NAX1hMQlqpWJohll4Ev1YxZ9AeGUW9WSQ7Ye8yvLuu56NLP9UrGpq4qY5x0VBB2VwO2MzV6AaJCrg6vW2DuqN/biFbKCl8WoabsXt+HEtILTrJIKvwe9N0pzdOPtF+sFRUJrQtXGjQ62mJOBfjuaykhVABgDDWOv8af/L1ALegKe9cOArXSnVsZfv5lHqN0JYFeDoFHiiEO1Kw9eWaGBsUQgbttNN3aoXHBSTMUXznRAsf5D01LeCzj1twQne8gW8bOTCH1+G2yp4WS+3xLUHFQLKoAjjpcT2oo/rezQwVYoE3S8v+uwf6Asw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 11:22:38 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 11:22:38 +0000
Message-ID: <83ed733b-f7d2-42c3-ab0a-9b9fc76ecb4a@nvidia.com>
Date: Tue, 27 Jan 2026 16:52:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhenglifeng1@huawei.com, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-7-sumitg@nvidia.com>
 <b68a4273-ad39-4d3e-a556-1b409b50944d@arm.com>
 <2ce31807-bf89-4c79-82d0-31a5cda2a6a5@nvidia.com>
 <1d75dd4f-0eaa-447f-99b1-4c6c9d39a87d@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <1d75dd4f-0eaa-447f-99b1-4c6c9d39a87d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::14) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 82bcb081-6155-4462-a960-08de5d9660a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVFvYmRuMzFWc2lNOXl1VGdVY0dqcmtYa01XQURLUm15SWI2VEFYdEM0VSs0?=
 =?utf-8?B?UW9QUm9obm9xRVV3UUN6VUhsZ2RJZnVOZEc0dFlaR2h0V09sN0VndmNwR3lz?=
 =?utf-8?B?N1VSd3hFYnZBdU5nLzlkK0VTUkU5eVVJdGdZMCtrQURjZ3hDSTVrNkJSd2Zu?=
 =?utf-8?B?L2l5Z1Z6UmZIYldVZ2NiVkhCRXZId3F6Y1laTWUxUTFTK0Z6Wkoxa1A3a2x1?=
 =?utf-8?B?cDhUeXhzVjErNFRlZEh2TkZTYlZSbThkTDh5eGRqT2EyRGh2aFRNc0l4RHZu?=
 =?utf-8?B?QS9IWkNxWkVLTW5SazE4VGJ5QmxxT3JmUmlsd0VjWWRxcXc2RWNPb3dpeFN0?=
 =?utf-8?B?TDJRRldVRDB1RDN2SEtid2llV3loNTlWK3dRL0o4djRoOGdDMHNDcG11YWZ5?=
 =?utf-8?B?R3BhRzYzbGQ2dllmSWhpZW5JU1owOXROY2xTK0FJU3hxc2M4YlBSem5VZ2RH?=
 =?utf-8?B?enlNdm9MTzR1U1hPVEovcWFtMXgvY0RIUVpjOXVKKy9YTGwxUkU1UW0rbjFI?=
 =?utf-8?B?cVYvNXFBRDNkL3VKdkFYR3VUSmFxeGlIR1dHUy9HMWNhVGNYWk1ZZU5hQWxt?=
 =?utf-8?B?NkJMUVRjOWhVQXYxbU42bjVqaG03TjR1YWpMVDJIQ3dSWTYwdEZOaTlRWVR3?=
 =?utf-8?B?UXRwK3g4TmdkNWIyb3JuSmU0bG9WL0NDQUJVaE9NaUtXQU5nRVBvVXZ4NjRO?=
 =?utf-8?B?bFZ2WnRjdW1pZWFlRWEzZVNHZHdhZmpRVndmKzhuYytVSnlFVW5MWStUb0Ux?=
 =?utf-8?B?c2xHcHVFNmlQWmFsT09Fc0RXREt1ekQ4cEZUMWpEcXBhYm5MZlFTK3dkblhI?=
 =?utf-8?B?RldpYkVoaWRPNXZhRDF4d3JVNVhzeVVFUU50YWxEWGlndHg4N1IyOXp4SDh1?=
 =?utf-8?B?akhEcmFnUndzbWlZZFNxNks1eW1GY0NXZHNyWEc1UDFpOXpOcjJOWEdHTGRk?=
 =?utf-8?B?c0JYNCtpUThvRno2WGdsK1hvMS9IWGdPNjVlbmlVYW03RkNaS0VUeW1Icldi?=
 =?utf-8?B?YXRwRE00UU41YWZDck1xRjZweEo1STFsTGhza0ppVlNPZWxQZ0NIRXJmdk9E?=
 =?utf-8?B?RjJzQ1NkWEcxZ3ZjdCtOcHF3Sjg2UDYvRVQ5Y0JWdlpBcEJhd05jOU5UNnZZ?=
 =?utf-8?B?N1hwMktGc3JrNnd3Y3NTaThIUTB1Tlk5bURoaWpOQUFMUk96UXlXNWlDZ1F1?=
 =?utf-8?B?ZkN0UmhVaG0rVlZrY1l5YWg5YlM0Yy9zeFB3TTNqT1doc1RhLzRUdG9UdlZE?=
 =?utf-8?B?SjM4VWFiMjFRZDBDL0s3S0pONW44T1k2V01SL2w1MnVpQXdiTXIrNEljN21p?=
 =?utf-8?B?amd3aElNQndZSlJxb2tOODluM1Z4TmdKMTQ4TUZqS2JrNEYyY0lKOHIvOTFU?=
 =?utf-8?B?aXJweU93ckNtRFZPMkk5Z3AvUVh5UFB6d0xlMnZNQWhKaWRhMVJ2d0hYQnYx?=
 =?utf-8?B?VGsxUkx0eUplWXgzWkdkdmxJVW1Qd2xCYlpyY3pjejdaSVBhTWtYRko0ZWs3?=
 =?utf-8?B?bDBoelg1cjl5UGVmZklnMVJpMGtaTzBFMGM0VU5VRjlLbXdGcHp1dmo3Y29B?=
 =?utf-8?B?MXpzbW5nWC9uUW5Ldm9hbGRXNG56cUh0UTl5SmJJVjFqRDAzZUgxcE5QaFYz?=
 =?utf-8?B?N0g0R3RKR2tsSEtocEZKa2VIbVlBYlRFdk02UW5SUGVZNXBWRU9uNld2Z3cv?=
 =?utf-8?B?SGEzMlhLZW1NdXB1UUpERnZsMkRFTDMrRHFPeTZ4Tk9qNmlqeldBbnpqY2Jz?=
 =?utf-8?B?cFNPNng1NWFnZDFXaCtETUNVeXFiMG1Gb2dpQ2xHWURLYk5NMFpEamNyZzJa?=
 =?utf-8?B?UVZ1dXhhbWd5bUkxR1JnT3FwQk5qQ1E0MVBFbjc0b0Iwb3NDWEhKZlk4d0c0?=
 =?utf-8?B?dkZyM2t1WmZJYU1wTTNINlB0M1pyRHFocXl4RmgwVUNWYWFPdE56Z1NHcmtO?=
 =?utf-8?B?bnBtbFJOb3hwdkFNMDQyUHZmODFpY2tJM05WcW16Zi9Iamh3YjFIbklSUjBD?=
 =?utf-8?B?cDVUbUhBc2JwN2RCWm0raGlHSHZ0VG9sUXdTd3RFS3ovbnMzNUtBd0ZoeW9Q?=
 =?utf-8?B?QXdYQm9nSVVveXRITjBDRVp2alFjTWVadnAwMVRQOVdGWHlyMVNCeGZUeUNN?=
 =?utf-8?B?elczbjdsUkN4aDJIM0lXbEh5dlV3ektIZnpURzVHenp1T1dsSHFwNlZUSFJB?=
 =?utf-8?B?UWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1JWYm43Vzl2dFNsSHdXQXlxZmZzWW1jdGNGZ054UWI5MkV5WEgxRmlWMFI0?=
 =?utf-8?B?Qy9hSU5rMGRPMG5GRWZjRGFETERCTkpyNHRlTFNKN09ZVVF2cTZIeWRlM3g1?=
 =?utf-8?B?ZmFBcFQvL0tCM1RhMHpaUm1kWDQ3OXpTNG5XSzlGV0JidFB2d1IrZTRtR1Vv?=
 =?utf-8?B?MU92UzdNbWo5L2JDdUV2VlpsMDhlQWsvdG91NUtLNGw2cCtuSEdJcGE2dFJP?=
 =?utf-8?B?Q2ErZzhaQXc3aG90S2RIN2JGZlNOVWJKc0w0c1VrWDJzcFZpVXV3T2trdmNL?=
 =?utf-8?B?bmJLbFBPMytFQzFsSDF4bERzMzRNbm9zVmgwMFNucFBjWURkL1orOUJwaWJo?=
 =?utf-8?B?KzkzQk8wb0hINU1NM2RWMCsyRkRIY3JVYTMvZlo4K1JrMU9pZEhCenpQbk5i?=
 =?utf-8?B?SVNpaERaWW54VDVVL3Q5bHdoVStLT0FHVldsU0lJRDc2SzA3b0Z0emwwNnA5?=
 =?utf-8?B?elF0Ry9Kc0FCYWtQVVBxTjBkMUlSZHAxdXFpS2JLemJMdWtvbGNVbzVsTEYx?=
 =?utf-8?B?cEtOcUdPYUJrMFQ2a2pldU9hMm8vdkFxdCttRTUwNnBXYytlY3lLemVTUzlo?=
 =?utf-8?B?N1N5dGtBRk5KNHd0MFl6OGpmZTNBbmtHWlZjU3BlWmwrbER4OFJnZEJKOTlp?=
 =?utf-8?B?ZG9vKzYrUlhlL1BKRmxsRkV5MnAvbkVLUjZOY2NsNjg2MUtFdVZiRDN6NnBK?=
 =?utf-8?B?WmJSL3Z4RElsNTgrVGFsVmwxak4wVUNYNjJKQTZmNkFzazdtWE5xSm1NNURI?=
 =?utf-8?B?aWljYlh4ekhlaWN0L01SOTAydGNzNTg0V1pBYXFHYS9xSW1ieE9EZ1ZyRE5Y?=
 =?utf-8?B?dm9DblU0Q3FNWTlBWmZTWElrNTI5dStQcUxITnlTdXJFN01pa2lEOTAzengy?=
 =?utf-8?B?Nm10c2JiUENGZytuOS9BTG0rd2lnNEgxc3BkTlZhUjVnR3JjTzFMSm9aV0NT?=
 =?utf-8?B?QVVadUZCMzhYdTBoOTMvdHgybFdGOVJEU0picUxqSjMvWjZyb2NadXJmYWVm?=
 =?utf-8?B?Z0ZIS0tKL2FYcVpuejNOenh1ZE4vbEhHNDFHRXNwbEEwVFZXVWhCcWxFV2li?=
 =?utf-8?B?em9BS2Frb3oyaDMrS0pxVG5yejNwU3JvTkFlazN5ZXMxMU5pS21SdEhyYkM2?=
 =?utf-8?B?cVg0TStEQlpwcmlxZThvcEF1U3dqSjZJK1hsdkZVVnBIakdZR3lIb3R0WUhs?=
 =?utf-8?B?YWtFNjRnRExzUG5EUXVhZ2h5NVl4cFd1T2JJNEtkczZkYUlJdkE5MnVJMkhr?=
 =?utf-8?B?VTlWcGtLUS90WkRTdlJGZHA5TlFNUm5YcHp2R0xpY1NzTkVxdlZEakdJdkw4?=
 =?utf-8?B?NktYRzdBVitFSnBMWFAzdlU2V3YwSGNpeE16dlVBUGFWVFBOU2s5NXN0LzVu?=
 =?utf-8?B?WXBKb204emoySllSZ0pmOXlmaktzbDA5eW9KWU9DY1FwT3FZVUVNSmpHcmMr?=
 =?utf-8?B?VFlsVEd1WDA5Z0orZ28rUVo3dlVFc1FlYmorSithWEZ3cGREN3JqMTRDUTAv?=
 =?utf-8?B?YjZJaUNHRHVpT01FbUxyWnpydHVnWE10NW93VXVhT1dKWXN0MEFlZk93Tkc4?=
 =?utf-8?B?bzZ3QkNJY2hYeFFIckFXZFNVVEJRaFhLMy95VHc1ZkpOcmM2V2tFZjNyb21U?=
 =?utf-8?B?NmlVczl5ZDFPbHBUSlczRDVjazRiOHRLQytybXcrbnZPM3RhWVg2QVBFTnpn?=
 =?utf-8?B?cWVDTzk3MDBDSE1OL2xKRkFiWFVTcmV3QXZkU0w0KytvM3FTMGtXMXhjZFdz?=
 =?utf-8?B?R0I2Tk5rT2NRSnFmMC9tWEdpWEpsR2llZG02QWF3Nm9vTmg5aUZqa3pPWWty?=
 =?utf-8?B?bTRHWnh4Q1JPNWhucnIrYWJybXZZSEUyZHZneVdNbmZrc3N4VndkTWJXRDNO?=
 =?utf-8?B?QnhHelpSanM1NHVSKzZ6dXlSOEdnWFdZZkc3a2V6OUFUV1h0V3Z3MXU1bS9Z?=
 =?utf-8?B?R1RoRnZEZkErSTI3Qnk3NHl6L1ptQjVWajFIa1QvWm9HVFRzWllWYnZRQW5N?=
 =?utf-8?B?Vm9ZemxhVEEzRGxoM05WWEordGpJQ0l5aHlUU2dHUjEwZVU3aE1hejc5NEtx?=
 =?utf-8?B?aGRuUG5VRlNtVkc0b2VwYWhYbThObkVlK1FYZ1drSjB3dWRhMXpqTlU2UWRt?=
 =?utf-8?B?UUxmd2RlOVg4aU1STndBYXI1aHRwVHloY0dkcW5qSWhzUmk3SG0zWEhnY0lI?=
 =?utf-8?B?WnlGb3ZxNEhWSUZ5emJacENvYldRL1Y2ZXZieW5iUDFnUkNiTFN1ZHZuVTVF?=
 =?utf-8?B?TVBwSGNWajVsQloybXNmQk82TkpWK21pT1pTaUx1MzF3Sjk4ZHFBb3cvdndk?=
 =?utf-8?B?TStLQVVwVjN0NGY2NGVYTHRPNEdLOUxJaXA1a0ZYSzRGUkdFRzQ0QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bcb081-6155-4462-a960-08de5d9660a0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 11:22:38.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0RnFd+sBv9p2HtyvsmShj6RR/OTU1ub55On0LEJQvteH2Mnd6keFF5LLFpxz3ulhWcs9LmJZ84dNlqVUXBqTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20654-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE9D0938C9
X-Rspamd-Action: no action


>>> On 1/20/26 15:56, Sumit Gupta wrote:
>>>> Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read
>>>> and
>>>> write the MIN_PERF and MAX_PERF registers.
>>>>
>>>> Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
>>>> to expose these controls to userspace. The sysfs values are in
>>>> frequency
>>>> (kHz) for consistency with other cpufreq sysfs files.
>>>>
>>>> A mutex is used to serialize sysfs store operations to ensure hardware
>>>> register writes and perf_ctrls updates are atomic.
>>>>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>   drivers/acpi/cppc_acpi.c       |  44 +++++++++
>>>>   drivers/cpufreq/cppc_cpufreq.c | 157
>>>> +++++++++++++++++++++++++++++++++
>>>>   include/acpi/cppc_acpi.h       |  20 +++++
>>>>   3 files changed, 221 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>> index 45c6bd6ec24b..46bf45f8b0f3 100644
>>>> --- a/drivers/acpi/cppc_acpi.c
>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>> @@ -1743,6 +1743,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>>>>
>>>> +/**
>>>> + * cppc_get_min_perf - Read minimum performance register.
>>>> + * @cpu: CPU from which to read register.
>>>> + * @min_perf: Return address.
>>>> + */
>>>> +int cppc_get_min_perf(int cpu, u64 *min_perf)
>>>> +{
>>>> +     return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cppc_get_min_perf);
>>>> +
>>>> +/**
>>>> + * cppc_set_min_perf - Write minimum performance register.
>>>> + * @cpu: CPU to which to write register.
>>>> + * @min_perf: the desired minimum performance value to be updated.
>>>> + */
>>>> +int cppc_set_min_perf(int cpu, u32 min_perf)
>>>> +{
>>>> +     return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cppc_set_min_perf);
>>>> +
>>>> +/**
>>>> + * cppc_get_max_perf - Read maximum performance register.
>>>> + * @cpu: CPU from which to read register.
>>>> + * @max_perf: Return address.
>>>> + */
>>>> +int cppc_get_max_perf(int cpu, u64 *max_perf)
>>>> +{
>>>> +     return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cppc_get_max_perf);
>>>> +
>>>> +/**
>>>> + * cppc_set_max_perf - Write maximum performance register.
>>>> + * @cpu: CPU to which to write register.
>>>> + * @max_perf: the desired maximum performance value to be updated.
>>>> + */
>>>> +int cppc_set_max_perf(int cpu, u32 max_perf)
>>>> +{
>>>> +     return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>>>> +
>>>>   /**
>>>>    * cppc_set_enable - Set to enable CPPC on the processor by
>>>> writing the
>>>>    * Continuous Performance Control package EnableRegister field.
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 229880c4eedb..66e183b45fb0 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -28,6 +28,8 @@
>>>>
>>>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>>>
>>>> +static DEFINE_MUTEX(cppc_cpufreq_autonomous_lock);
>>>> +
>>>
>>> Shouldn't concurrent access be handled by the policy->rwsem ?
>>>
>>> I think this can be checked using either:
>>> - lockdep_assert_held_write(&policy->rwsem)
>>> - lockdep_assert_held_read(&policy->rwsem)
>>>
>>> in store/show_max_perf() for instance.
>>>
>>
>> You're right. The cpufreq sysfs already holds policy->rwsem for
>> show/store callbacks. I'll remove the mutex and add lockdep
>> assertions for the expected locking.
>
> I think it's ok not to have lockde assertions.
>
> It seems that it is a common assumption sysfs files cannot be modified
>
> concurrently. None of the cpufreq driver seems to use lockdep assertion.
>

Sure. I will just remove the mutex, keeping it consistent with other 
cpufreq drivers.

Thank you,
Sumit Gupta


>
>> --------
>> File: drivers/cpufreq/cpufreq.c
>>   static ssize_t store(struct kobject *kobj, struct attribute *attr,
>>                      const char *buf, size_t count)
>>   {
>>       struct cpufreq_policy *policy = to_policy(kobj);
>>       ....
>>       guard(cpufreq_policy_write)(policy);
>> --------
>>
>> Thank you,
>> Sumit Gupta
>>

