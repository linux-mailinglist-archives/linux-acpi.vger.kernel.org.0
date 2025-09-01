Return-Path: <linux-acpi+bounces-16250-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07D1B3E455
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 15:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85ED5481A09
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20AE33438E;
	Mon,  1 Sep 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWX5RdTO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F11E0B86;
	Mon,  1 Sep 2025 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732349; cv=fail; b=FtMn1XeAMVKl7vDkpKyT9V35hdpbmUNLa4uP6PaIT16RHqDcJrsOUi8oPj1ol0Rq6sHLqj5LsO6NHiRVC8BWndDyrg1xvHTsFaD3mehG0rfI2LYEp8fWrcqQ85TTtSsvyQOiItfk0fr89p7dAwCzPNq3hUH4zNQSfDBfS4/wwj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732349; c=relaxed/simple;
	bh=GSWxGy5B1ERw9yG7Zg8ULMqkYsffVvrB+joxb9Kx3/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XGNVzIEvjNvJHuzC5TYKUEqrJ1l0NSBq5tbm9IMwIHqpzd29k2GOPQAxhln9kZWXGGQ8sWUDH+0qWFziGnGpq9Wt6LLt+rEf4/r7cuxdCV7E4K+dSC6XsR+Ql+M5wmelm6NAvwSWvtzUiqz0cnMlSFPXu9xiaZmDisTxAarHVD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PWX5RdTO; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uckDtn8pk+k578E3JLYc2F9Olm0MwC0sXrg5rH347OwiRSXTQxKpV4Wz1h/iyxF9tTPz1IFcMTvCwe4etKfqYF4PE65PyKJtPhMijVj2BHxNYOn+3bRFa3X4F4JaGmYUjcNDiFYnkyXQ4BtNtE1OMgELitqobWwW/2HsLxl5O53Op7MbdP89TAx01NYBOM9I1QdeUDv+tuopoEuNuCOAE+xM7NOZSRgocm4XxtivI02wWiSUp9ldYL4fkOIgDvgFlegHfbJJ4vm2TEObigbmrPQiVN/3qC6/R8bazkzfXuWLc8UHQxqKtnaKsKwirh6FNnabklhAbEcAxCH/orVSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwFEpEPxAFdDnMT2Zocsm9IHrjIgAx3Uw/FJG/730xQ=;
 b=rWc2kYP1ytmSAnAG2xIqDmal2hNOm09C9r501axoYTfuhfsVa+p9zQI+XECZYTtT0ZlavTRLFEvc9CxgvvyGTsROWPLvtogF8TLyj1qsKq7WV40fZOd+XZEoZhEOIxgnKG31VBoDRAb29bN270eOH5Qf/5ShMhixeztbYatjMPVv3g/VK+zVkpSH2eDL7XoXpQWfO3nfCU3GXcrybOsJ2rZ4LQHpbQw/XG+kq3sYuYTyH8Nt1ldkYxS2JAoj9rj8RVyS07/oZbQKxbKU51wqQs5nceDY9nfapx579xi7lF498T6CcT8aJ32yc2CLTltHvwe6jBrGSxehIoyJk8GH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwFEpEPxAFdDnMT2Zocsm9IHrjIgAx3Uw/FJG/730xQ=;
 b=PWX5RdTOSx6CWWH+9C89eFU1A4BcuPV2hVn2VGKRkfoc7ZIW7wxhFzHVl9BKB0FGEJeg7cl0tX0dnExVqvZe0CP+NEtxJQssxqq3YTM/5k49Zu+79qHlCUXsoJMkBeuJSRAKyOnGt72iPrBPTsRB6Z6Jwl3QicJudWDSRGlMQ/Z7LgvOjWjXbwUJoRzYZHsYSaVjEZ4p2df2p8QMiA+E7rCnuFt2v4fC//dWXjM/SuEOxM3RhvVdzm7V6Jiy2hEFNayfPPlXm86u2iVNf6gribr6oDGvseRACUH0M7jT/Q9WdpWdT88l2E+KO3C5hDi+13f7MzPpxN+5wEhjkcYqXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 13:12:23 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:12:22 +0000
