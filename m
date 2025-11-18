Return-Path: <linux-acpi+bounces-19007-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6942C68948
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 10:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 597DE35703F
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98BD31280F;
	Tue, 18 Nov 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KVmR3CTo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7B2F1FED;
	Tue, 18 Nov 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458513; cv=fail; b=kc7Cp/OIaVkXQSKAZvRLlM0dDh4WRf7kJ1lXPGG+p6shzZD7cpmujyjj++TTcCl4YCRRwKfX9Z6IokoktIT2h6yTT4sf3sLGQ+tuX5trfGJ1z2B0zRwm6QrHPrYRWpg+RPntI0fNZfb/boAn2ctO+e5FFgKWhnXCV0IBk3xt5mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458513; c=relaxed/simple;
	bh=H4L11u6QccGaIRh7i4yUa9hUubI64VME4ezQ1m3OV+E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GG6jayGb79tfEQVX1+cF/Zhsqt9g0JS5r1xWfWjESZGTXDbYbzLGwRROerc/ZIxynZ/dAPUUyV9u3Cnk0FS38vIMHrlYQRiAUM+iurJAnUl3yPEyB/aOea1zkP+fi/G/+mU30gltzJeaSsfno6JqmQsX3F7lNSUuDR2iH/cMBG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KVmR3CTo; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwyEFvrb9K7mt13wQ7xBcWmOxcSv99Mc7DWdVTn0yb1EwqfUNebTzR9Bf2KDg/4qHc86DS2KJLRClC4YFHhMEe86nMdcKBBA/LQNP+qrsdaNYQocE0dpoicpydqtXfF3lXaHh1dYbWEdPdHagfkIQ1pvkl/SJO5oLRjLCZ+hhsyCUzX6ULE6I9Lqlpcau/KYykQ0la1dEEpPqj1t5EmIwPXVGiDTMtmddL6TlO3lhkHMBSFYoKYwPS3drLsKpmJinKAUX2Gd2o3FFp1Dypj8p9OXfMI0UcBuDjRXuigV4wcfZ9faja1bK3Lk8oAkuXo8W8qV+aFWm1nb3tSVv2pMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihzdpiBt8q4BrD3QgGjlhaVKiSRrIFXYJ6mVlYGEW9A=;
 b=rR7x+jN78/9LX1WjANfOy8FelK2yz5dHc2GY6JZZPeFvg9S03Pv1fD8ZvLszo8OF+enH19tLfPSLBP8MBDt8NawyqFNJNhrW36UiZouCUwMFs1NmyJWrsYFN238oQsY8c64lGA/JKxYvyoj5dupXGYwSKesyugP68fFmlY3/6d9r1xW2ri2uJ89s+mi1gA9l1ABzUxXJM2cK42iO8UIpA41GoxFmz/cHxsUm51WLmIkF+xzL1dWqhU5fx0oOXg0NuULOVFVeketS9PBSpEvlhKF67zAAHyYltzWi+Xv6+apDcrYEGZ01tASIcdIomS4lEhoAgbq8MmNY7iMeSeY/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihzdpiBt8q4BrD3QgGjlhaVKiSRrIFXYJ6mVlYGEW9A=;
 b=KVmR3CToUhVEykMSZdjVZ1dZlgr4qoEILY9AUmDHuMOExxooQEwZpUADABu+4R0r0QH4An1aDNNjBQLUYQUvjZ1I9dIQA4w2BDH6H+q23p7nLAw9rdI+IGOM9105eU2HrIPifgiX0wS5RNM+DV94dKvxro5ks0zTjqXxhJRnB5MjVEAE/sWc/Y1BWn7xc2VtoyIeQqy8dcqI1uM4lpzzCLT6pWEyzqfAGZkbEMgPxas57Vro5D9SJ38S0i7mgO0Cjlgof7RRQ0r9LwwnYGYXd6YixCN5ULvqpDSBlhlYPoV2G9Uw7GcpM7/TC6CSUNr35CDShHUQNPfXmHHe1mkHbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 09:35:07 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 09:35:06 +0000
