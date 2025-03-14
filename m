Return-Path: <linux-acpi+bounces-12241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C62A611B7
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 13:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B2A462266
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 12:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71071FECBB;
	Fri, 14 Mar 2025 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mYEij1HZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1B1D540;
	Fri, 14 Mar 2025 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956549; cv=fail; b=K4hvF92sZsxrkUui4yVefY7seYFm+p8PQKecGDCKV4/dBiMaF+1+S1Il33zePJ171PiFXgmI1FyUTYL18/gDgWefSnHj7WNNKvM6jV+PTzvKgKSff+4qUNhHQ7QYh6hsJBH4j+gir7jHHFGfzTYCHLgK8JoYXsTNfrqTsjeJq5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956549; c=relaxed/simple;
	bh=puqvMiG75idIOYBTkmgIt+4Ls3uFSLl08VOLGq96OLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s1bsc9td70q8DlAPXQ0yXoKYzq6wmQ29MHUDPU1MmPnJ69DSsQXWt6eaNnVx06Hn2hb7HICsAgPJJRxWFf5UauCL8JmGVmTg+UmZaWM2xw55p9/EGNTeS8whSEX3EfYNI5Ka9hRKSAFJb+pF/j7DQHdF6u7J+JQrsuZvC+XFCOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mYEij1HZ; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLfohONFSUv2JtSeoK1/N3fZ5xqq/GalcKDqWjjenaXJ1EeHFNqct/w0Z2nlKpdRYaJDgp4YV7WiA3gZ3E5dTYzc9fBjbuoDnDWVsLaqKfdSRLlyH/IRjVxcgN9iIsU3mRqBkTDmFu4kiNcB3sXc12tpsAZoeQ46Q/lyCWJgjaRV7D5WKbG9vjm0/P3Vtfq9bKkE/oEmn6c+TyM+spzjgqcqcINBlsnqPjaelK1Z8QddbQOC/wz4reRu1OCdxcJr1+Td0xvbb427pCWgwNsmu1arnsvWe1lfnO7kX0nJ5CEI8HwA3J8aO1yUQEl9lhobzuPJ5R/qO/ai5yAA4ZgUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEpgSePhsSGels7y5Mo/72KS9S2ayRrJDqWmPYmf/ns=;
 b=AoTCcOI1K06IDfOUzkbWRPdpDdGSLxZw9MxQA7/UKdlyVxj1ogHIQ4aqEJUiN8ltmMD+ZuTlloJaY4owh5d3mU5FQx7kawAlCwzAaaEfTu4KIRJBsedhhq8YDbvViyWeRHCRFtjn307oHifAN22OBuU8auCZuP8dMxdRhbhAc5HWZ19oMbT3sIjR4wTtS+oE5Cs1l0LyUp7n5PnDIEuMsl/nj8tgCv+F4sJCXa/PgS3jlSLnuY97hxq6gWokkhRWyIytAbLWGabTu/D3bg5UNBeoHzDzyy8373e8hPBI+hnIE2MtZ3vvbBUJIyvJJLkB5DHlH6eSW3m6DM0+XB799g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEpgSePhsSGels7y5Mo/72KS9S2ayRrJDqWmPYmf/ns=;
 b=mYEij1HZCOYWtF+AiqYwnyO0zNZpkbJyOhEZla/rUHhwTLDgcerhBUCtSHtwulgmXf+foSaLZNYwIEoB/VHolM50ULKZZZ4A93f/jIYifBOTgBrt1ntIT18ZPws/nWZVZyx065r8nJUW68oufnR95+Qbba/qKYY9zxjFL4oY1p8SHdAJXD0/yO+jjJLOcJOLi7yjVIQVx7LPYfv+ZgKbomSd8DMHz1pSGafSFO3byTvUrfAalihn1/Z7M4xyXilOm1kt4AMouZJ+LR3FFAjZCEOsJ/zT7DXo59B796RB+EgZxpELoHnhO9xNkO3ec8Mf/f12h9uqApUxcbEsNw4S8A==
