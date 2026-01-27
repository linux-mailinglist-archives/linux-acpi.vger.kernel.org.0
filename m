Return-Path: <linux-acpi+bounces-20653-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DY4LhWfeGn4rQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20653-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:18:45 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E263D937B2
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07413300B450
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9F346AFB;
	Tue, 27 Jan 2026 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N8BRNbnC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A931F346AC3;
	Tue, 27 Jan 2026 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512692; cv=fail; b=kHBHqtDZEzrURayJC2pYKdTpTAdc/Jhfp+AgAQyD5PJQO6xdBVAE2p13CeEETG4eYJZk1dz8xEOzNaYQQ0qB9hGirukItQcusJ6Dg/S9YPEADFILLl+kVxBrp2agbaPpJX+GtRiJqN6F+0BYuu/Il1z2OL7YjGZaca/NCeyvcYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512692; c=relaxed/simple;
	bh=se2tzBVoNtIPO/1UYHATDHOf7n9IHYPmp+0fAMnN8Hk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h/03mLE5u539Njdk4SHWtdVksZatvtorUWdBjGODVg7aNQau9xOQYeqBTxxEoy6NzRQLW8MO3zO2lfgU+2WVygwQXHzXirABsyQq/A+38KVTe9fxNOFwLJoYu/j+3q9/fmR3DChvkoFEjjKcpvOOqbzhtUWyQHcuJqzsl6CXGvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N8BRNbnC; arc=fail smtp.client-ip=52.101.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vi0SRa+ZSa8Q7P8WW/+uArGMutbGnO87K+myRmKy8duDdUcVVZKuDWi4hDiU1Sj4KNp/BpmkxODBxqZbIaiIKLjF0I4R+qZR4a8pbP+rRqEsgU+nbOUbOSDrIH+agX5TMdtnzx5lcwvRK+OcIauTr7NKL5AILWdsFkTL+CEEmheipAshuw29Efkg0irCPVvHfNttvheB00TD+I4xtqAWheAzuRhTj1b3iiFpPE8T7QwyqQzmMpT926FIeG/7vStNi16cx/47hF+gStT7o33FacJ1yb6NjPfcMiPI7UUMtN1vVzvS6aDLf9r1qn9i/mvTDEBdCv7d9YFNuFDbrWMM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuFkAcINP2gMN9L2pXv7vQZYFNskBJoBMXXQ0N9T+SU=;
 b=vRCWHr7S9uTyR97zaH+w2LZ+B3cRohIuHwgkNTgm1J3yQTnm0l0UzAbs0LHp0dKPG5mzvfUVadcAy3unsKt9G20kWqpVPsGJhBPAm0IERO/MZUN3CuFeG3hcyfYP3t943Xx0WUhpPY6HS2FF1AU27aJU2Fx8misa207QrBBgQ5UeogZvHoNnYYJalaYSF5E5uI4SZDT4Qwf+7uoDPfxPCoOJf7wbEefrjXCtmeCYNof1sbbQ259xBzaXCSUKDKbpLSgdVIL9YcoQED/YiUpmwhA99SYikSSRV+Z/u4N0AadTUy6i0VJheLtZ1JlMWSq5yA60yofpZ/w+s2+dWcf+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuFkAcINP2gMN9L2pXv7vQZYFNskBJoBMXXQ0N9T+SU=;
 b=N8BRNbnCUffku4uXYs1b7DagF3IUcjiMZQ6U3CSMaP5EZODBAdatytgwFDccDr8YjWn06arFMaUtwD2usGhzlHcRn4WI2qoNfza0ynD4cKRR6fX7/jS2Cabn3qzwcIuEctHh/svtm0ggaMbb9jrq5GcBDkcufAzEB8iSoVfmLzV6bXAhRxTYNsJSp86qk0PxofsY9PzLxEkKBv1iOACFwobkdljfG0KpVcyzLqKCaJ6GHDzG2bB4cMh5Ww8U2/XyeVJIDmbS2ynBJmW80iBkZLJWzlVADz3roAXXwQU0kqLZXtg6+CkIzjiWk+HE/GeFO6kjS5eFL1AGTwUxJw3VUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 11:18:06 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 11:18:06 +0000