Message-ID: <34bdd40f-bad0-4c6f-91ef-a3bcacd180fb@nvidia.com>
Date: Tue, 18 Nov 2025 15:04:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
 robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-5-sumitg@nvidia.com> <aRW5dhyN5/JF3F3i@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <aRW5dhyN5/JF3F3i@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::10) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 248bb49d-5785-47c5-fa00-08de2685c23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHV6emlTTmN1MGp5U0pUUGJGUGVFOWtJYW1PZXU4MjZBdkd6WTlsTjc4bnFG?=
 =?utf-8?B?ZDJabFFpcXIyc08xT25nMnVLTmdlcE83ZTNmSFExRlR1RVV0Ky9rYUkreXps?=
 =?utf-8?B?WFFKMlVMZHdESTNCOHBFVWVoM2d2YjUxemV6aGVnT3hqZXBXYW4yTDEyM2x0?=
 =?utf-8?B?angvNmhoZVRObU85MW5TR1duTmdkUlNsNzhHemhSNlVWWDdoK3FUamhrTXlu?=
 =?utf-8?B?a3pFcCtLaSt2T0xvYnBCK1hMdWozTUdlWG5xanFJdS9JL05HdTlxeEpFdEVR?=
 =?utf-8?B?N0E2UlJrTzlCaFdoYXVSdTNxR1RLK0hNenJDSTdzYkFKcXVKelNaV2tnT0xh?=
 =?utf-8?B?SEMrTWFnRUVUTUQza1NHNngrd3R6ZjBxcFl2VHBkdVBMMG5pMnFuTEV1NUsx?=
 =?utf-8?B?alRtR1F5UXp6TDVSWTJzZWhNZDNvQldFN3NURGx2RzF3UmxqZHJjYXFLRW1R?=
 =?utf-8?B?Znk5ZUxpZzVodUJvNkRaeWFseXdKUzl0WGdkMFJMSnNSdnF1S0lCeGxBU3NP?=
 =?utf-8?B?TVU4SGVNM1JkZ1I0dEhoNGY0RVpuenpMWWRnbSt3STRPRjRGbmhkSW1ybVl6?=
 =?utf-8?B?SDQyNkp5SFpNbW1YU2pXcXJQNFhCUlFlcUo3RDJkU0phZC9FbU9QdElBSHpz?=
 =?utf-8?B?cjVUWWFmQmpDVEZtaU1RbXdRUXlMYk5kUkNCYjNRdnVaRE0xRzNwUW51RUgz?=
 =?utf-8?B?MUJBYUVKMmtpWWtoSTZwZXpFaE1zeHBuaHpNZXZ4aTFoZitBNE8zRUFtaDNr?=
 =?utf-8?B?ZWwzM3pKMWlXRHNDdEQzTE5OZjZiL3VGMkZZWUNHOG9VRndQVGg0dWNSNWU5?=
 =?utf-8?B?V08zMlBqRHorQ1ZQOWE3M2tJMXVNcjAyNlk2d2FidExpcW9nL3hBM2Q0em15?=
 =?utf-8?B?S2VTS2FJdGdqMUlCYWRkVytYMEQxeVFkRUVEMnJaanc1d3QxdmZyK2kvbkta?=
 =?utf-8?B?bW96eTV4dmVRV3A0NWtraXBTS3EvUXRHdVZIRnF3d0RuZUxlSitLNm94cERl?=
 =?utf-8?B?UWgrUko1b1Y4cW9IMjZlcElXWEQ3K2pydG1Td0c2V3lxZDhxUFdHdW5EZDRp?=
 =?utf-8?B?aGZ0RjhKcVh3elFZVkpKU3JJWTRSaStoeHU2a2VpVW9VZ1FlSEtrRGtaemlC?=
 =?utf-8?B?SGNFbkhjSUQ0eCtja3ZRbDJXL2ZiSHhvOVhmMElPWUZFUjBvTjdIeTV0a3dj?=
 =?utf-8?B?K1FVYm5yUys5S1dPZzlXeko5RG1pWk92cGJhdmVIVnlOeGVEdEtlbmFGZzFh?=
 =?utf-8?B?VHJ5OGRMdGRkSnBmQ1JrYWF2QVZkRXUyK09zL0JqbXNEeTBvRFdkejF4U2gz?=
 =?utf-8?B?SzBmKy9DaDVNYzVTdzBFblhsMzVyS2F5U1hncUozK0xpcjhhcWhyNnFQcGxa?=
 =?utf-8?B?QTZjdm9tSFZDZFdBYzFMd08vM3B1dERkRkxJbEZJR2dTaWQyanRnbnNkOEVZ?=
 =?utf-8?B?MVJMbWRtTVJjOW8zb2tTaUhOdjZOMzNTS2l0MkdwUmlLck1jbmdvTW43UTEz?=
 =?utf-8?B?eDVQVnZpTFZsSXVUOS8yRGN4bXFQdjBrY2tsVzkwUnQzUTM2bXFJVkVIb2dS?=
 =?utf-8?B?QzU5WGZLNmVmak9wcExSd2k0bnRxRlBoZE51NFUvWjlGNVU4cjBjK3pJalgx?=
 =?utf-8?B?Mm95bHZ3OTNPSjlqQ0FDcjJBeXpqZ1lxRUxDKzJRaXBIb1hqZUYrY1FZZ1RH?=
 =?utf-8?B?UzcvTCtiTjdPR2FhamY0YzBJMFBiMlE3c3c5c2Z4SnVybzZwUjdqaUVzZERZ?=
 =?utf-8?B?MVlaU1NtOGFuTXNGa1V4bkVXVGpoQkJEQXYra3JURno3NzdrNlZNYko5UHJJ?=
 =?utf-8?B?NHNpZUtQSlczcDdwZ0UxY2k2OGtWS1FORmJzakNWWGtHbzFrMGREU2l3ZVBv?=
 =?utf-8?B?Z1p3Rzd0OXVHTXVFdzJKQWZSR1V2MHhWTTJWTmhZUy9HVnV4SG11NGRiSzg4?=
 =?utf-8?B?bFdZa2w4UUhzT2liK2p5ZFkzcjMyUUZCNzNDbFNyYTJUc0ErdGZncTVPaG9l?=
 =?utf-8?B?RG8wUitUSk9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUpxQ3hOazJ2c0ZyUVlGSHhtWWpJV0gyUXlDZkMzbzMyazkvNFNHb1pkVEEw?=
 =?utf-8?B?S24xS2NhV2tpWWVzNkZwaVBnWmpXT050UjFZb2xMSlJZZ2ZWOVhkL2xMeHp4?=
 =?utf-8?B?eWxlQ3dUNTJGMmowbG1Hek1SaUk3b0h6b0lpTXV4MjBiRDZTVHlPR2lLS0sr?=
 =?utf-8?B?VDRsQlpBcGlnL3VIN21uUGw3NGpzYzQ1K2FtY0IyNFJJRzV3TS8xN1NUYVVt?=
 =?utf-8?B?RlhjckNhU0RLWkVTaTVjL1JzWlUwUk5PZnpFVmZqOThoQjUwZk13UWdJQklm?=
 =?utf-8?B?V3kzWlBrSW1DTktmUzZ4enZ2cUtvVSsrUVNNZjFlSzl6S3NoY0N1QjBCS2hl?=
 =?utf-8?B?Z0pEYWlSTjJQc0p4cGQxR1NuemtJMjJERVhJK1Q2YnF0UTdLZXYvdW8xd004?=
 =?utf-8?B?VWp0V0VQeEV0K2QxYmtuWXBOQVJwQTVlYVhPczdjZFdnMmd0cVdzY2tJdTho?=
 =?utf-8?B?b0Znb0hzNmwzR3Z5Tzl5Mjl3Y0VpWDF4QTlFMHc5eGpnbThqNm5kVWpORVFM?=
 =?utf-8?B?bFhhTzZFeVBSQ1lPY2hmbDVwMHhXenIyUmxxRDBxM250eG8wVHkyY3JMaVlY?=
 =?utf-8?B?NHF4V21zQm9TU1hCbWY4S3cyQ1NzM1ZyWTM2VERDSTNQRlh2WnlSZ2Mxc0Ro?=
 =?utf-8?B?SzhaZUtqUEIzbnJ4a09MRGh4WlZQVU5aN2hhWEhjN1lSZWRqcUI3dG9wTW9k?=
 =?utf-8?B?SHc4NGd5bUZBZjZpYnNSa21XWXR4V092SXpta0h5bjNoUDdwV2RMT09MYkl5?=
 =?utf-8?B?S05RWm5JK1dJckYzK2NWL2ZyWHp6NFZkUCtEbFpRcnhxdTkydUZnOTYwV1hn?=
 =?utf-8?B?VVB1NXNJYm44cytqd3VJZXBtVlBmalM4NDc5Y01pdEp2RWNIeUdLcGVrWG9V?=
 =?utf-8?B?YnZhbjBvQkN2eU5BeHRLRGhMOWlpWis4NDJUdUs1RnpzbG1Md0VUNGFLOElR?=
 =?utf-8?B?aW85K3JHdVNEU2dPSEkvbkY4Lytqbm9BSGhuTXdYdklibzMxQ1ZNbmdtT2FS?=
 =?utf-8?B?ZVFLVlNpanBWUndqZkh2QzVpM1JJQUFtUGZhVFdwUFVKaE16VlpaZlBvK0da?=
 =?utf-8?B?dTh3TFBWcGVMeHUyK0ltNG9OUHlwUmdKSTJzSkNyR2haMEpWMXZNa1Y2YkxR?=
 =?utf-8?B?WkN6N2c5RituTkM4d1luLzlVbUhOVEU2Qy9HRnZMRlpFY2xZM095VzlhUnl1?=
 =?utf-8?B?Nk5uZmx0YXN3WWlJUGw2WnNiYUhzZXhNZFVNaTdWaC9XSko1RGRJY09YaWpT?=
 =?utf-8?B?RE96aDVla1h5TzB4SDNDdlFnWFVvWWdtdVhYaG92bkFZQ2lpTElPbjMyMkY0?=
 =?utf-8?B?YkpHZ2ZFd1ByNEpGL1ZUdW8ydFZkNlQ2ODhjancxbWZiT254Q2pvMkdpbmRL?=
 =?utf-8?B?QmJzbWZBZU9ZdVNuVGpLVE9RNDlpUm9ITGVvQ3ZKc0FITzVXcUh3ZjJNaHZZ?=
 =?utf-8?B?UXZGQmVVaDBteUFkUTl4dmFGdVgxRkhCbVNuWGkxZ3p5OUxWVmw1aklsdmZa?=
 =?utf-8?B?V042c0F0UkJ3Mkw5cXZGOXBJTGVaM3RFMDZXaUxUVE1mWnNubWpPUDYxNnF4?=
 =?utf-8?B?ZWRvQ0ZEV2VkRHl6RUpzc0JmWkF4bWdaQmhsQk50RTg1NnBFcFNLUE5KMTV3?=
 =?utf-8?B?QWV3VlJKOG1qTVg4bzhXOTErWjAyVEhvVThoSGJXV1o2V3M1UkRrQndnTkZT?=
 =?utf-8?B?ZlAvbDNmTm1LSldVWmRJMkVabnFkSDZZREI1MkhSNjI0bjUwczNSemF0dHZP?=
 =?utf-8?B?cXVuNG1rNlV3SHhCZTltMEg5STUwL1VLOXE3RnVKQjlwSVRxQ1JhcGF6Sm9n?=
 =?utf-8?B?NUk5N3djS1hSWlI1ZWlLOW5kK2hvWkE2aUhYNDB4WW95bTVhZVBkdktLdS9j?=
 =?utf-8?B?WG5oMzhPMXgxYVd4NWRsUXdlU09QcFZaTmhtYUJpS2VZTUhHY1lPWGFoL0xt?=
 =?utf-8?B?emxQQ3pNNkdkM2FRaHROc1ZVYWprTUxTN05iNUlsMjdaSWc0aVk3YURFeWlM?=
 =?utf-8?B?VlFaY3VlK2hYaUVidWY3ZmFrZm9CQllncTQ5VlZyb01XeTdXSWI4L0tpNjd3?=
 =?utf-8?B?eitQcmZCVnNYdE9zMk02WkxZMmtWSmlwY2pVTzdoVnhNSkpRM3RKQ3N6QzdC?=
 =?utf-8?Q?LcV5ZCm9Xpd6md4HcskLpJeNj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248bb49d-5785-47c5-fa00-08de2685c23b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:35:06.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLhhvycRmuAseFUzwAyxz4hp4MtR9lwLxhiKcFmgSgZdk2AkpdIHQZulal63RjunWAbYWaZTS3uywXM4id2Bpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273


