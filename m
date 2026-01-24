Return-Path: <linux-acpi+bounces-20601-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pXKCOSQmdWlLBQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20601-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 21:05:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 340B77ECD4
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 21:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8744300B9DF
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 20:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2C4272E6D;
	Sat, 24 Jan 2026 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NYpw4F1d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36523BD17;
	Sat, 24 Jan 2026 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769285153; cv=fail; b=YQDSgOQXYKyCNfixQL6hmx5oVHPoy0mS7H1LsM7UF3VkRjaOzKe91IHgw7fTvBDAP1wsl8mAhAfLs9WjCK7uTKJEG6jbbihJ/qEFcWrB7hLD+k8NSaKOcBwLUo0HYIihEAaDB2NU4CpbOkhSSMtjYd9dnTFHjQe+nA3FkziA87M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769285153; c=relaxed/simple;
	bh=n7cIpuurMmVyPb6isIPwI62LT90KoPYB3qlaBjN6Tt4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AyJkmOXaYadSBumrHNY0V9MeFUwO79Kuz/bWE3Of8Gvzo4Zx24ae/FhJ5aoG8pCh3v4kKaWguJZh7Vy6Qqq2CJWxb10Gr5einQN2tW7b5VNKSD9BNtzDy7Y1c7q75N+E6W27olKp3JKOVZUklwOgCzX/AtW12UwGS2qWOB6K3oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NYpw4F1d; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+UWyAvga2AtfVBmhWnTYVBCSy7sMKM2iFmypfizIAtyQDnsq9WbgX3fktaeaQHvxKb28SSptoJB1Xd3ZLQo1KlGupTM8y71vxQtOaBo3sRvUP8juLBgLcCrcselYLTSf9biFrvC7uMKsNU60sDiZaOsbueLOLx1D31SkXUrwMy1DB6vN63vRTC3qrzQ6ry0II5QMjOulJGK1pY+EQAm3OHJoR4RpTlhRJK/HDOT9UI78xlJ28kTbwdzB8CkylQaVZRpEk45PKSqQYyrNOfcr5xzTybyZs2ncrgntsLuUVv3KSgbym4IeKtek8C2SdXZlTvBEOYKD73ZBCGIgXxD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fpaN5BLZ9t9Rl0G1SaDMzeBhmpGH/gu0wlR5LsgM5k=;
 b=u5ZN3KF6OrMnoFRz0Qx5t36TJAsGU5giZwZsSQM/LhiA8hlIQXVbbyabtlfUDlNaGHmS0AgR7TEcswrDNf+PjbKTB55zGIO1LWjef4Wrm0mWQwmUx0Jo3PEZhIp/va2aI1eJez5cmr/VCUYxuiAuLOAaKJAdFjol07vy4SbHHtyPM+K8F5aMJT1FqMYEvdF4+nq5BjxBsfznwH+spOyBS//KPcnwu8O0qXseQxFHUvDFoX35UPfrnfen5U89HLcFnGWKkPVlUPQ9dTvB5LH9i0uobEUVVcwd8jajfND9lkxSQ5OA9N2vrdzlgVlAmrGHpjjA5hHTPnkP9q6X6H477Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fpaN5BLZ9t9Rl0G1SaDMzeBhmpGH/gu0wlR5LsgM5k=;
 b=NYpw4F1dRtb5nsUyG3w3GzLAc4E3ww/jI+jRGDiSEygaomnb9sMqDpk0tBT6a+2t0MmKeNolzJ9npB7/LwTyqrnjhutCYqiGSy0/8O8GVDOeYabtL9n40K1/0tz4OXdism2QPnrIoWDQpqOyXxIrAkH6WE/GapI93gdAs+rVoLte8RQ0xEBpKiWAe/n6zGzzGaPpLHkilIm3mNHo8omUNM0EpRsxo5PBfh5US3NCvKuArHYIL3Sv4O4iA7vftx9BNsy/P1OCrhLpy1Bx2aA4MFcq4Vd2ZGdw61iY921hUoYe2vcxUcHCHujHr4E3nIm9KVIOeHpNSepeU5V37Ws+7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sat, 24 Jan
 2026 20:05:46 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 20:05:45 +0000
