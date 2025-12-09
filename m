Return-Path: <linux-acpi+bounces-19521-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C637CB09CE
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2605830A5E80
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C052FFDC9;
	Tue,  9 Dec 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGUTpHUB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B316327C1F;
	Tue,  9 Dec 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765298318; cv=fail; b=VuTom4kGjKpqfJ9FYQ7rSaDfd+aY6o2iBOKSmgF8Sm998kgheEMmviI9mPk2EIYNtSihAI1+X9NAT9V7ZsYk7D+M+PO+UEqtTXjaYXUWbE2zGDckRcqZJvtRDHCnb0R3TArIXModumRa3lY0MV8eIa+Mg8jgBsNggdE8jlO+fXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765298318; c=relaxed/simple;
	bh=OP0cyqq76pVvfR2I53qWCPVgwLJHpwnX2OXY1kcEmh8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tjVbypqgztMXrgNCG7sKRZFfhdmeZZK9gWRfUfdEiD2/QjmCRKpEzfv7IDHA7yIxlBIzyoeYYLvdO1f4COROGrwW+Ne0sptGIyPJLLwTta+f01tr6B437G1XcXFESEllIMN/Jsy00Mq269N+9rRjG72cx88gPjiWDw6po4KZOPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jGUTpHUB; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZV5wZ0AxmxHSXEwSwBshSENJII4wfc9EL6/T/qjWmtQ8wqY9RLkJG2iQe6SFPA7cgfN6nn4X0tXkbrK/1zk5Ilv+D3yHRJDcjkfB0WfSikyPxP5+TIyLyJA+JuuAPO1TRkT9jy52t1hsKAKcs6LWQmI9UqlbozQpBH89e2DggVxUJASNriSk/kLw7RRfJc64FhSQ/t32ra66Jrhzj0hqcyc5tMKjkWD1Cbu0gabclOnSQlTGjgFbHKShN5i9v3LE0Uf6YFosKGBalDGwOJPbrFu0eeUGX1ZQiTT0G+7dLsJpRuf1GokvX1fDSNrA7BzOlc7DYdZ5yRbfCre/mxcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsLzCUbN60f49T3wQ+8firvnbmrtXmq32CSJGRJ2uCQ=;
 b=bZzszdTQ7pCnNHj1u2VA1DdPOxdPXIJ5w7ELYb8Qhm1EyuIieuwU9rMxnl90YY9tGE10Hq33UN0mEApYUMkXQq2KFHmlIgMlJ5whEnBWX5Q2JuqmX6XyP8mmIlNqJIi/aKlNclui9qWfTOoXJGqcNYwQ/WtlDXeOvez9AyqUPCqoOL46DdzJcqs14JtSp7N35JVWH1g6TTKLDUVKn/fMk8k5k33Va7Lb/CXcTESRlUE1/3BqyWE/SirB/feCVJzMsxAz5GpBkYYuU1zngZ0kadjA78mui8VDKwPo8mACnuprw0FQpGmgThox2gzpXF/XwAJDIiCOFHfuiGya05O+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsLzCUbN60f49T3wQ+8firvnbmrtXmq32CSJGRJ2uCQ=;
 b=jGUTpHUBVf2bM5d8QlBzxkovhCpi8dXY32SPV85pXopNMjdU9Bay2qSYon4HOsFqFI+G/34Gc+x2EulzzludoPx56c3xTD8BmKKSuO1GeF/5yEsBaansvI/agybbUo+1eB4mNuitC/qT4YqNkfZsukqCtWzF44pMLX0W6nzRAGC0DLM10BdqzCUGLILQQvvOaLU0nDoZkQ6AaW3eNlBRPHsjKnraYW+ugUzF5IUrwrbAysRqAFSXR5dxfs41bCGmpon6LGFj6IRWUzd6iDMPBBuVtCspyB0vrUi44LLy8q+H+cksYcn3hJBu7X1yBG16BaNlzd50g0JP2msXTyhgVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 9 Dec
 2025 16:38:30 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 16:38:30 +0000