On 13/11/25 16:26, Ionela Voinescu wrote:
> External email: Use caution opening links or attachments
>
>
> Hi,
>
> On Wednesday 05 Nov 2025 at 17:08:40 (+0530), Sumit Gupta wrote:
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
>> Expose these capabilities through cpufreq sysfs attributes that accept
>> frequency values in kHz (which are converted to/from performance values
>> internally):
>> - /sys/.../cpufreq/policy*/min_perf: Read/write min perf as freq (kHz)
>> - /sys/.../cpufreq/policy*/max_perf: Read/write max perf as freq (kHz)
>>
> There's a theoretical problem here for CPUFREQ_SHARED_TYPE_ANY, when
> multiple CPUs share a policy, but that existed before your
> patches :). Almost all of the files exposed by cppc_cpufreq should be
> per-CPU and not per policy: auto_select, energy_performance_preference,
> etc., and now min_perf, max_perf and perf_limited.
>
> In practice it's likely not a problem as all CPUs that have P-State
> dependencies would likely share all of these controls. But that's not
> mandated by the ACPI specification.

Will send a separate patch as improvement for the existing code.

>> The frequency-based interface provides a user-friendly abstraction which
>> is similar to other cpufreq sysfs interfaces, while the driver handles
>> conversion to hardware performance values.
>>
>> Also update EPP constants for better clarity:
>> - Rename CPPC_ENERGY_PERF_MAX to CPPC_EPP_ENERGY_EFFICIENCY_PREF
>> - Add CPPC_EPP_PERFORMANCE_PREF for the performance-oriented setting
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
......
>> +/**
>> + * store_max_perf - Set maximum performance from frequency (kHz)
>> + *
>> + * Converts the user-provided frequency (kHz) to a performance value
>> + * and writes it to the MAX_PERF register.
>> + */
>> +static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int freq_khz;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 0, &freq_khz);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Convert frequency (kHz) to performance value */
>> +     perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>> +
>> +     ret = cppc_cpufreq_set_max_perf(policy, perf, true, cpu_data->perf_caps.auto_sel);
> Can you give me some details around updating the policy limits when
> auto-select is true? I suppose if P-state selection is autonomous, the
> policy limits should not matter, right?
>
> Thanks,
> Ionela.


Yes, the cpufreq sw policy limits don't matter to hw in autonomous mode.
This is done to notify the cpufreq framework and keep sw policy limits in
sync with the new limits in HW. This was raised by Pierre also in [1] about
cpufreq not being notified after user modifies the HW limits.

[1] 
https://lore.kernel.org/lkml/b2bd3258-51bd-462a-ae29-71f1d6f823f3@nvidia.com/

Thank you,
Sumit Gupta