Message-ID: <abf9889b-d5e7-4c4b-b166-a5dde2425ab8@nvidia.com>
Date: Tue, 27 Jan 2026 16:47:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] ACPI: CPPC: Extend cppc_set_epp_perf() for
 FFH/SystemMemory
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
 <20260120145623.2959636-6-sumitg@nvidia.com>
 <a7a4d351-eed3-4ea6-a84f-e525b7ac13a6@huawei.com>
 <86303677-6124-424f-999d-c420eac0cceb@nvidia.com>
 <7e86cdbe-f16c-4fe8-92c5-e6fb89f49811@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <7e86cdbe-f16c-4fe8-92c5-e6fb89f49811@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0186.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::16) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 62425119-325a-4d6f-8ce9-08de5d95be3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHBkR3VDR3dhZHNIR2VzUlpvNEh2Und3Z0hXZkhpeEVTT0NpSStaMFE4ZHpF?=
 =?utf-8?B?L2xXVSs3VlZ2V2VadTlzbThxUE1rcExqYWlVa2wwY3JyQ3ppSU5QUjdpZVQx?=
 =?utf-8?B?amVxTDRBakJ2cnE5UCtzOWxmblZyaFBNbENORzIrOXYwZlRTTTQ3S2twQXRr?=
 =?utf-8?B?TkNqMEY3VE5XMm5wWWFqTkltSlZSYmZ4UU9hdzJnaEJkRWpuZGZWS2tmMk90?=
 =?utf-8?B?Z01nWU9TajRZbTFuUmhKazZsWCtKdzZkSXpJZUNEK00xaktac0JOQ2pMbmlS?=
 =?utf-8?B?ZytGSWNGZ05vb3dpcWp4UURIZVVuUjgvTnprRDFNQ2tnTUdZOE5KUkFmVUoy?=
 =?utf-8?B?M1JSeDY1cUtLMFFPZEpKVVBucm5VSmtuTEFBQWJWeEFPTWtMVHlIU3RFNVNy?=
 =?utf-8?B?UU9ZMGxjaHF2c0pxR1QrckxjWmNDajRkNzZxSmtwYnF2c0tOL3V6a1BmdU1x?=
 =?utf-8?B?SXhNaTFoNjMrSmM5WmprZ2poczNuem43T1cxTTA4Nm03ZGIxQzJBZGlNWVFz?=
 =?utf-8?B?QXU3S3JaTTZQaHI0VWhnRFZBM2hRVEJqTWtiVHRTWVlWUTgyMnpXcTl5NjVI?=
 =?utf-8?B?NmRySlRnNVEwcS9aVzIvb2lraU9KODdhY0pMbGIvV2RHT0RXQTJwTlJvS0pv?=
 =?utf-8?B?Nmhpc0NnSFlUV1puc0pKOFptajlRbmJsblFzUk1jNlZaVjF0ZDhvMHUzbGVT?=
 =?utf-8?B?Mlg3WEVBVmNPT3Frd0o4b2QxK0crNUhTYUdRdnAwMCtnSmppUzZVcHdFaFg4?=
 =?utf-8?B?UGdhcWVqQUZ3NkdodTFzeUNEWitmSGsvWGhwUUVhM2h5eEk5cjBhU0c3MWVv?=
 =?utf-8?B?VHFramlIYkJ1c3FrTVg3WlF0U3JZUm1xbStYUW5aSFgxc1I2T1Bua3Ivc2po?=
 =?utf-8?B?N1pQLys4aUlrR1FuN1JuMHorTCt3WVJxUUU0SXZuc2VvTFBPZ3A5MzIxV2hI?=
 =?utf-8?B?bGxMZjRscEI5aHdIY1BTTDA5N3pqMDljbmN3NmhkVE1nMzl6eS9XbnVDVlFm?=
 =?utf-8?B?UUUrTE9DUWh5NEdzVDE2d09GSGZSS3pGR08vR0lwR0tFY2RreXpSMFhwNjl3?=
 =?utf-8?B?bk9sUjFKaWpKTFE3L1pOTDVyYlVyUllRZWF3dW1wRFdWUk9BeEhZNzNxU1pO?=
 =?utf-8?B?d1Ryc3QwMWkwS3dYcWtHVXQrc0NZUS93WG40Z2hJdTNZQUpoZE5UL1ExZURL?=
 =?utf-8?B?TGQwZkNaZkc1UWhDSnZKN3BHL1VlanVWYUFkUTJiUm5KK3I2TjVyekFWZm5R?=
 =?utf-8?B?MXlWWU1MZFJzVjVPcElHenVlbE50SkQrQkRiL0RtT3ppRmc3d3JNM3U1dG40?=
 =?utf-8?B?WjhmMXVrVENuN2pMdzJpSHNCNThvNWVZM0NoMWp3T0daSk92bDJGbWRUb0kv?=
 =?utf-8?B?dHZWc1dRenJuTStIMUVoQnlEekkrM0gwRlZ2VnZhT0xiZlFRNi9LTzhLdlYv?=
 =?utf-8?B?V2FMcXROL1lvRG5UTkxKN29DdnY3Z3BvenVsdXFGWWI3SFZTR1Z1Q0VhY3lD?=
 =?utf-8?B?V0E1d2czM0l5SGtBeDNtVHhEbjlGTFNKVTFVNmF2K0RPWWczOWJWUUFXeXRZ?=
 =?utf-8?B?amk5Q3R1ZVlRakpUM3l5amkySkJ5SWdBa3NXZWRPQXJ1OHJMYnZ2NTFaN0tt?=
 =?utf-8?B?anZYSEpQRVAxUFc5OUpvdDRoTHZRSHZwbW1EM04vQlJObFdsVDZtZ0J5dzVs?=
 =?utf-8?B?aUd5SVFGRmZtYW9qb2c1UmIzYzNvNFQ2TUp4M05rMDJuK0lLLytMdEs1dnlE?=
 =?utf-8?B?WTZTeUt1Tnp5SlhYRmtTWHlwNklyK1NLYk4vTFBIMWlxeVNtQ2FueWZaZjBo?=
 =?utf-8?B?ckNhTlR1NXNkKzF4QXZES3BBTXpWdEJzWlgvWnVrS1kxd3J5RnlyWWYrek1s?=
 =?utf-8?B?OXFHeFkwZXdUZFM1c21YTFpJbVNmVnVqQURDdzZjRWRVLytyTGZ2SVA2WUhu?=
 =?utf-8?B?emdXVUNmTjlYbXZRdmlXQ012RTVJMzRYeFhQVWNoWXZDcWVUUmJqU3dsTHdS?=
 =?utf-8?B?ako0ZjhrV0VML1BmZnE5SHJMVVNpNVNSVUhINVcyM2hod3YvV2thRmtHSDJV?=
 =?utf-8?B?aXJqYkJSZUpBQVVURmxlaUxBN29EUVVvNlc0SjJTa0VJRyt3MzIyR2g3L2pz?=
 =?utf-8?Q?62uc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW1lN2FvZDVmeGVpdHFBNWRoZk9ZMFhxQXR3bU1OczJLWjlHSFRSTW9Bc1Vo?=
 =?utf-8?B?R2hQVEw3aDNqUE50elpxZUFtTGUva3Nud1dFbFlVR0lRSmZEZ0c1dHlyUHNE?=
 =?utf-8?B?b0JlWDQwNkliUitkdHdvdW1KRjM1YjFlZWx5TExvd3NDS3oyZ01YVGRiZG1Z?=
 =?utf-8?B?RHFjbWJZUFBpT0lTQzRWSkRVY3RTMnN2Y1ZIUUxvODVIb2ZsRUloa0dVOXFj?=
 =?utf-8?B?aU5aUEdydEM0OTUwRFJEMEI1NTMwbmthMEorV3RYNnpnUm9ROVlWZUovdW1K?=
 =?utf-8?B?Zll3ZGJSSG9yYlZwdE8xS25JUmZQQ3RHZ3AwVlFvVUVvTi9uTTR3TmVqU0Rw?=
 =?utf-8?B?N0hVSTU0YXZRWGVYSnl6cldNdmI5d1dkT1hTNXVKOFc1NURKTGtiQVVsNFN0?=
 =?utf-8?B?cjk1dHRzTGRJbnh2MjU4R1dzQ052eUVFMnBVMjBzUDhMY05rQytMRjhJemEx?=
 =?utf-8?B?TEUxRFZheDVCc3FNODh3cHRrTk5ZOGxBczYxU3preU5IN3ZBYTJQLy9SKzI1?=
 =?utf-8?B?Uk5VWG9SbXRPTzhFVTdxdERmSWtHaWxZSWZBaGNUTW5CbTJSU0RRbUVKbE1T?=
 =?utf-8?B?c201N3pvQ2NESUpIMFJTeHRSZHNYdkQ3aVR4alZsV1E2WnQzcE9aU29NSFlp?=
 =?utf-8?B?WUhuUjBsaWM3SlVHMW02b3pENnlvOHdoeXZLMnZTNCtydFBrc05CNnNPY0ow?=
 =?utf-8?B?L3lMNllZeHJhNVYvbjREaGFSd1dhcVVvaHhocHdhOTdrV1lKdDBGUXhwMDRq?=
 =?utf-8?B?RGtqaU14OXR5THRuRnE2U2JtNG9wWG5HYm5vRVk4SjFFMFpscnUweE5JaDJW?=
 =?utf-8?B?bWE0NXdUUXNjUnNva054QkpiRitKY2FGaWxxQzMyVHMzVTNpMlE5ZE41U2xG?=
 =?utf-8?B?QkhpKzZzNVRGazMvMFZzaWpLQm9yYlI1Ukx3N01XQW44aEVmMWduOWpKUmty?=
 =?utf-8?B?ZS9rTW1sdlhUQzdnSHc5NVZCNXZjbU1NUUFmK0NzbTYrMTBHSHA0dFMvNjZQ?=
 =?utf-8?B?a0ZQbmtTMU5YTGhZMTk4THZXRGdjTXViMTVZd09lME1ZTTFtSEk3OGQzdE5Z?=
 =?utf-8?B?aVZuOTFranFtS1RiZXRVZDUwZmN5L1hqbXpjek9KZnIzMWxVZ2hSOWk5R2Jm?=
 =?utf-8?B?M0sxTW1ub0NIT3R0RUhYVHoyOTYyRDMvcTFnTmRNTUgvWStLeDJoWGZ4alRH?=
 =?utf-8?B?dEUwNGtnRUtubXZlY2F5bHRSQ084MFFOUzdFaW1WdDF3dDg5YUx5emI0S25l?=
 =?utf-8?B?UGJjdkwySFJtMFMxT2NFd2RwR3JXaDM1Q2pOWjNWdWk3elRFcUFXU1p1UTYy?=
 =?utf-8?B?MHVOSW00LytvNk1qV0pTNk1qalBsWW9GbTdjdHdnVGZlUk04U0tQMWVoRDE4?=
 =?utf-8?B?UkFEVzJpR3pycWtscmEwZ0EyYXBuVXhlRlFnWUFUeE85YXF6RCt2emw3Y3BG?=
 =?utf-8?B?VEF4djlDb2RPWldhdHhxQjc5YmY2QzRMR3pldmorekt2S3BVWlM0TW5wNm5Z?=
 =?utf-8?B?NUMwcDdSM0w5bWJkTlFMcitBUFRlcHMyd2R3RERzSmxXU0Y1OGJCS29LSVNx?=
 =?utf-8?B?S3krMXFmQTF1VnluVHUvK1M2TDlNRHBPV1l5WVhmU21KNzAxZnM5SFJUUkQ4?=
 =?utf-8?B?VVMxVjloY2VrTVBoVDFPUlJtRWVvS1cvNXhDbjdYMG5YbGVXb0tlV0dIZm1G?=
 =?utf-8?B?WW5Kb2k0ckxJbW1OTnRNWWtoNEdxaGhFZUFCWkYzTUM0SnJFTUR4TXJhc2ts?=
 =?utf-8?B?TUZhMHpnOHVoaHJLTVFtanl5MzdycGN2ekV3QWRsQ0JndjdDL3l4V1pPVlBl?=
 =?utf-8?B?WEEyc0JjUlQwNXhNUHErc1lMd2lGMzFDTUlkenFVVnlBN0p6a0plNGRPeVZj?=
 =?utf-8?B?TjRBRlZTNWlNUzlxOWFGZWFjeE8reUdqc0xYSDI4WTNhZU5QUTVDZjZ3dzFH?=
 =?utf-8?B?UXpSMVVNM0NTMEx5MVA0QUZ1K2MxSDBSVC95cmFpemhtZHVsTWovejJLYVF0?=
 =?utf-8?B?cEhUUDlkQ29RZFpxakxHVUU1eUhYS2xTWjY4Y2tTMFlZUEhXQUVzUHlxL2VJ?=
 =?utf-8?B?RUx3eTJidk84aGJFUFowMk84L1BJRDZtZmN6NGUzRXlzWWVwRGpmSWZ5bG5t?=
 =?utf-8?B?VXh3Y1JtMTVRVzA2SjZtSEhITzNxWVNqRkpLbjJXWkNsRWhXeGY0T0EyMVB3?=
 =?utf-8?B?bHU4UWVxWWIvYjNrMXdZNEoxQjJHenV3dCsrNG1SM3gxR1RMSVdCYmE4cEp6?=
 =?utf-8?B?WTNvRkRWaWlENytGQXFDNkthaGMrVGFoU011U3dpTXVHQlEvN3Q4ckNadllx?=
 =?utf-8?B?R3NaR3pxeWdoelVaQ0ExcFQvUS85K2ZQWmZ0OHlwR3p3NXlkVm5Udz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62425119-325a-4d6f-8ce9-08de5d95be3e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 11:18:06.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qt60ZGwAFm66oyaFjxKsXE7d0HzaL2QtlSXC2QhlyVQ8D6McF6zbBnl7E5AgVoQGwZ0M9Y5z4RUkG/2hH6y66A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20653-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E263D937B2