Message-ID: <c40e11b1-afa3-437e-a308-4648f19627a8@nvidia.com>
Date: Mon, 1 Sep 2025 18:42:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
To: Randy Dunlap <rdunlap@infradead.org>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20250823200121.1320197-1-sumitg@nvidia.com>
 <20250823200121.1320197-7-sumitg@nvidia.com>
 <769e0ce4-1f96-4de5-a8a9-48166d6e3a91@infradead.org>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <769e0ce4-1f96-4de5-a8a9-48166d6e3a91@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::16) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 67754585-e4f3-4b8d-008a-08dde9592f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NStLYUVwVUdXdERNcjhuZ1lFQ1pmMWpQYmhpaTJQczUwMU1kY21HUnpyaVpm?=
 =?utf-8?B?V3hTUWR5cjFFNzBNUzhWZlllOTFWbFdUeGhyNy9OZHAzcXFvWS9JTmhNYTlK?=
 =?utf-8?B?cG9RZHBPMlFkOHBqNjludFFNMFpuakZ2cmpnZjFtaGNOV1RjTlRsbE9qTmdH?=
 =?utf-8?B?cEVsMC9HeUwwaEpmbUdSWmpsc211NHRuTmJCZTMxOFYvUTJjN0VpVjcrQm5h?=
 =?utf-8?B?TEI5TXV0S09GWm82bGozWFQraWxlaXg4MUhCb0QzUWhRMHdybkx6QUNXTE5j?=
 =?utf-8?B?QXpxeS8xRHBGSkFTQURNMVNSQldXa1pXQzVpRlVMSmpmcS9mdHdVUnp5T3B3?=
 =?utf-8?B?dU9LTXNGbnltZzk1UHlnTTdMc05qN1ExZyt5eXYxWFdwZHRGR29rL2x1UnZ6?=
 =?utf-8?B?UllTYnIwVnBUWE13cUNGOVFmRlZPdjJWeld6MFp4b2UwSGNsOUpZZ0J3MG5k?=
 =?utf-8?B?QzRnaFk5UGl2UjBob2JZd0xHaklLdEVueXFVL0dEcStrVEpidjFPQmxMUVdZ?=
 =?utf-8?B?V3RVc05iWmNIU0hHWVMrSitBNS80SHhUN29hUlNjVUxLaUt5V0ZiU2svak1P?=
 =?utf-8?B?bjd5TW42OG56VklGWlFRbUMrTlBVd0dldGNxV0NVd2kwbVBTNkhJb2ZjaEw2?=
 =?utf-8?B?dnh6UktDU3FQTWVFeVoxVStNd0NGRlk0OXRvdG5IOE0xdFJyaGpmV3ZJKzBM?=
 =?utf-8?B?RU1NSEM1bVQwQkUwODFyUVo1QUN2ckpLRkZycDViRjRLN0VZTXpERXQ5OGRq?=
 =?utf-8?B?b05jUnhNdmh2SW9CdFVoRkUyL1UvWGNRSUpIQWtaNXAxVGwyZXByNUZJTmNq?=
 =?utf-8?B?R2pYOGF6emZkVkhwcERnZlMxeFNBQXM4SzdyVlY0YVd5OGJnQWxPOHBoZmQy?=
 =?utf-8?B?b3EvQjdWNDcxd01URkFLTThFK0RwUG9qUVpRZkIxZ1JwQmZLMWlLeHUrRUZs?=
 =?utf-8?B?d3RHTmdqZ2taQVJyc0FVVEpDdWh0RDEvZlk2VUlyYWNwZkVxb0lGZVBtckF4?=
 =?utf-8?B?dlJTeTBzSXkvSW5ZY2Q3b0VLL1hwMjBLSE5teHFzY0tia3ZSUnc3cHdJa09u?=
 =?utf-8?B?Q1g5SlloN0dXZHZ3cjNubnAvUWZLTVhDVkM0dlBLRVpTdnRwY3JONFdPQ0Ez?=
 =?utf-8?B?MjJhQllra3lwS21QL3E1Tk10Mmh6eU4rYS9OdW5HVURSeTJoL0QyZlNaZERJ?=
 =?utf-8?B?d0JDOEo0RFdkOHF1ZGFjK3llVERQa1VXd3Q2RzlXYkdGaG42Y0tka0hCcE9w?=
 =?utf-8?B?VzMrckZaUUp2V3dCRElla1hWbzNCRHNDSmFpT2gvMnpRUitJKzZSWGt2ZmtR?=
 =?utf-8?B?QjhoMUZKb09QVzQ2Y2NtTkpVN2QzbVVWMjJQL3JDT3ZuMmhiSHdWc1czL2du?=
 =?utf-8?B?OTVscVFIT1hCWCtJUmJYY1R1K2d6dFpJUDJHTzdxT0RNaGp5VUJLOHFabUxq?=
 =?utf-8?B?czVRY0owSG8wUDAxanBtNC8zR0JidHk5WkNMS25iUmQwZTNIakN2VDdacmxZ?=
 =?utf-8?B?NVB3cWU1UXhZS0EydjZ5VnhETmpiN2dScFZoSjFYWmZ3MnBmaEVRR1Z4THFU?=
 =?utf-8?B?U1ZrRjMrRjBNOGhXSDM5cnQ1N0JGZ1lvb1NFOVVGakkrL2tKdUxCT1FaSnpG?=
 =?utf-8?B?NDRhamwvcDFlLzlrNzVOVWdzQ0xScmVQR2g4aExWUkM2K245UmlNQUd3ajBi?=
 =?utf-8?B?R1pHclltNkgwcnBBb0lhMGNjeFF5UjdRSndaUyt2TGZwTjNTMG9SaEFuRVAv?=
 =?utf-8?B?eFYwcWVnSEV2TWwrUnhLcFJaR2VhdVo1eUx6WEFJTW5BQnJmbC9ROSsrZDda?=
 =?utf-8?B?a1Z5S2VVU28wenU0aHJOU3FNczlDN1pnS2dXL3UrT0tRaDRLNFJhVWlnc2hh?=
 =?utf-8?B?WE9QUXhWdE40NmpVSVFCQytjZ1RjaUtJaEJ3MFZRd0RSS25hMGVQN2w0dC8y?=
 =?utf-8?B?Rk9SSWxOOVZEQitNRE5wQ3JTZlIzcVpOU2c4Z2h5ejdKRkFRd3B6TUdsKzN2?=
 =?utf-8?B?R2ZqcUp1ODZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em96cXR6T1FNekc5cDVVZXVqRUtWbWgrS285ZlIvNzd2N0lEVWR6czY3dFUz?=
 =?utf-8?B?d1A3bmZoamtjL3BDcVJVUlhuT0EzUCtzSThGTUJCSE1SbUcwa3VZb2NBMnhl?=
 =?utf-8?B?Zlp6VnZ2VnlHYXNYWGY2TTR0MVhYYWx4R2thQ3FuNDBrNzBTS0pJQmVYVktZ?=
 =?utf-8?B?Z3NkWS9jdTB1YVpJM3J5eFd2UEw0Y3ppbzJCT2w4ZlJibzRTYnVmQXl6Mm5v?=
 =?utf-8?B?NVkrQVp0dFR2cFo2MEJBbzJZbnVHb1pPZUZ0UlVIOVF6LzQ2U25HbDJmWWY3?=
 =?utf-8?B?RmtGYlNONHB6THA0Rmg2UjVGVkU2ZWFCQWRoZWZXZ0xqQnk0RVZjSDNRZmor?=
 =?utf-8?B?QXBMVUo5TzNXUlp5dFhCQVRZYVRBclJRaStTWGJyRm5zSTJFNit2SHFyYmxX?=
 =?utf-8?B?cENESmZQZ3ZrMU8yUS9lRnNyUGFQWUpHcGFVem1DT2gxcmluQVd2SW1FY1hD?=
 =?utf-8?B?UWhQWUxRT3J6UXp0R1A0anY4RkpaSCsvQmFsbktkbStoU3dFVUc3Uk14aVR3?=
 =?utf-8?B?K3ozU0VkUmNZd2d4U1k0bkpIa214Tisxa1orNnUzaVVlTXJ3YTBWZkJmYnNE?=
 =?utf-8?B?OCs5MFl4SW5odkx6dWEzczNWK0J0K3dBdm9ZcSt0SWxlZUJJTUVPeDdiVkJi?=
 =?utf-8?B?SEFmT09JMUNwVXlTRy84YTNUUlp3QjZ1ejg5R1VybU9BK2x3bmtpUzZIMUNY?=
 =?utf-8?B?R3Jmek14SUVXS2puYnVFRFR1aUkvbHY0akM4VmptSzZCMElDVkpQTVIzd3lm?=
 =?utf-8?B?eXJGM0h4Q3dKMG1NbGRkRXd0ZnRGZk9ycnRmc2NnWHluSlg4SW9Gczkxd0Zp?=
 =?utf-8?B?THpWRTNBMUIrRWV0R1BJcGpvNWFLaFR1NUhjdVgwTXNCc3Z0NmtaYmpnSXh0?=
 =?utf-8?B?VllSK2lGVzBEczA5aXVrWDNTMjVxUXMxczEwWWYzd2VLUjErbWZYN1NFeEc0?=
 =?utf-8?B?NUZ5aUxiQkVhbmVqMS9MbWM3K0VCUzNObnJRdllLQU5odWZWOXRhY3IxakU0?=
 =?utf-8?B?T0M3UE9qYmFPSUF4ZmZiaHZaaXBhV2hFODE2bjNVTjVVeUY3bVJncDJ6ZTkz?=
 =?utf-8?B?N3czeXpHaFpKUC9BZ0g3MXZBODdOcXlleGh4VkRmR2d4MWVWbElzZkFxMHMr?=
 =?utf-8?B?eDdERm9VT0NDaElrOFFJZWZqNDhxZEorYllwV3pEek42eUU5TlU2R2tnME52?=
 =?utf-8?B?UE1oZm5zcmF2VGJuQ0RvTWIyeUoraVE1d016SDVmcEpEWVN3a0NjZFB4TW5D?=
 =?utf-8?B?QjZsZ241Y0UrU1NqWExTWHREa3Nab0t4cUhwWHpteTFGbnNtYXJSOE94cUg5?=
 =?utf-8?B?RDkreVQ1Tktoa1hFLytMWXBoUTJDcjZxZW1sWXZWd3NLY1BFcDdGS1NHZ1VY?=
 =?utf-8?B?V2dDQ0ZmWkdmUHNaS29TbEdaL1NXL09ZWVN2cXIrWTFpR1B1Yk5xdTZVRitm?=
 =?utf-8?B?SHpJcmhEWDlpd1VVUzdDemRxbHRpaUhZbk1sOXMrVnFQakN5SEtCemNqRHJX?=
 =?utf-8?B?eUJHKzRGQTYvZERkalFXODgyRXZnUndOSGRxcW9PUVBDWEh5QXhWVmhyZUlP?=
 =?utf-8?B?YmJGcE1PZHl5bitXcFJmdUN2UFMrSkdwQmVQd29kaGVjYTVGRE93NkgyWnlY?=
 =?utf-8?B?UEVIOHNSZFRud2ZMbWtrRWh2c2pZODY4YzgzVk9PbDJXd1ZtaGMxdWRMdnhx?=
 =?utf-8?B?MkpzVHNBbS9jWmJZUGhNMGovVHJ6QkIzbGdIOTZKMTVJeEpyNllqOWl0am1z?=
 =?utf-8?B?QnZabVhWWFV2NHpGWmpMRW5pUWdvNTkyb3FHSWZ3UVlZZW1Ncm5nVzlPcEJP?=
 =?utf-8?B?REM3NzhqcWhDYzRjL01RUGQxVjQyNUdqdjFQZWQzUFN1OTJ3R0VxLzdLZ00w?=
 =?utf-8?B?a0F4MkR6OHpSMmtCOWVjQXpXZXZNdllJTDlKUCtzY093QzdGWUdobDFyZkFw?=
 =?utf-8?B?UjExbHExZ21GZm9Ja0NwV2duV00vaHhlSm02c204a1pSL294UWMvRlBDQngr?=
 =?utf-8?B?eEdrZ0V6cEhtd200bnUvMDhmVGdHeXZ0Smt1THFCb1hQRUZUSncwdUMrRHQz?=
 =?utf-8?B?azJwaVNVQ244N3BQM3lVNVBHM21wMnk5dCsyc0J1NTBTV01HZG03SmRRQ2tk?=
 =?utf-8?Q?EHv+1543rudpuxLLd6WXYGp6m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67754585-e4f3-4b8d-008a-08dde9592f5b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:12:22.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCuUbC8BB8GsZFhAhy/m08GWHJK55dYWg+hvjwuvooM+MUk5rvCiLvvh40nqVmcehwQwXqdELK2ovtMvXxHeTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905


