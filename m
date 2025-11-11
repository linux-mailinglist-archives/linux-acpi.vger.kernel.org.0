Return-Path: <linux-acpi+bounces-18772-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A4FC4D58C
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 12:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3847B4F8EC8
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF3C35470C;
	Tue, 11 Nov 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WUeuOvKy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012051.outbound.protection.outlook.com [40.93.195.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395DF350A06;
	Tue, 11 Nov 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859180; cv=fail; b=TgvNXqyBngUD0wfxuG3V/qPqbqQNR5kK1Ho3JRewXFd82dzQW198AKzZl1Ke2WQGEkHVyxqfTyO7LtzvdRc2gdQL56JKGR/SjEJ3x83uqmgvDxkl8ro2ed7QTQOotzpNW5U460FLeR/YPjBTrhnYijRLSEO7gBdkZdHrpyu+FJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859180; c=relaxed/simple;
	bh=Ns1EsZCWZU9HZ6enT/L4BN4FjwzZIabPyskIjOFAY5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mdxyMxXAfYi57AN6tWRDjty11r6FjzcMpXv0lWBKr3RZ2sw3/iru39Hf/rifU7aVQmXPuPoVkRbDO+7mHcIxyUxRWnxqwQm1/5Qz2ah39PkXnYdRVFCm9TgK0bi7xK5ZqzskOtYfYRKBMopCYjnfG+g+HT80SIbgF/RX5eqNLE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WUeuOvKy; arc=fail smtp.client-ip=40.93.195.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Viy2l/+D0r96erB+sO7TIIQgZtejwqJOSAYgbGWINmho+w9DVMzwu8JPE/oEQ26nadQdJhuCNajL7Q671rVcKMKJtqkin6j9QfDz2sAaxN0pw1VlKEfNHVFoffT6nzqQTwewtoIexeT2bADJCH18rHY5elB9cspq/Rm5LNxKJRRVHMVMd3CdoCF66ycPD90cI0UqSuH4fYhq0wKdYn5VPAkyOJZCBi6E8IxU2qZcbC7DkaiPI0giSWA9V0uAOzZFNydPVU/Qf98alWTkogGwtTT+i7p0WN15ST9TJRqWzFjzwkDDau2aIPY0N4z4KiHM/QNZN9k68tQPrvRQZJHFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NNmWUgmyCzxXTFoPg7up8iRT4elAX3ds83adaY2wtk=;
 b=jeclQ4lV/rCqCLyt/x/Is+E3BbioIm3USllBIjXzzyChuDv6ztyOERAjXJSDKFo7ojBIyUgjHOx0eWI6Wif7Kcoinic2I/G7AuLy7nzz2SYAyqMnV4Jc4xjLquJzV585GcIdjgkcUlCV1lze6GFFMHyqcwzPryHOQLidDR9hd2uHjp6UUlAxFkd18d2sveuyPSDfRuW0AUWUDOVuAgwy3ETao2Hfag9ufDW+xmsJGe1o84qk7z9HrJtjYGNpbyIXSdc8t3fpJRkk2SpizP8Y1n29Jvm8lBGigSHyfTteNFOvGgecW+wz93eXWwXO+UkQ0BJabkVtP9qIvZKrXaxIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NNmWUgmyCzxXTFoPg7up8iRT4elAX3ds83adaY2wtk=;
 b=WUeuOvKyCWKBuGmYY3jpObUR1XIHCE0l5eYeXHBBn7vj8RSHZ9tMDAbQP4xL7Rz5xeKhZBcP7ZI1O3z5ryrdjyEbatvRiu09OBuLMT+ctUY2CmAOaZcPnG3a9EQ2vtsDkKuDNKGAzHQ16MP+RxgpmJT5CQe+5evfBWuvJukCG0fxQQuq6DLLG6uBSPWwVD2qh8bQJAorAwFcN4JaJ3PMB4ReOAT7fcYKwu/MpduJ8PXXbfjW7BW6nl4g08YR+0Jmo9lYGFkmQCm5ZN5K/S7IZPToJpLYc1Z83UpVJ+XmcdtRQCHH6DW9ukEwG5uOfXztsxi8lLnrqyzIf0JhvhVUNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 11:06:15 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 11:06:14 +0000
Message-ID: <aec90c07-7528-4390-8599-e60d09159133@nvidia.com>
Date: Tue, 11 Nov 2025 16:36:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kernel test robot <lkp@intel.com>, viresh.kumar@linaro.org,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 pierre.gondois@arm.com, zhenglifeng1@huawei.com, rdunlap@infradead.org,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, ionela.voinescu@arm.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20251105113844.4086250-5-sumitg@nvidia.com>
 <202511061802.lIq09jwh-lkp@intel.com>
 <be696cb5-7d0d-44f6-970b-e417c2f89a8e@nvidia.com>
 <CAJZ5v0j8bQm+00+m75rmpKpm8yVumvYsWzCdYyCPwksnebY__A@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0j8bQm+00+m75rmpKpm8yVumvYsWzCdYyCPwksnebY__A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0074.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::8) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6a943a-1654-4903-3193-08de21125454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cklNVzFtL1Z3QjNGZUFQMDZEem12dnlPa1RQQ1FpdmVtU1hpMWdMS3ErMWpB?=
 =?utf-8?B?L1J6UkNCTzg2a1lnenJGbE9KUVcvZWVzZTZmMWFObWo3VUhkMEtZamVjcEk0?=
 =?utf-8?B?eU1RaEcxZy9rQTZESldVeHZ3azBTOHY4Y1QvZmpONGdpMElrRVhGZWxZUjlD?=
 =?utf-8?B?SDIrZjJKbmZ3dE82ZmduSGdmeWJHODI3UTA3LzlMOHAzNkFWYXZiUU1ub2hC?=
 =?utf-8?B?OXl3M3FiWXJkSkM4RkdXK0ViYkhlcktoMUpHa2UrZ1M1TjF3RnZ2VDZ4U1ll?=
 =?utf-8?B?emZnR08wWm13R2QxLzh4ajVtNVRZT0VDYVgvYTVVeEpzUERLempUMkpuazh1?=
 =?utf-8?B?Uk0rZy9EUVIvNDJ3SU9mdW10ejZYa0Z6Si96R2lySWRZUWpZNUVzbzlhc01J?=
 =?utf-8?B?TnN1WVAyc2ZIOXZRMkxNQW5wNElFYXFSaXMyd01FY1VCVzBZdlJqUjdZVEZ2?=
 =?utf-8?B?L2o3UHBHVjNNclQrNXRUNW05Z0tkRGZsYW9BKzUweXZ5MjFycVRNSEpuaW16?=
 =?utf-8?B?Rk00dDFlZ2l3M2xhQ3FoTFR5QllXMkMvb0pJNlRvcjA3OU15YW5nb0xoYnhr?=
 =?utf-8?B?eTlvQlV5ZE9BZVJBMUYvMG9JV0Q0bW5aMzRrVFM5VXdyc0wrN3czWkpjYWh5?=
 =?utf-8?B?b08ybE5BbDBnTHJiWEFtK1V1RHFLNitha01GMUVxT2JOMG5MK2tFbjF0dU5w?=
 =?utf-8?B?QkpYU0lGSWtiSEJCdTMxdHd1NFVIS1lxbHhNQTlLTU1KYWZNZFRjdys5SlRN?=
 =?utf-8?B?TUdFTzdaaHpUWW9helR0azF5dEFJZHNseVVqKzAyN0JBaC9iVWplSjV1Rkth?=
 =?utf-8?B?M3FYMEdwZ1pBeDNQWXIvZ2dFRWwyRnZaS1VZTVlDd2o0Z2QrM2M2R3hNbFJE?=
 =?utf-8?B?bG5IcG0vUTd6Q2lmdk9QNTdFQ2FkODV2ZTl4cUc2d2Z5SldjaThZd0JKSkpG?=
 =?utf-8?B?eFhndWIwVFc1SjRTblNibHEwWFE0cjVQVXo4MEY5a0lpbFhCV0FCY3ZmSEV6?=
 =?utf-8?B?Nit5ejZTaExmalEzS01IQnlvYUJ3OTloS2s2ZHpqOFZOeCtjLzNWblVUOGVt?=
 =?utf-8?B?UFpjbzNjMUZMZkowTmtMMjZIWGhKL0E2dUdIM2VqNlVwWHlucnh1ZE41TFVa?=
 =?utf-8?B?bTVGR1ZpZVh3YXozVk1FRFFmMGo3RXBRbWhGSGtMaXNOTlY0aFBLZktqUTVK?=
 =?utf-8?B?bkVDaUNub0FTdjhKQWpIdmtJbnE2eExNTW1vaENqcmE4Z1BobGZGeEhjOGtu?=
 =?utf-8?B?c29JbjB6eVpIYjlnWXBXNE9rOWVUekdLNlYzbHZZVGpVRzZwMFUxaktkMHNX?=
 =?utf-8?B?THBwM1lMRkRFSHcrcUlQL2VZWW9nekozTzR6OXYxNWcwUS8yVUJVK0E0MjlI?=
 =?utf-8?B?KzVYTmpvRW9JUFNKZWZzYURUcHZRMDNGMFRjZDNBekg0SkRtSXEzcmRkNk5C?=
 =?utf-8?B?RzJKOFY0UXVVSVhuZktIUmhIMldKVDJ1WDllcVZKRlp0Q1dLYkZpNHJNbEpp?=
 =?utf-8?B?MmMzbGdGeHlTSDF4bU9qdUNDYkJuRmdhcm1pYW9rWElUbUZrb3NNQ1lrTlIz?=
 =?utf-8?B?dE5lWjE0U0xzWVdoN1B5N0NOUHR4eTNwMGgyQ3RkOXduL1hraGJJSkZ4LzFG?=
 =?utf-8?B?NlBZTWVlcDh1WVhlaGpyRTJRZmsyRVZzaGgzN2hWN3JJWUp5OGRVUzBHVXFU?=
 =?utf-8?B?c1BFUVBLNXB3eDVYdXdTYnRzTnpWSGNBRjFFcDFNUlBGUVZka0FRdG9wRnJZ?=
 =?utf-8?B?enlvWE96bm1mNWpzMDhWL0dySG1RdnpJa2ZFWERWalpwdlk3OHVITElNeWdm?=
 =?utf-8?B?SEhPYkUwQ2lpeitEZnNEZ0hnMmJnRUNGS284bzVXL3RCeWl4eEd2b0lFU1Jm?=
 =?utf-8?B?N3RaK0dmdzhJUUM0UUJ1c09pWFV3NVVHTW5aR3FnWTZyNUxsNWpXeWdpZ1RT?=
 =?utf-8?B?U2lkWVIxYW5ZTkE3K0JXMXNIczdVZU80QUVnL0xKL1NzN2VjLytudzZ0OFgx?=
 =?utf-8?B?SVRlelZEZlZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFVkdWYzTjBwNnNHc2lJc1dZYUxoYVplaVVzMmtoNVJmdTc5NTh6NjBHNlkz?=
 =?utf-8?B?MDg4dWhEZ1VCQzVFTVFacXg4QTkyUjdPMDRLb2JRRGN6dFZqRnZLc2FhSHBM?=
 =?utf-8?B?VEZHeXBXNnZ4bE9ET0dYQy96ZDErZmRQTG9hU1NOcjFxYmRJdVl4RXVSd1VY?=
 =?utf-8?B?UDd0c084eXg2WGxIWGMyR3VhZUlxTWdsNlBZdFNzb1kyRUY1VnJOL09VTWJq?=
 =?utf-8?B?ZGg4ekRvbVE1VG90NHZGSExiSldiMzZ0NDU3N1ZuZEZOVWw3RU5Sa2kxNHRj?=
 =?utf-8?B?ckZUNlN0RUNaVi9JNG1DR090RmFaUisrcCtEQUNxWFZwSFo2MFNLN3hGWHFn?=
 =?utf-8?B?ckxUVGtKbDVNdTNJZnNWL0lCOVFlRFpJdzlFUnlZTkU0OEVGdFVYV2VvaWJn?=
 =?utf-8?B?UUlZSmdPNjhjVEhFTFg2K1ZVdEJoaXFnU1FTRDcrSW8zT0hUK01rQnZ2WWcr?=
 =?utf-8?B?L0E1QmJQclNHS2hOOWpHRjM3cmd3eVV4UElqN1hUWEVuejBET2ZKWmJUaU5O?=
 =?utf-8?B?WnJSTTN0emh1QjI1T1RaSGxBTEJpcld3Mi85OHA0TllRc3hYdFNKWFFWSHNL?=
 =?utf-8?B?YTVBK0hPemVFamNxZkRPcXJvT1gwWktLeHRqdlgrZ2hEUHdEMU5KQXRkWU1B?=
 =?utf-8?B?cVVKeXg1dm1WL3Z2WDY5Q1hSU3h6V0pzMjExNGtFWGh3KzByOG8rd1l6YThJ?=
 =?utf-8?B?ejROeGprQjJXMGplcUlZaTlJMTNkUDYzNmtlUTdUZ2lEZnhCK0lXV1pUci92?=
 =?utf-8?B?VmQzeTFBYnhpTitYUjR1WTlzNThQckpMdUtSdXArelpKRmlBYkRZU3laQ0lS?=
 =?utf-8?B?UVN2SmZJVUNObEoxRVhqTkRRUDhEUXFTUlFoUEJHT29wemE1eTkxaytLWVBu?=
 =?utf-8?B?L2Q5WThLWFRvSEZJbVV1bTErYnM5Q1oxamFyYUhYU3pkZ0d4NnJCbGdsVVB5?=
 =?utf-8?B?UnNWa3NqU2d2Z215UUpNUlJIZVZNRkluQXhPT3FKa2RBR3hQVS9YWGE4M0ww?=
 =?utf-8?B?YVAyS2ZoTXN1WEl3cURYTDlHczhleGpodmYwOG9ndk0ybHZYYnlQN1pUbHNr?=
 =?utf-8?B?bCtqbTB1cGdvOGt3S1Z1akNEZnNYZi9PRDJhbnpoSnNzL2Irbkl0Sm5JTWJs?=
 =?utf-8?B?aHo5VjNmaWc1T3V4SjJPQTFCelEzY1kycVBrem45YWNpYUx4YjA3VHZWUkRx?=
 =?utf-8?B?bzZwR2JhcDZ3Y1VUUmlldEdVMFkwb2h4S2hiYSt1UUtlQUt5N296OEFTMlZH?=
 =?utf-8?B?SGFJOURPeDhDNUJBQ28wZ2ZVaHZnaGxpenJYbU9DbEovNFNwVVJVTWJST0hp?=
 =?utf-8?B?bmowbWU2ekRKczhQczlSeWMvRWIzMkgvZTRBejZqeUN5bFkwVExndDl6SWhC?=
 =?utf-8?B?aDZzbmppdk9kTzQ2eDd5ODdsbG82dlNZbjJsRDZHTHpVemwvcnVCeHI4U3BE?=
 =?utf-8?B?UTYrcExlek5vMkJJU3JLODgyd2RodEJjeHZZOFVadTJvRFZ2WGpmU2NHTUVS?=
 =?utf-8?B?dVNyMWNmOHVXNlhDSmg4SkdJVElwaUIzNW5STjQzT29NTUtaMWlaV3paak1w?=
 =?utf-8?B?Q3gzdzc3T09rSnBPUng3enUzdFJzeWlNUElEOVM2bmtCaEtvdVNLdzYwTU15?=
 =?utf-8?B?Umd3ZlhsM2lmVmVmaXYySFVDZTVERkxRUFFHVkY0dG9rOURlakErcEZ2ZkhO?=
 =?utf-8?B?eVpBdWU0TVJZYUFTMmdUSXdLclE4bGFHdzZkVVlTSUFxdmQwdnhmK2hrMnNn?=
 =?utf-8?B?Qzd6bEVzV0tsWWQ5dDJFamJSMG9EZmUweSsrOTdiTmQ4Ty8zejlpUC9QRndQ?=
 =?utf-8?B?UnowMVJuK0QzMTBIZDBtUFhlNkxOWk1JMUQzQ3BYOC9aRDB0OUdVUzVuZ2NU?=
 =?utf-8?B?QVAwQ1NNRXVZd1g1Tjg5K21xVnNJczhJZmFQT2dzVXc0TzNBSGlOdnc4YTJV?=
 =?utf-8?B?S3JNdVJacWh5S25nNTU4bzUybUNXL3JuTXlNaGE3VTNGRnlRYVArWHNxM1BT?=
 =?utf-8?B?ay90MGVXQ2l4Ym9oN3ZTdW5TcWFwdjZ2TTlxK3FSY2gzZnJMVnE2U3lsT01p?=
 =?utf-8?B?WmJXVGoreENDR2NkZHkzSTFzZUltcnhMUTc3V2JyVEtKMkZCai9TUTROaTRB?=
 =?utf-8?Q?djHye99VeYrGySQpayLVODREU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6a943a-1654-4903-3193-08de21125454
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 11:06:14.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QXVi/UjVcQCr986jLK7QfCqujztNB4tUXSaAXC6md5+cUGQXeYJnP9CGIYEm4t6Fx2ZcwTOXyHTgzbOTj6Igw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279