Message-ID: <019bbcd9-7bbc-45bb-9c05-f59a4c90c26e@nvidia.com>
Date: Tue, 9 Dec 2025 22:08:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, zhanjie9@hisilicon.com, ionela.voinescu@arm.com,
 perry.yuan@amd.com, mario.limonciello@amd.com, gautham.shenoy@amd.com,
 rdunlap@infradead.org, zhenglifeng1@huawei.com, corbet@lwn.net,
 robert.moore@intel.com, lenb@kernel.org, viresh.kumar@linaro.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, rafael@kernel.org, ray.huang@amd.com,
 sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-5-sumitg@nvidia.com>
 <23baedfe-176a-42fd-9e5c-c8ad78107708@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <23baedfe-176a-42fd-9e5c-c8ad78107708@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::12) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4d20b6-0c2a-48d3-2162-08de3741628c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHNyem9GUm1CaXA3eFpDdmZaaFArRGsyNkY4WE92NU9tZUxSaHViYmM1UUxP?=
 =?utf-8?B?U0M2TkdpL3RUdzc4eGJSWHJTODIvazloQkoyTFZtZTU1c2pUWVFmR3BzdjRL?=
 =?utf-8?B?SGxBajJZT1BMOVdJL3pWaHcvUTdpNWQwaW11SThDSWVFL0lUZjZQSERVZkl1?=
 =?utf-8?B?NWNlYmJhUDVPUVpVL3lNdG13VE1aM0RSaGhoNFhaOXdpYnl2M1czQUl3ckJZ?=
 =?utf-8?B?OW5iSEp2dWxGWVZVenZoa0FJRUdJYXJ3S0hJYjZqSUVXWG9QRS9iRmpwRFpt?=
 =?utf-8?B?amJZRjI4eUVESithV0pZbzNkdy85ek5EYWQxRGVxT042alJTM3BLdU84QmNC?=
 =?utf-8?B?bWd6S2c2cXlydDBpL2I2TTZVWWI5Y3RBK3lZcmhUclltbm11N2ZqVkc5T0VN?=
 =?utf-8?B?a0pIanNPYkpON3ViRnhOUmhpN015VUl3akhWdUlVa0o1c2Z1anRtaFNTRXJK?=
 =?utf-8?B?SCtCalQ4cTErVnhMSlBJVzRmKy9xbGYzNlJiSTk3T1MxVXFzUmY1bjlkOGd6?=
 =?utf-8?B?cUNqc3cyZHJyQUJXVG12ZVdWc2gwSFpzd2pOOXVtcWQyZ1Q1djNtcmpwZE5z?=
 =?utf-8?B?VC9URUYyd0hwZytNVUR5QllLOEt6Smd5dnZ0enhoQXU1UTBTZi9vRkgwREZy?=
 =?utf-8?B?bnN1dU5TcnFaODVZc3luQ2NxbWNHR1VFSXJjd2NpT0dOeFhQMVowbWJXY1E1?=
 =?utf-8?B?M01IMHlXcUh2OVR5OHlaWmdWODR1a0Y5SytJY0d3MWxOck5UdHpkZE14bGJ2?=
 =?utf-8?B?bmlYb2VEallrSllyVy8xK3FFcDdVYlNRUEVzUTRtbVVjclN5VHZoc3VDUWVt?=
 =?utf-8?B?RzA2VmppTHJOaFY0SXlBUXlDLzBBaUN6STBxRGRTQkhJeUtlTjdKVExYcmFV?=
 =?utf-8?B?WHBwbnRGMlVsQzE5SVhHaHBXZE1DTEMrOWp6cU5aM0RIU0xaQTFYRkNFdEht?=
 =?utf-8?B?QVlST1ZWZDhkdENBNzhtaGoxZFFpdktBRkF4Vndpc1RXYWxXK0hraGVpQnVk?=
 =?utf-8?B?THNyY3p0bW53S2ZRSDRENVU4YXNRWFVNbGtrR1Y3eFNkRitMUFhnVEN0WEEv?=
 =?utf-8?B?OE5sblRuemRIeWFSNjJqWC8zWnhrNVB4S01KRnEvSnRCS0N4VkNaa2x4SmMy?=
 =?utf-8?B?NFdyQkFISUFONDNmcHkyT2MzYzcrUnF0eUVGVk9xM3YweG5pMUxoUHBvVTFl?=
 =?utf-8?B?UU04TEFnS1RZV0MvaEZtK0JSMDZZcjc5RHpjNXVGTDExdHU3bkNLMzBXTlRP?=
 =?utf-8?B?VitQd1hhaUtsbzNmb09uSENkamR3TC9FZVN3dzMzOVRNOVlqMXFucDlmaGx5?=
 =?utf-8?B?ekQ0UHlzVjdYbzlyOTlKeGVTdlk0TEZlYjM5cForUTM3Sjg0ZGdPdU5OTDlo?=
 =?utf-8?B?T2w4ekN0RFRuT1RqK05tWDlFWlJrTSs5RVJFa3ZQcngyTHNGemgzckQrbXo4?=
 =?utf-8?B?U2Y3ZG55dEx5S3djNHJwZ1Y1YUpESC9LaFVEVk43Wm1Ea1Y1OTBiNEhGYkt6?=
 =?utf-8?B?aUNGd0RIRS9VeVlmYUpCV2h3MWs5N01wTWpnWVN6bDhwSDBwRXljN2tsRkhC?=
 =?utf-8?B?amlJdUVJM0RwSXgyb1M0RnhUay9HTUQ1NzdSMkFRVG9FUEQxQWxEbnlRZkdK?=
 =?utf-8?B?aXhvVWtqbUZneWdueEZWVEE1ZlRsZ0YyczFZcnBzVjFvK3NrRG83NFRPMTNI?=
 =?utf-8?B?bHNnYkwrQko1dXpiZFR4OVEwS2l4QTUzZ2xQVjVUKzB6RXNPWVlraXh4dDBQ?=
 =?utf-8?B?WG9lMEFiVDNJZmJCcWtZVkg0ZWF5bklzVXN2WkpRTE56elZHYUxlM0JnODJL?=
 =?utf-8?B?bTl6dmpkMVU3b1M1eFNrcEQ1U3pxSDgzNW5OdndacUFicUNpc2JEdVdwaUE5?=
 =?utf-8?B?b1QySm9YQlAxOG5iRlY1YUJ4d3FuREVRYllCRVdPajJsRkx4MnFBMDI1Y2tR?=
 =?utf-8?B?NDZWQVRiYWVzR0t5SkUyWEdrem5ZcmdybzBwamw5VWsrblA4d1EvbDMyZ1Iz?=
 =?utf-8?B?Nlk1SlBucm93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2t1STZwcE9GRWxFS3EwbGU4ZXR6cjRIWTdjWlV6NFJNU0k5eW5acFlhM2NX?=
 =?utf-8?B?cGtZZFVodWpmbjQ0SjhFVUNLNDRxVWVyZCs0bVZoaGllUDZ3eGdFSHZUNjU2?=
 =?utf-8?B?SUNHWUhIYjZHcGx3VERBLzlMc01PcmV4aS9kUGlCM0E1N1VLajB2bHJlaVdR?=
 =?utf-8?B?aXorbG5TcWVRaEIvUm5UVkw4UlF3M2poMGcwQlhKOUxCMWJVOU4vMFozZEZP?=
 =?utf-8?B?VFF2RHdnYnBpOGtpc0pEY0NzcW9LSEpoTThoT1ZOSlpEUHF6S0kveWZiVzhB?=
 =?utf-8?B?N2hpeXFXZmx5K0tWQ0tzTSthL05Ob3dCaHVNTm9Gc3dBSjYyeWhCMTU3Y0Fw?=
 =?utf-8?B?M0N1Szc3ME1Rd09BWUE4dGw0c2hNLzlmMHFoZUpFeFUzSjlkcHlaRUoyU21P?=
 =?utf-8?B?QUdLVldwdTZpUGtLNlVYalNFSmI3NUtDbHFvVzNFZERPMlRvbUZRcHpVaVd5?=
 =?utf-8?B?OGtLYXV4NVNOS2xTV2NjZEZFaU1mRXZrTUpNV1N5Z1FlVWk1bU5CdHVxTnVV?=
 =?utf-8?B?V1Faekl3NzR3eDZ4T2NKTjMyZy9veHZkNEhDbHlMODJVdXpUQnJGMEhvU1Bl?=
 =?utf-8?B?d1l1SnJKajRvTTkzeUMwazdLOFcwbGlHejJYYWU3NEI4NXBFb2NRdE1hdXFT?=
 =?utf-8?B?N28wMFpDcEpZc29YTWZ1NW14WVNITjY4MU96UW8zRHQ2cytWak5iS012WDd4?=
 =?utf-8?B?bGZsN0ZTTEhHNnR6QzJUMXFScHdiWm1vZ3BTa29QczNaYWFKc3JLNEcwTjh5?=
 =?utf-8?B?QjVvWUp3QlNTS3hEMVE0bThPUk5Rd1U1ZEZWT09hdUMrSEhmUkZyYmJFZVdJ?=
 =?utf-8?B?b3ZuRTNxMVdKb25qWWdzSFIrbms4Z1R6NFZraWdHdVI0bkw4cGZyYWJWRUpX?=
 =?utf-8?B?L0t2Y3V1eithUEhpZUpRVGczanJhaWYvUXRiWTFrSWo5U0h3ejJ3amtwTkRz?=
 =?utf-8?B?Q1czNGIvQ01wR1ZwcTNNdTNJMDlIN3JmaVFVNGNHSVJBSndRZk5qR1J2eE8z?=
 =?utf-8?B?Rnd0aFliTEcxbys3Z21mNFpmU0w5Q3JqVWJ3bkJMQnBKazFtSk5QZldjcWNG?=
 =?utf-8?B?MmhrWi9paWlOWmFkbzRQcUJWQkZBR0ZuSlJ4Q2ErekZicTBkNUxYRW5CNHV4?=
 =?utf-8?B?eDZycWJFRVl3NlZFNnB3bW5VVm41Z0Jrb0YyYm9VUE9TUkwvTFNnZ3Q4Y3cv?=
 =?utf-8?B?NDJZdld3Nk5ZRzF4OUNzU0xsNmFXN21SNGxXSEJ1RGQ4TTk4S0t1K25HNmRJ?=
 =?utf-8?B?VTNPQzZCL08yd1VWZVVxL010bzJUQ0RLQ29NZWhwdmRadG1jL3VOR0FtSE5r?=
 =?utf-8?B?K2k5OVhFdnhGUTlsOXVha3o4K2dnemEya1pDdVFxektHK01oZzZRLzRGYzNt?=
 =?utf-8?B?SFhOd0FTZ3BZaG9uakRvTnVJYTc2Y25DQmE5azhlYjlSbEhqSGpuclBqL0xm?=
 =?utf-8?B?TkRyS2lxbmo5VzVwUDlQZkpPc1B5cWJJclI3OWlVd1hoTmsrWXdtRHRXZ3pz?=
 =?utf-8?B?eVJQK29xRXVQS08rOEJVYll0YVZSM1VsMkFFclRFN0NMT1ZocHg4allTRkNi?=
 =?utf-8?B?WkRYYUFOelIxTVY4cXBDMlNRVTIzbkwvSk1JbFNWZmpwMXFHT2VmeDJVRW5B?=
 =?utf-8?B?Y3dXanNXc1dIMG5VMFZlak1jRDJOaldFT0lhMnRWaWppMGtPdVM3dVJON1Qv?=
 =?utf-8?B?SEdUem84dnhmc09vbDdJbm80UmgyM3c1OW1pM2VLQ0NYeFN1WGtYTk1hK3Mx?=
 =?utf-8?B?MWxFVWJoWEZLalo3MDMyMmpJQk4wUXRJRER4T3RvTkdHZWE2Q010c29tQklJ?=
 =?utf-8?B?aGhxUkdiS1RRUnN2M2hDS0NuMnlUN3I4bFkvTkJhY1E0TzlXc1ZzN25RRjJt?=
 =?utf-8?B?d3dYcDdxa0NadXBMR2VITTlsdWFHTXkxSTZxb3NtbC9heFFZMWI3MEhiY0xO?=
 =?utf-8?B?R0pZUzhidXBXQ2E4dXRXS1d4ekwvMEU3OEFzVUEvY1NnamQ0Um43M3gxSFVF?=
 =?utf-8?B?Q0g5b3lXUTNOem00aE5vNnJ5NkpnWnNXcks5eEo2RnQrY3hXb0tzejY2VzZT?=
 =?utf-8?B?MlV1YU9UNll3Tmp1T080UHdNNFR4T3FpRWNmWjFMVWZjbDlBSFNyMEo2TElI?=
 =?utf-8?Q?SZrCK8kRcq9jYjcR0wz6cMcKE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4d20b6-0c2a-48d3-2162-08de3741628c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 16:38:30.4166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJBD4fZ8jeuCpuzEi1iZCGr5gqdsegNqNi8reNQPmZ2E2YcBh7eWzNIqfzF8GLBEEHHfioykSAfqxIhLBh8Mqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188