Received: from BL1PR13CA0439.namprd13.prod.outlook.com (2603:10b6:208:2c3::24)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 12:49:03 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::54) by BL1PR13CA0439.outlook.office365.com
 (2603:10b6:208:2c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Fri,
 14 Mar 2025 12:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 12:49:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Mar
 2025 05:48:52 -0700
Received: from [10.41.21.119] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Mar
 2025 05:48:46 -0700
Message-ID: <f0f1b31b-a0fc-4d21-8b79-c896833dae35@nvidia.com>
Date: Fri, 14 Mar 2025 18:18:43 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<sashal@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
 <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
 <b45d0d81-e4f7-474e-a146-0075a6145cc2@huawei.com>
 <868d4c2a-583a-4cbb-a572-d884090a7134@nvidia.com>
 <8d5e0035-d8fe-49ef-bda5-f5881ff96657@huawei.com>
 <94bdab73-adc4-4b43-9037-5639f23e3d1e@nvidia.com>
 <CAJZ5v0iAg6HFROHctYQwW=V9XiV8p3XVYgeKUcX4qBgfwQK6Ow@mail.gmail.com>
 <e58a20f8-e8bf-409c-a878-af2bd3c7d243@nvidia.com>
 <73fbf483-7afa-4cd2-84d1-6ace36549c53@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <73fbf483-7afa-4cd2-84d1-6ace36549c53@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f194a48-f3ec-4ef0-1d3d-08dd62f698f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnAxWS9MUkFuZE5VY0FrcC9Td2x0d3FKeUFLdGQzRTRmUmhCSDBQVWFoM0Ru?=
 =?utf-8?B?eWtsK0o5SFhtN2VxNS9UOE5UTWtKNWtoblgyOFJ6bEFRUlgrVERUSUVUVWVN?=
 =?utf-8?B?T0hyYTFoTFdjcW10UkUveFJWVzFlOElLYnZzWjQ2MjU3TUJZMVVhRzdLeGFs?=
 =?utf-8?B?elVNQkJXZERjazQzZlBaSHZDSWVaK0hvVFBYR2xRQnVBZmczZTBLUmNyTzZz?=
 =?utf-8?B?eTlSZHZVRThueUsxMGEvVU1xMUkvOXNDM0VaRGRFK3ljSEpXTnlIQUVOUXEx?=
 =?utf-8?B?bFM4YWNjTzVJWStwenA2UWxDWXVrcjRBTSs5QXUyQU1EL1BRMHFSUTVnWjY4?=
 =?utf-8?B?RzJRTElGL1FHVHUxQm5GK3pNVDA1NUFidTF2RVZMNUZTbFhnZ1FXTUlYM3I2?=
 =?utf-8?B?dGVYd0Z2aklaRWprdGNyWnNCTmZhVDUwc3hYSFM4L21iNnpPUThiYVpQVkR0?=
 =?utf-8?B?Qkd4U1RvQlZxWHlXdDR5aHo1YnZHTnVQL3BVVjBmY21sNElJOGJ5a1VCT3Zx?=
 =?utf-8?B?WllWT0xjSmdpS0NoRzhjcHM4SkU0Y1g0bklzOEJJTHBYNC9KVk1DUitaQzY1?=
 =?utf-8?B?NEN2cXBVQ2krN2g3L2hLOXpkRGI5U0J4Vm1tU3RMUk5KeTBjTlJKRmN0cTQr?=
 =?utf-8?B?TzIxMnhKOWp6STlqL1p2aUhBczZBME12SjdaZFhiNGhoRUh0Nk5YNDdqcEo0?=
 =?utf-8?B?ekVsT3MwYzdWaDJ6dDVlWk05SFBVRmdMRFdGblNiN09vUmVoMDkwS3k2S0xW?=
 =?utf-8?B?OTVXSUdRRWkyd0oxTUJIVlpFdmkyWHJ1aDNjcGVHYjZWMW54emZCdE5NU3pK?=
 =?utf-8?B?b3VoNUVkQnNqWk9TR1g4MzVLTDdwNXZuWllsOW5iOVhRajJxMWxBNWwxVmI0?=
 =?utf-8?B?Rzg3bFdDZTI5UnMyL1pnWGNvRUF1cDkwTjI3RUxpaVBBb2pScFNZQzF3VGty?=
 =?utf-8?B?a0FzdGRvVThLM2VhdXlBR29VZWlsc20zeGdzb3F5TnFLcWpDZ2R5b2FJbHRh?=
 =?utf-8?B?TE9pVTh2cXNXekRuRTh5WU0zYnhMc0pxelRON011RmkyTVZJOTFxOVBULzBj?=
 =?utf-8?B?RWVxRXhuV2t2M1QvUWdvWWUvMXVacnBmNXN5R1ppUE9FdE4vcTA5RFVjdmY4?=
 =?utf-8?B?ZjhCcU1LMkRyVXIrZEp2bmlGKzhDYUF2NXNkMllycG8xVVBMRVRqWmsrdlpS?=
 =?utf-8?B?ejFLdjY3TllNQkJ4MUxwUVUweTVJQzhBdkRrSlo1bm8rVkcwZUF4L2NHZzNL?=
 =?utf-8?B?MTVEeGovdXhPNjJ5U2c0eDlhWFI0K2ZqZldDZ0xZUzlXUmxqZllpMlZCdzd6?=
 =?utf-8?B?cnpyZnBsRjlUbDUxL2pjc1VEazJpd1hoR3FBbDJ0MmdsMk8walhZY2FhTDRx?=
 =?utf-8?B?K2k0anppc013Q0pncThoK2hyRlhXd1M3ekhtcTJqdVRGMUM3K2hiWkxSSWNa?=
 =?utf-8?B?NW9xcVhDbDFJZVhKMWlOVGlCbFpsZnM2c3Z0UUVrQ0xjTzFGK3Vva3VHYUNi?=
 =?utf-8?B?WW13WERxRHFwSGRSUGR4K0wyUzNCYWVWcjlVYmw0NnBaanNKMVBWOW81NXll?=
 =?utf-8?B?TmVkQnJIL2V4bFhieXpzeEtzSzBFVFlGVTVwcGRhTFk1WU5XMnVVOTJUZVRB?=
 =?utf-8?B?TGYxbVRVNkxPd0RmRWcvTEpCUmJFQVFSRU1aK2szYkRYcmpraVhWbXhDOHBv?=
 =?utf-8?B?WUNnTDhQTW9aRnZqUnFRSkt0TDNoRkN6YzBSZE1vYXhRNlNQV1IxSThrVngw?=
 =?utf-8?B?NXdFWldSVG1aUkJOeUd0dTlYVGViaFl2VWQxcjJ5RU1jL3dOOUc2OWt1dkNV?=
 =?utf-8?B?eFVZZHduTGlWblFBR0gxL2g5YUVNWUNpOHJHUTZQZWdtVlBweHJaZ0dKK3ph?=
 =?utf-8?B?VzNmU1NBL2VyaG1tL3R0U0t6ZnBnOHZZNHhvamxLTFo4RUxwenh4ZkowdFFT?=
 =?utf-8?B?SS9ObitoK0Q1SnNBS0F3cVhmeE9oSUZPSFRsRkxmQjQwWjRwOXMxSnZJOTFR?=
 =?utf-8?Q?H5ZRF5NEmYY2BCqotxrvZDFO+HXCzs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 12:49:02.2165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f194a48-f3ec-4ef0-1d3d-08dd62f698f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886



>>>
>>> There seems to be some quite fundamental disagreement on how this
>>> should be done, so I'm afraid I cannot do much about it ATM.
>>>
>>> Please agree on a common approach and come back to me when you are ready.
>>>
>>> Sending two concurrent patchsets under confusingly similar names again
>>> and again isn't particularly helpful.
>>>
>>> Thanks!
>>
>> Hi Rafael,
>>
>> Thank you for looking into this.
>>
>> Hi Lifeng,
>>
>> As per the discussion, we can make the driver future extensible and
>> also can optimize the register read/write access.
>>
>> I gave some thought and below is my proposal.
>>
>> 1) Pick 'Patch 1-7' from your patch series [1] which optimize API's
>>     to read/write a cpc register.
>>
>> 2) Pick my patches in [2]:
>>     - Patch 1-4: Keep all cpc registers together under acpi_cppc sysfs.
>>                  Also, update existing API's to read/write regs in batch.
>>     - Patch 5: Creates 'cppc_cpufreq_epp_driver' instance for booting
>>       all CPU's in Auto mode and set registers with right values.
>>       They can be updated after boot from sysfs to change hints to HW.
>>       I can use the optimized API's from [1] where required in [2].
>>
>> Let me know if you are okay with this proposal.
>> I can also send an updated patch series with all the patches combined?
>>
>> [1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
>> [2] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
>>
>> Regards,
>> Sumit Gupta
>>
> 
> Hi Sumit,
> 
> Over the past few days, I've been thinking about your proposal and
> scenario.
> 
> I think we both agree that PATCH 1-7 in [1] doesn't conflicts with [2], so
> the rest of the discussion focuses on the differences between [2] and the
> PATCH 8 in [1].
> 
> We both tried to support autonomous selection mode in cppc_cpufreq but on
> different ways. I think the differences between these two approaches can be
> summarized into three questions:
> 
> 1. Which sysfs files to expose? I think this is not a problem, we can keep
> all of them.
> 
> 2. Where to expose these sysfs files? I understand your willing to keep all
> cpc registers together under acpi_cppc sysfs. But in my opinion, it is more
> suitable to expose them under cppc_cpufreq_attr, for these reasons:
> 
>    1) It may probably introduce concurrency and data consistency issues, as
> I mentioned before.
> 