Message-ID: <fb4b68f7-ec64-4660-99a3-d288bc20ffac@nvidia.com>
Date: Sun, 25 Jan 2026 01:35:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com,
 ionela.voinescu@arm.com, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-5-sumitg@nvidia.com>
 <7f0b280d-9c22-46dc-a924-a85591e1034d@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <7f0b280d-9c22-46dc-a924-a85591e1034d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::19) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: b27b47e2-a338-4b37-8656-08de5b83f58e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmJ3bjNHaHFIZWt1VEdJanVmKzdoMFhaR1NWd3p6M0ZGaVVOVkg3eDh0OGhy?=
 =?utf-8?B?SmVYUUt2elJqdHlFOVhoNy84cUVaZVA5MkNaKzl5amtheElWVVh6WFU3a0VN?=
 =?utf-8?B?cDlCZzZQNC9WOEVxMFBEMTBUWkpIcjRhQ3o1M3YveW54NzB1OFE1T2NYTnJC?=
 =?utf-8?B?M1dGQWtGa3lLd0w5ZGhTakVNaC9sYTFlVnFuZkZwTlg1d0wxMkY2T2FaV1k1?=
 =?utf-8?B?M0pueGRCY0o1TWcraG00WjlGYkZmZ24wenlsTk9UTUl0RFgyZGs2WHd4bXla?=
 =?utf-8?B?TFBGaEdNSlg2YjV2OHVRVjh0NzVoUDBqenJIemhsSGlPeFVZUE95V3BScHJZ?=
 =?utf-8?B?NkR6cVZ6WlR3M1NSaTl3UmNTZVhoc3o5RSszMmt3V2pZbWRqSFVJbXo0WVg4?=
 =?utf-8?B?YjY4OHRXM2FXRG5qS1NFRTJaNHZWYXlVa0JOS2tCMHZQcjdzMWI1ZEFjQkxs?=
 =?utf-8?B?QnBYTDNHWGtxYjJtNWF2QTlBcGdZM2dURks1MllUZWpUUjRVb0hiU041VTRo?=
 =?utf-8?B?Z0FnWTZ5dUlGTm5CbXBYNFl6QVd2c0RRL1MyTlhBdXZFVEhZQTRKNVJNQUl5?=
 =?utf-8?B?dWdMQy8yRWJpMTlaRDNXaWhuQ3lHaWpDcjFUSURKY3Y0ejRkN1YzdE8rU3Uw?=
 =?utf-8?B?d3M0RC93Rno3dlJNdEpYWWJqWkJBNG05L2Z5NDBmVlZxYzVIeG5iaEovZnEy?=
 =?utf-8?B?UGp5OXMwOWFTRkREZ1MrQWQvb09RUGc4d2RIdVFpT1c3cFF2WXBZUHpPZ01U?=
 =?utf-8?B?emtPbDRXUlluWklSUUVTc0lnbnRWdWhiZ3RlY1ViYVJOUk1nSHRrQlVtQk1y?=
 =?utf-8?B?QWFDR3Vhd2swRklIWEY1ZU1WcEx6TlBCSFk2eEVIZVBCaFpqVkpFM1pTSUxl?=
 =?utf-8?B?NnpJOExFdGxVZG1yNTVwSHRwREpXOU04UTZLS2NIa1k1RXNDN3BoU1dNL21m?=
 =?utf-8?B?bUFmMEs5T1M1TzR4TVJYNTFLcHN3SHJlOGVucWhFUzVVZ3A1VE1laVljbEVJ?=
 =?utf-8?B?L21QM0hrMGdvZm95dHFNVzdRbUxDa3ZNTWZ6RjVsWE9sUUxaYktKamN2K1RS?=
 =?utf-8?B?ekN3MVhuL05sMnBXbVlIWVJFM2VtNndDZkFINUd2YVpmNithN0dnb2kxMUFp?=
 =?utf-8?B?ODRBcEFBN0RmK0tOTGc0d3gwU2tDMVVwN3FvQWVGZWpmanVmTWoyV3B3T2Vi?=
 =?utf-8?B?MGJYL1U2NkN0QWpMbHFGRERpRXVOMWZRYjM0bjQxQU85OEdFQnJaR1ExUE9h?=
 =?utf-8?B?eWdyTlJLTGp4amVpcGxtdFpwQ2U2UGxyQk5DY20yTEtFTUROUmZLMVBPaVN3?=
 =?utf-8?B?aklBcytuWW9DYzhOWmdaT3ArSW9uM0wxanVWaCtBT2FLVndWcERjbUlmQTg0?=
 =?utf-8?B?RG9ITG03QllxRGVSc0J4VWhyZ3lGWVhJYXRvdm1SOFUzZ1ZQY1pkcFU0bWZU?=
 =?utf-8?B?dE1JMGtVWDJmZXhLbzJ2Y1JXamVucU9YYXJyMjEwMFhveDhSUmZ2dS9kMjl6?=
 =?utf-8?B?T2VxaER1SGplWXpQUDMxNis4Wnl1THdvcm5WZml4VTVrQkhRM3VXdFFBbjBa?=
 =?utf-8?B?ZnJsMmVrMDJFK241V1dzR1ZPeGxzUy9tWXQwWHhjMit2dFg0Y1VWcStabjMw?=
 =?utf-8?B?c1V6Qmx6M2NJZndVSk1SVmNqMnZqQlJWOUJpcy9wejd5a1ZxK2YrUC9NTjJv?=
 =?utf-8?B?VDJVYTdaYXhBb0crMG82OURrQmNSNmxIVUFWa1l1MmdUQThIaElMRTZrMXVy?=
 =?utf-8?B?K2Z0WjBnK2t2akNpWEJlWTlpWnBjSTZDOGNvdHd1eGlWNVlta0JDOElId3c4?=
 =?utf-8?B?T0tYV2Y0eGtjV1ZRRlA3RGUvaHpXUDBUK05mdWRIaEo2VzdLU0JQSkFzOXBL?=
 =?utf-8?B?V1FodDJEeDB5eGpaaVV5MDh2RVNqMWw4KytST0d5Y0V1MUQvK1RCVjUwNFUy?=
 =?utf-8?B?Z2FOa0dydHVobGk5RDRaaldMTGVSNlhDZlRHUGFlRlhybkZ1S0ZtSWFycTVk?=
 =?utf-8?B?VCtaK1ZROW1xMFl4WkFlaXNDMUJiMENHdHRDRHlzemM2WW1iM1RCeFczL1hy?=
 =?utf-8?B?Sm5hd0NCbU94T3RqdWhzSzhweFJlS2V2aUVCb3lHZlVHTlIxQzNZQlphSDlq?=
 =?utf-8?Q?TxVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkRqd0svbkJHbEgzY3d6S2tveHcvQzJqN3NCc2hSVmU5UTlDUnlsclpvR3RQ?=
 =?utf-8?B?MTVsREJFcmpNOVNHcS9xcXlCTjhxME9Rbitra3N5L0ptNnRZenNmRjIrd0xv?=
 =?utf-8?B?dXFwaDdEMWtHQnJSc21pQzIrRGdZV2RHanJwUWt2cFR1djAvQVlXZ3pOdlpT?=
 =?utf-8?B?eEg0QnB4K2F6VG5CMmY4M09aelI0MGtDZEFud3psNnk0amUreVplc1R0Mk96?=
 =?utf-8?B?OW83NW1URE5VL1hhOG5qTGxQWUVzVEJvYStIa0JaTUh0TVRUdEx4SXprcmRQ?=
 =?utf-8?B?YVlueVk0S3F4TWRtcUFFSE5HUUJQaVMrODFmSExOb0xHSkVRVExwM08vY3Zu?=
 =?utf-8?B?MTlOUlpjUkNjQm1EUjQ0dHVvM1RrN3lyT1psYWhGOUUwWkp3RWU5Smk1VE4x?=
 =?utf-8?B?V0dKUk9UTEYwellRSHpOUnhKT2wzamY5TXZzZ1Q2UURFZXBwRTlWak9hc1la?=
 =?utf-8?B?RFBsblRqN2puemphNHFKT0NiK0xKU0pqUk5acGRaWUwrMXdaWHBKVlVrdFNR?=
 =?utf-8?B?bVZTR3pyWGRJMG1nczFvdDFEc2lTR0d1OHdKS1AvbWNDY21kTnYxcjdwbzJn?=
 =?utf-8?B?Y2tidzlwWldIb2ZxbGRJYUxSRTlrNGx2Mmp0N0d4NmR4VTh0WWRuV2JxY0hj?=
 =?utf-8?B?VEJWa0dOQjRnY3hyWGNpT3o2dDJzVXRxd0tVeWlLMjI1OEtDYUUrQW5GdXhu?=
 =?utf-8?B?Ym9ycFJuSU13WXZTZytuZUFYekJLNVRUNXM4Z1pveGVlKzczcWNyZmovWUFu?=
 =?utf-8?B?enFFaUl6RXg2QkJnTGZXeGJJaEhjcUpJU0g5VFh5SDZkQllCa1VjbWk4SVU3?=
 =?utf-8?B?TVBRa052Vjk2SFdEU0Qwai9wT3Zzcjc5WTFtQWVKd0sybmZYZmdZaVpsUzgy?=
 =?utf-8?B?TGtNMjdUTVBzSldHWlh0b284R3lacnliaG1CTFVxR2N3V3dKeWI0c0ltL0xF?=
 =?utf-8?B?RGdBRW82ZGhrNG5PK29kRm13OWthNEt2YlNRaDNpQjdiQU8wZk01QStnR01w?=
 =?utf-8?B?dytCZlJTMDB6SWpjRDhmeDVSNGhCMjZGeFVjV0lKMXh4OUhJNlgzZ3JJZFpo?=
 =?utf-8?B?Q1JQWXNpZVRSa1Z5c21DQ2F0ZlVCWlZiS20vVHUyUUtmN1phNnlKMTlVaDdE?=
 =?utf-8?B?WHlKMW9uYktNUVpsMVVVbmdaYVB0TURGTnd6RTdwbDdFZVZrcTVXRWk0Y0hk?=
 =?utf-8?B?aDdkZE1sajJ1aE9QWGY0eWxIWHhOMVpObVoydS9aQzgvUUZ0WDlFMDZUVXJM?=
 =?utf-8?B?Z3RVMDhoTXVJYXhLQU5wbnZuN2kvWHRPYU1RQTQ2VGN3K1FldHlpbEZuc3lk?=
 =?utf-8?B?Zlplb005S2g5bmFHV1NQM2lZVHFyS09BaTU4c0phcEs2VG9qY2V2K0tEdkZX?=
 =?utf-8?B?UXNBeWptVXB2MXdBSzdjWXNORzVlNEVna0xLMDhDeERDWnBLbWp0ZmhsMnZz?=
 =?utf-8?B?ZnI5TFFKa0kzUjdrZjJXTUI2ZlR0QmpzNk40N3QxQ1JXbm95dzR4STBLSWt6?=
 =?utf-8?B?bVVQd0tNZjFsZWltcGZGelFscUY3azJqR3VvTkhmWTRvVmVPVitlc3dzTzhY?=
 =?utf-8?B?YnJUbllFYjhUaTE2N3BadjJsNkJ0NU9aY3V3YVFOQk5ZSlkvUEhDM1V4SEc3?=
 =?utf-8?B?YytEanFWOE5VTVJLWm5ZYmRlUnJPTElhejEyTUNWU29DSXlVa0VURWdFUE04?=
 =?utf-8?B?V2ZFZDAzNi9zWWltdmFaRWVyaW5LQ0o1aGxJeTBnWTUrOE0rTHpTQzRsVUdy?=
 =?utf-8?B?OEk0RUlDR2FEMzFzMHhYUWZoYXdMVHU0WlFUVHVkUFZ3ckRZaHJzRS9WbUov?=
 =?utf-8?B?Um5DN0I2MmlVcHhsNnM2aEljWXF4MEU0RHZuWEowV2tOUHFEdE0vSDhJVVVk?=
 =?utf-8?B?QXdqTmQxeGZIdExVQzBQQlpLVjBMcVJmWUZhSEJOMzh6QjRReUtJZ1hlOHdC?=
 =?utf-8?B?WWRpRFdaaEo2M2F0NjNYTWRTSmF0QzJJTndVMkQ5SzU5OFR2YytSMGViMnNB?=
 =?utf-8?B?cHVGR0JnUVpzbUlVTUFZVktSMHBpd0dsSklsMExJeUtpNGJMcFlycDJJTDJs?=
 =?utf-8?B?b3duSGtXWGE4L2Z4Nkl6U1VjaEN5cWd4WVUvNWZOSXZFV0EvWjZzbWxidy9D?=
 =?utf-8?B?YkttRVBmOHhMNG1zd0dRTWZsRzlMdjNhYnBGQ1VUNThlSUpRL0lnTlpFY3FY?=
 =?utf-8?B?RDBBWjdidnBCZG1iQjh0S0lpSTdVeUR2cXFVOTNCV0Rjd1RYYWYvMGxrSFlp?=
 =?utf-8?B?bEZESHViY0NWWGFyRFBQYW5ETHRLWmJSbVVvaUgrWjBvbXRhZUhub0twLy9W?=
 =?utf-8?Q?SRuY17g2ZRCXkQmrIu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27b47e2-a338-4b37-8656-08de5b83f58e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 20:05:45.4716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fik7hrolZIbqYpyw52XS06hz8vzJQRVbBWk++9F/usMSYXj/nfHQAL+vSLcrCkqU9lUhxHlE20YeU8GLrZ/BfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20601-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 340B77ECD4