On 08/11/25 01:38, Rafael J. Wysocki wrote:
....
>
>>>>> Warning: drivers/cpufreq/cppc_cpufreq.c:954 function parameter 'policy' not described in 'show_min_perf'
>>>>> Warning: drivers/cpufreq/cppc_cpufreq.c:954 function parameter 'buf' not described in 'show_min_perf'
>>>>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'policy' not described in 'store_min_perf'
>>>>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'buf' not described in 'store_min_perf'
>>>>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'count' not described in 'store_min_perf'
>>>>> Warning: drivers/cpufreq/cppc_cpufreq.c:1003 function parameter 'policy' not described in 'show_max_perf'
>>>>> Warning: drivers/cpufreq/cppc_cpufreq.c:1003 function parameter 'buf' not described in 'show_max_perf'
>>>>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'policy' not described in 'store_max_perf'
>>>>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'buf' not described in 'store_max_perf'
>>>>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'count' not described in 'store_max_perf'
>>> --
>>> 0-DAY CI Kernel Test Service
>>> https://github.com/intel/lkp-tests/wiki
>>
>> Thank you for the report.
>> Below change to comments seem to be fixing this warning.
> So can you please send a new version of this patch with the changes
> below folded in?

Sure.


>> -------------------------------------------------------
>>     /**
>>     * show_min_perf - Show minimum performance as frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer to write the frequency value to
>>     *
>>     * Reads the MIN_PERF register and converts the performance value to
>>     * frequency (kHz) for user-space consumption.
>> @@ -1117,6 +1119,9 @@ static ssize_t show_min_perf(struct cpufreq_policy
>> *policy, char *buf)
>>
>>    /**
>>     * store_min_perf - Set minimum performance from frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer to write the frequency value to
>> + * @count: size of @buf
>>     *
>>     * Converts the user-provided frequency (kHz) to a performance value
>>     * and writes it to the MIN_PERF register.
>> @@ -1144,6 +1149,8 @@ static ssize_t store_min_perf(struct
>> cpufreq_policy *policy, const char *buf, si
>>
>>    /**
>>     * show_max_perf - Show maximum performance as frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer to write the frequency value to
>>     *
>>     * Reads the MAX_PERF register and converts the performance value to
>>     * frequency (kHz) for user-space consumption.
>> @@ -1166,6 +1173,9 @@ static ssize_t show_max_perf(struct cpufreq_policy
>> *policy, char *buf)
>>
>>    /**
>>     * store_max_perf - Set maximum performance from frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer to write the frequency value to
>> + * @count: size of @buf
>> -------------------------------------------------------
> As for the whole series, I generally need ARM folks to review it and
> tell me that it is fine.
>
> Thanks!

Will wait if ARM folks have any new comment and then re-spin next version?

Thank you,
Sumit Gupta