As explained in previous reply, this will be solved with the ifdef
check to enable the attributes for only those CPUFREQ drivers which want
to use the generic nodes.
  e.g: '#ifdef CONFIG_ACPI_CPPC_CPUFREQ' for 'cppc_cpufreq'.
			
These CPC register read/write sysfs nodes are generic as per the ACPI
specification and without any vendor specific logic.
So, adding them in the lib file 'cppc_acpi.c'(CONFIG_ACPI_CPPC_LIB) will
avoid code duplication if a different or new ACPI based CPUFREQ driver
also wants to use them just by adding their macro check. Such ifdef 
check is also used in other places for attributes creation like below.
So, don't look like a problem.
  $ grep -A4 "acpi_cpufreq_attr\[" drivers/cpufreq/acpi-cpufreq.c
  static struct freq_attr *acpi_cpufreq_attr[] = {
	&freqdomain_cpus,
  #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
	&cpb,
  #endif

>    2) The store functions call cpufreq_cpu_get() to get policy and update
> the driver_data which is a cppc_cpudata. Only the driver_data in
> cppc_cpufreq's policy is a cppc_cpudata! These operations are inappropriate
> in cppc_acpi. This file currently provides interfaces for cpufreq drivers
> to use. Reverse calls might mess up call relationships, break code
> structures, and cause problems that are hard to pinpoint the root cause!
> 