X-Rspamd-Action: no action


On 22/01/26 14:26, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 2026/1/20 22:56, Sumit Gupta wrote:
>> Add cppc_get_perf() function to read values of performance control
>> registers including desired_perf, min_perf, max_perf, energy_perf,
>> and auto_sel.
>>
>> This provides a read interface to complement the existing
>> cppc_set_perf() write interface for performance control registers.
>>
>> Note that auto_sel is read by cppc_get_perf() but not written by
>> cppc_set_perf() to avoid unintended mode changes during performance
>> updates. It can be updated with existing dedicated cppc_set_auto_sel()
>> API.
>>
>> Use cppc_get_perf() in cppc_cpufreq_get_cpu_data() to initialize
>> perf_ctrls with current hardware register values during cpufreq
>> policy initialization.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       | 80 ++++++++++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c |  6 +++
>>   include/acpi/cppc_acpi.h       |  5 +++
>>   3 files changed, 91 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index a09bdabaa804..de35aeb07833 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1739,6 +1739,86 @@ int cppc_set_enable(int cpu, bool enable)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_enable);
>>
>> +/**
>> + * cppc_get_perf - Get a CPU's performance controls.
>> + * @cpu: CPU for which to get performance controls.
>> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
>> + *
>> + * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
>> + */
>> +int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>> +{
>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +     struct cpc_register_resource *desired_perf_reg,
>> +                                  *min_perf_reg, *max_perf_reg,
>> +                                  *energy_perf_reg, *auto_sel_reg;
>> +     u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
>> +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>> +     struct cppc_pcc_data *pcc_ss_data = NULL;
>> +     int ret = 0, regs_in_pcc = 0;
>> +
>> +     if (!cpc_desc) {
>> +             pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (!perf_ctrls) {
>> +             pr_debug("Invalid perf_ctrls pointer\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>> +     min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
>> +     max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>> +     energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>> +     auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>> +
>> +     /* Are any of the regs PCC ?*/
>> +     if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
>> +         CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
>> +         CPC_IN_PCC(auto_sel_reg)) {
>> +             if (pcc_ss_id < 0) {
>> +                     pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
>> +                     return -ENODEV;
>> +             }
>> +             pcc_ss_data = pcc_data[pcc_ss_id];
>> +             regs_in_pcc = 1;
>> +             down_write(&pcc_ss_data->pcc_lock);
>> +             /* Ring doorbell once to update PCC subspace */
>> +             if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
>> +                     ret = -EIO;
>> +                     goto out_err;
>> +             }
>> +     }
>> +
>> +     /* Read optional elements if present */
>> +     if (CPC_SUPPORTED(max_perf_reg))
>> +             cpc_read(cpu, max_perf_reg, &max);
>> +     perf_ctrls->max_perf = max;
>> +
>> +     if (CPC_SUPPORTED(min_perf_reg))
>> +             cpc_read(cpu, min_perf_reg, &min);
>> +     perf_ctrls->min_perf = min;
>> +
>> +     if (CPC_SUPPORTED(desired_perf_reg))
>> +             cpc_read(cpu, desired_perf_reg, &desired_perf);
>> +     perf_ctrls->desired_perf = desired_perf;
> desired_perf_reg is not an optional one, so it has to be supported.

The current code handles mixed cases correctly.
When either register is in PCC, the first if block executes and calls
cpc_write() for both registers. The cpc_write() internally handles
each register's type (PCC, FFH, or SystemMemory)

Thank you,
Sumit Gupta


>> +
>> +     if (CPC_SUPPORTED(energy_perf_reg))
>> +             cpc_read(cpu, energy_perf_reg, &energy_perf);
>> +     perf_ctrls->energy_perf = energy_perf;
>> +
>> +     if (CPC_SUPPORTED(auto_sel_reg))
>> +             cpc_read(cpu, auto_sel_reg, &auto_sel);
>> +     perf_ctrls->auto_sel = (bool)auto_sel;
>> +
>> +out_err:
>> +     if (regs_in_pcc)
>> +             up_write(&pcc_ss_data->pcc_lock);
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_perf);
>> +
>>   /**
>>    * cppc_set_perf - Set a CPU's performance controls.
>>    * @cpu: CPU for which to set performance controls.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index c95dcd7719c3..229880c4eedb 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -594,6 +594,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>                goto free_mask;
>>        }
>>
>> +     ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
>> +     if (ret) {
>> +             pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
>> +             goto free_mask;
>> +     }
>> +
>>        return cpu_data;
>>
>>   free_mask:
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 4d644f03098e..3fc796c0d902 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -151,6 +151,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>>   extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
>>   extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
>>   extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>> +extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>>   extern int cppc_set_enable(int cpu, bool enable);
>>   extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>> @@ -193,6 +194,10 @@ static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_
>>   {
>>        return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>>   static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>   {
>>        return -EOPNOTSUPP;