On 27/11/25 20:24, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> On 11/5/25 12:38, Sumit Gupta wrote:
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
>> The frequency-based interface provides a user-friendly abstraction which
>> is similar to other cpufreq sysfs interfaces, while the driver handles
>> conversion to hardware performance values.
>>
>> Also update EPP constants for better clarity:
>> - Rename CPPC_ENERGY_PERF_MAX to CPPC_EPP_ENERGY_EFFICIENCY_PREF
>> - Add CPPC_EPP_PERFORMANCE_PREF for the performance-oriented setting
>>
>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       |  55 ++++++++++-
>>   drivers/cpufreq/cppc_cpufreq.c | 166 +++++++++++++++++++++++++++++++++
>>   include/acpi/cppc_acpi.h       |  23 ++++-
>>   3 files changed, 242 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 757e8ce87e9b..ef53eb8a1feb 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1634,7 +1634,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>>    */
>>   int cppc_set_epp(int cpu, u64 epp_val)
>>   {
>> -     if (epp_val > CPPC_ENERGY_PERF_MAX)
>> +     if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
>>               return -EINVAL;
>>
>>       return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
>> @@ -1757,6 +1757,59 @@ int cppc_set_enable(int cpu, bool enable)
>>       return cppc_set_reg_val(cpu, ENABLE, enable);
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_enable);
>> +
>> +/**
>> + * cppc_get_min_perf - Get the min performance register value.
>> + * @cpu: CPU from which to get min performance.
>> + * @min_perf: Return address.
>> + *
>> + * Return: 0 for success, -EIO on register access failure, 
>> -EOPNOTSUPP if not supported.
>> + */
>> +int cppc_get_min_perf(int cpu, u64 *min_perf)
>> +{
>> +     return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_min_perf);
>> +
>> +/**
>> + * cppc_set_min_perf() - Write the min performance register.
>> + * @cpu: CPU on which to write register.
>> + * @min_perf: Value to write to the MIN_PERF register.
>> + *
>> + * Return: 0 for success, -EIO otherwise.
>> + */
>> +int cppc_set_min_perf(int cpu, u64 min_perf)
>> +{
>> +     return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_min_perf);
>> +
>> +/**
>> + * cppc_get_max_perf - Get the max performance register value.
>> + * @cpu: CPU from which to get max performance.
>> + * @max_perf: Return address.
>> + *
>> + * Return: 0 for success, -EIO on register access failure, 
>> -EOPNOTSUPP if not supported.
>> + */
>> +int cppc_get_max_perf(int cpu, u64 *max_perf)
>> +{
>> +     return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_max_perf);
>> +
>> +/**
>> + * cppc_set_max_perf() - Write the max performance register.
>> + * @cpu: CPU on which to write register.
>> + * @max_perf: Value to write to the MAX_PERF register.
>> + *
>> + * Return: 0 for success, -EIO otherwise.
>> + */
>> +int cppc_set_max_perf(int cpu, u64 max_perf)
>> +{
>> +     return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>> +
>>   /**
>>    * cppc_get_perf - Get a CPU's performance controls.
>>    * @cpu: CPU for which to get performance controls.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index cf3ed6489a4f..cde6202e9c51 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -23,10 +23,12 @@
>>   #include <uapi/linux/sched/types.h>
>>
>>   #include <linux/unaligned.h>
>> +#include <linux/cleanup.h>
>>
>>   #include <acpi/cppc_acpi.h>
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>> +static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
>>
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>> @@ -582,6 +584,68 @@ static void cppc_cpufreq_put_cpu_data(struct 
>> cpufreq_policy *policy)
>>       policy->driver_data = NULL;
>>   }
>>
>> +/**
>> + * cppc_cpufreq_set_mperf_limit - Generic function to set min/max 
>> performance limit
>> + * @policy: cpufreq policy
>> + * @val: performance value to set
>> + * @update_reg: whether to update hardware register
>
> I m not sure I see in which case we might not want to update the
> hardware register.
> Isn't the min/max_perf values relevant even when autonomous selection is
> disabled/absent ?
>

Explained in reply on 'patch 7/8'. Adding here also brief info.
When disabling auto_sel, only the policy limits are reset, the
min/max_perf registers are preserved.
When re-enabled, these preserved values are restored to both
hardware reg and policy.

>
>> + * @update_policy: whether to update policy constraints
>> + * @is_min: true for min_perf, false for max_perf
>> + */
>> +static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy 
>> *policy, u64 val,
>> +                                     bool update_reg, bool 
>> update_policy, bool is_min)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     unsigned int cpu = policy->cpu;
>> +     struct freq_qos_request *req;
>> +     unsigned int freq;
>> +     u32 perf;
>> +     int ret;
>> +
>> +     perf = clamp(val, caps->lowest_perf, caps->highest_perf);
>> +     freq = cppc_perf_to_khz(caps, perf);
>> +
>> +     pr_debug("cpu%d, %s_perf:%llu, update_reg:%d, 
>> update_policy:%d\n", cpu,
>> +              is_min ? "min" : "max", (u64)perf, update_reg, 
>> update_policy);
>> +
>> + guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
>> +
>> +     if (update_reg) {
>> +             ret = is_min ? cppc_set_min_perf(cpu, perf) : 
>> cppc_set_max_perf(cpu, perf);
>> +             if (ret) {
>> +                     if (ret != -EOPNOTSUPP)
>> +                             pr_warn("Failed to set %s_perf (%llu) 
>> on CPU%d (%d)\n",
>> +                                     is_min ? "min" : "max", 
>> (u64)perf, cpu, ret);
>> +                     return ret;
>> +             }
>> +
>> +             if (is_min)
>> +                     cpu_data->perf_ctrls.min_perf = perf;
>> +             else
>> +                     cpu_data->perf_ctrls.max_perf = perf;
>> +     }
>> +
>> +     if (update_policy) {
>> +             req = is_min ? policy->min_freq_req : 
>> policy->max_freq_req;
>> +
>> +             ret = freq_qos_update_request(req, freq);
>
> IIUC, we are adding a qos constraint to the min_freq_req or
> max_freq_req. However these constraints should match the
> scaling_min/max_freq sysfs interface. So doesn't it mean that if we set
> the 'max_perf', we are overwriting the the max_freq_req constraint ?
>
Yes.

> If you have frequencies between 600000:1200000 # Init state:
> max_perf:1200000 scaling_max_freq:1200000 # echo 10000000 > max_perf
> max_perf:1000000 scaling_max_freq:1000000 # echo 900000 >
> scaling_max_freq max_perf:1000000 scaling_max_freq:900000 # echo 1200000
> > scaling_max_freq max_perf:1000000 scaling_max_freq:1200000
>
> The 2 values are not in sync. Is it the desired behaviour ?
>
>

Making scaling_min/max_freq read-only in auto_sel mode will solve this.
We can do this by setting policy limits to min/max_perf bounds in
cppc_verify_policy() when the auto_sel is enabled.
In autonomous mode, the hardware controls performance within these
bounds, so scaling_min/max_freq is effectively read-only.
Users must use min_perf/max_perf sysfs to change limits.
Please share if you have different thoughts or another approach.

  cppc_verify_policy(struct cpufreq_policy_data *policy_data)
  {
     ...
     if (caps->auto_sel) {
       min_perf = cpu_data->perf_ctrls.min_perf ?: 
caps->lowest_nonlinear_perf;
       max_perf = cpu_data->perf_ctrls.max_perf ?: caps->nominal_perf;

       /* set min/max_perf bounds (read-only behavior) */
       policy_data->min = cppc_perf_to_khz(caps, min_perf);
       policy_data->max = cppc_perf_to_khz(caps, max_perf);
     } else {
       cpufreq_verify_within_limits(policy_data, min_freq, max_freq);
     }
     ....
  }


>> +             if (ret < 0) {
>> +                     pr_warn("Failed to update %s_freq constraint 
>> for CPU%d: %d\n",
>> +                             is_min ? "min" : "max", cpu, ret);
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +#define cppc_cpufreq_set_min_perf(policy, val, update_reg, 
>> update_policy) \
>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_reg, 
>> update_policy, true)
>> +
>> +#define cppc_cpufreq_set_max_perf(policy, val, update_reg, 
>> update_policy) \
>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_reg, 
>> update_policy, false)
>> +
>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   {
>>       unsigned int cpu = policy->cpu;
>> @@ -881,16 +945,118 @@ static ssize_t 
>> store_energy_performance_preference_val(struct cpufreq_policy *po
>>       return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_epp, 
>> buf, count);
>>   }
>>
>> +/**
>> + * show_min_perf - Show minimum performance as frequency (kHz)
>> + *
>> + * Reads the MIN_PERF register and converts the performance value to
>> + * frequency (kHz) for user-space consumption.
>> + */
>> +static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = cppc_get_min_perf(policy->cpu, &perf);
>> +     if (ret == -EOPNOTSUPP)
>> +             return sysfs_emit(buf, "<unsupported>\n");
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Convert performance to frequency (kHz) for user */
>> +     return sysfs_emit(buf, "%u\n", 
>> cppc_perf_to_khz(&cpu_data->perf_caps, perf));
>> +}
>> +
>> +/**
>> + * store_min_perf - Set minimum performance from frequency (kHz)
>> + *
>> + * Converts the user-provided frequency (kHz) to a performance value
>> + * and writes it to the MIN_PERF register.
>> + */
>> +static ssize_t store_min_perf(struct cpufreq_policy *policy, const 
>> char *buf, size_t count)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int freq_khz;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 0, &freq_khz);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Convert frequency (kHz) to performance value */
>> +     perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>> +
>> +     ret = cppc_cpufreq_set_min_perf(policy, perf, true, 
>> cpu_data->perf_caps.auto_sel);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +
>> +/**
>> + * show_max_perf - Show maximum performance as frequency (kHz)
>> + *
>> + * Reads the MAX_PERF register and converts the performance value to
>> + * frequency (kHz) for user-space consumption.
>> + */
>> +static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
>
> I think it might collide with the scaling_min/max_freq.
> I saw that you answered this point at:
> https://lore.kernel.org/lkml/b2bd3258-51bd-462a-ae29-71f1d6f823f3@nvidia.com/ 
>
>
> But I m not sure I understood why it is needed to have 2 interfaces.
> Would it be possible to explain it again ?

Separate interface for min/max_perf are kept because we are writing
to different CPPC hardware registers with that name.

>
> I don't see any case where we would like to make a distinction between:
> - scaling_max_freq, i.e. the maximal freq. the cpufreq driver is allowed
> to set
> - max_perf, i.e. the maximal perf. level the firmware will set
>
> ------------
>
> Another point is that the min/max_perf interface actually uses freq. 
> values.

Changed the min/max_perf interfaces from perf to freq to sync their scale
with other cpufreq sysfs interfaces after discussion in [1].

  [1] 
https://lore.kernel.org/lkml/80e16de0-63e4-4ead-9577-4ebba9b1a02d@nvidia.com/

Thank you,
Sumit Gupta