If we don't want to update the cpufreq policy from 'cppc_acpi.c' and 
only update it from within the cpufreq,	then this could be one valid
point to not add the write syfs nodes in 'cppc_acpi.c' lib file.

@Rafael, @Viresh : Do you have any comments on this?

>    3) Difficult to extend. Different cpufreq drivers may have different
> processing logic when reading from and writing to these CPC registers.
> Limiting all sysfs here makes it difficult for each cpufreq driver to
> extend. I think this is why there are only read-only interfaces under
> cppc_attrs before.
> 

We are updating the CPC registers as per the generic ACPI specification.
So, any ACPI based CPUFREQ driver can use these generic nodes to
read/write reg's until they have a vendor specific requirement or
implementation.
As explained above, If someone wants to update in different way and use
their own CPUFREQ driver then these generic attributes won't be created
due to the CPUFREQ driver macro check.
I think AMD and Intel are doing more than just reading/updating the 
registers. That's why they needed their driver specific implementations.

> Adding a 'ifdef' is not a good way to solve these problems. Defining this
> config does not necessarily mean that the cpufreq driver is cppc_cpufreq.
> 

It means that only.
  ./drivers/cpufreq/Makefile:obj-$(CONFIG_ACPI_CPPC_CPUFREQ) += 
cppc_cpufreq.o

> 3. Is it necessary to add a new driver instance? [1] exposed the sysfs
> files to support users dynamically change the auto selection mode of each
> policy. Each policy can be operated seperately. It seems to me that if you
> want to boot all CPUs in auto mode, it should be sufficient to set all
> relevant registers to the correct values at boot time. I can't see why the
> new instance is necessary unless you explain it further. Could you explain
> more about why you add a new instance starting from answer these questions:
> 
> For a specific CPU, what is the difference between using the two instances
> when auto_sel is 1? And what is the difference when auto_sel is 0?
> 

Explained this in previous reply. Let me elaborate more.

For hundred's of CPU's, we don't need to explicitly set multiple sysfs
after boot to enable and configure Auto mode with right params. That's 
why an easy option is to pass boot argument or module param for enabling
and configuration.
A separate instance 'cppc_cpufreq_epp' of the 'cppc_cpufreq' driver is
added because policy min/max need to be updated to the min/max_perf
and not nominal/lowest nonlinear perf which is done by the default
init hook. Min_perf value can be lower than lowest nonlinear perf and 
Max_perf can be higher than nominal perf.
If some CPU is booted with epp instance and later the auto mode is 
disabled or min/max_perf is changed from sysfs then also the policy
min/max need to be updated accordingly.

Another is that in Autonomous mode the freq selection and setting is
done by HW. So, cpufreq_driver->target() hook is not needed.
These are few reasons which I am aware of as of now.
I think in future there can be more. Having a separate instance
reflecting a HW based Autonomous frequency selection will make it easy
for any future changes.

> If it turns out that the new instance is necessary, I think we can reach a
> common approach by adding this new cpufreq driver instance and place the
> attributes in 'cppc_cpufreq_epp_attr', like amd-pstate did.
> 
> What do you think?

I initially thought about this but there was a problem.
What if we boot with non-epp instance which doesn't have these 
attributes and later want to enable Auto mode for few CPU's from sysfs.


Best Regards,
Sumit Gupta