X-Rspamd-Action: no action


>>> On 2026/1/20 22:56, Sumit Gupta wrote:
>>>> Extend cppc_set_epp_perf() to write both auto_sel and energy_perf
>>>> registers when they are in FFH or SystemMemory address space.
>>>>
>>>> This keeps the behavior consistent with PCC case where both registers
>>>> are already updated together, but was missing for FFH/SystemMemory.
>>>>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>    drivers/acpi/cppc_acpi.c | 24 +++++++++++++++++++++---
>>>>    1 file changed, 21 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>> index de35aeb07833..45c6bd6ec24b 100644
>>>> --- a/drivers/acpi/cppc_acpi.c
>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>> @@ -1562,6 +1562,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>         struct cpc_register_resource *auto_sel_reg;
>>>>         struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>>>         struct cppc_pcc_data *pcc_ss_data = NULL;
>>>> +     bool autosel_ffh_sysmem;
>>>> +     bool epp_ffh_sysmem;
>>>>         int ret;
>>>>
>>>>         if (!cpc_desc) {
>>>> @@ -1572,6 +1574,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>         auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>>>         epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>>>
>>>> +     epp_ffh_sysmem = CPC_SUPPORTED(epp_set_reg) &&
>>>> +             (CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
>>>> +     autosel_ffh_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
>>>> +             (CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
>>>> +
>>>>         if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>>>>                 if (pcc_ss_id < 0) {
>>>>                         pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
>>>> @@ -1597,11 +1604,22 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>                 ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>>>>                 up_write(&pcc_ss_data->pcc_lock);
>>>>         } else if (osc_cpc_flexible_adr_space_confirmed &&
>>>> -                CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
>>>> -             ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>>>> +                (epp_ffh_sysmem || autosel_ffh_sysmem)) {
>>>> +             if (autosel_ffh_sysmem) {
>>>> +                     ret = cpc_write(cpu, auto_sel_reg, enable);
>>>> +                     if (ret)
>>>> +                             return ret;
>>>> +             }
>>>> +
>>>> +             if (epp_ffh_sysmem) {
>>>> +                     ret = cpc_write(cpu, epp_set_reg,
>>>> +                                     perf_ctrls->energy_perf);
>>>> +                     if (ret)
>>>> +                             return ret;
>>>> +             }
>>> Don't know if such a scenario exists, but if one of them is in PCC and the
>>> other is in FFH or system memory, only the one in PCC will be updated
>>> based on your modifications.
>> The current code handles mixed cases correctly.
>> When either register is in PCC, the first if block executes and calls
>> cpc_write() for both registers. The cpc_write() internally handles
>> each register's type (PCC, FFH, or SystemMemory)
> Yes, I was wrong.
>
> According to the first if block, cpc_wite() is OK to be called for a
> register not in PCC. So it looks like this 'else if' is unnecessary. Only
> CPC_SUPPORTED is needed to be checked before calling cpc_write(), isn't it?

Yes, Once 'osc_cpc_flexible_adr_space_confirmed' is removed,
cppc_set_epp_perf() can be simplified to just call cpc_write() for
supported registers and only do PCC handling when needed.
As Pierre suggested [1], I will send a separate patch set for this
cleanup after the current patch set.
  [1] 
https://lore.kernel.org/all/c3fd7249-3cba-43e9-85c6-eadd711c0527@nvidia.com/

Thank you,
Sumit Gupta

....