On 24/08/25 05:38, Randy Dunlap wrote:
>
> On 8/23/25 1:01 PM, Sumit Gupta wrote:
>> Add sysfs interfaces for Minimum Performance, Maximum Performance
>> and Performance Limited Register in the cppc_cpufreq driver.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../ABI/testing/sysfs-devices-system-cpu      | 43 +++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index ab8cd337f43a..4bce0dbc48c9 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -327,6 +327,49 @@ Description:	Energy performance preference
>>   
>>   		This file is only present if the cppc-cpufreq driver is in use.
>>   
>> +What:           /sys/devices/system/cpu/cpuX/cpufreq/min_perf
>> +Date:           Aug 2025
>> +Contact:        linux-pm@vger.kernel.org
>> +Description:    Minimum Performance
> Preferably these 4 lines above use tab(s) after the ':' for indentation
> instead of spaces. (in 3 places, i.e., each sysfs file entry).

Sorry for replying late as I was on vacation.

Sure, will replace spaces with tabs in v3 and add your 'Reviewed-by'.


Thank you,

Sumit Gupta


>> +
>> +		Read/write a 32 bits value from/to this file. This file
>> +		conveys the minimum performance level at which the platform
>> +		may run. Minimum performance may be set to any performance
>> +		value in the range [Lowest Performance, Highest Performance],
>> +		inclusive but must be set to a value that is less than or
>> +		equal to that specified by the Maximum Performance Register.
>> +
>> +		Writing to this file only has meaning when Autonomous Selection
>> +		is enabled.
>> +
>> +		This file is only present if the cppc-cpufreq driver is in use.
>> +
>> +What:           /sys/devices/system/cpu/cpuX/cpufreq/max_perf
>> +Date:           Aug 2025
>> +Contact:        linux-pm@vger.kernel.org
>> +Description:    Minimum Performance
>> +
>> +		Read/write a 32 bits value from/to this file. This file conveys
>> +		the maximum performance level at which the platform may run.
>> +		Maximum performance may be set to any performance value in the
>> +		range [Lowest Performance, Highest Performance], inclusive.
>> +
>> +		Writing to this file only has meaning when Autonomous Selection is
>> +		enabled.
>> +
>> +		This file is only present if the cppc-cpufreq driver is in use.
>> +
>> +What:           /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
>> +Date:           Aug 2025
>> +Contact:        linux-pm@vger.kernel.org
>> +Description:    Minimum Performance
>> +
>> +		Read/write a 32 bits value from/to this file. This file indicates
>> +		to OSPM that an unpredictable event has limited processor
>> +		performance, and the delivered performance may be less than
>> +		desired/minimum performance.
>> +
>> +		This file is only present if the cppc-cpufreq driver is in use.
>>   
>>   What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>   Date:		August 2008
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks.
>

