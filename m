Return-Path: <linux-acpi+bounces-11187-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E114FA357A7
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 08:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64705188B56F
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 07:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23742205519;
	Fri, 14 Feb 2025 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uIuLMi//"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150AB200132;
	Fri, 14 Feb 2025 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516946; cv=fail; b=YynuLGjPidZAU/4o9mvTSI1LgFaLNmStno9e3ZK0dwVfG0xzTHoZE/jFIDLnjND8Usxy2kifRFDsuwuqHbKLi7R8XOj6R7mBjprNHL8uIa52SJqBljpEYhXgtjpwKTUZSLwnJGc8afsic0zFctOxuc2Foy3CySOUHQxv+Ec+yvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516946; c=relaxed/simple;
	bh=ez4nyWF7yrazVeR7YdBEu9tfUhBu3w9TA19Frme/w/g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=D8rkAbL+sEB+Q3fM3yxYKFcJnVPlohapVO4PE3b9e5sT4SEjVQStUFNNZ/LN7muC8Ysl89Bs1XStipYwklqCLEOjU9IIXEWyG9pI4kWR4aA9PXE+c04IlMVkeohCK5JsM1n/uhXkHmaiqRGmbSoTH5mlZ3wT23ZcqiIqqVtVSQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uIuLMi//; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCVNEPB/AWqaw6jMvz/agFG02+41BS+IHRWd1Ix7tpBU7PLaOMnJChWjmh/azlU6Y8Hcj29evSk9I1Ywl4JL1VwAiKgT5wKfSWkdiQfco62y7A3eQDMt/jSmczajYEidKLYvdLeJn6oSIXwuKwiDfExzc6avXmHc0lakj54BIYUI8ViDA/U9YBFAIP5ng2JSE+iVmDa3ZahWlRj9K1o5spc7RDSTTr+qZ6flR+vp0/zOuoFpKD1KiTesjqHjnoJCE/UaJfRzp0Ff2m1S62O53GqRM9p82z9pW3IAMUEI90K5AePmVXZulLurn4xRVhgTqyoR9phhhu0dwU55bzTFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lxXLZqc7pg97iDq76OnyJbFKMKG5zSjpdgOPpbTHyE=;
 b=U7ffLp0ujSKzmVeja3V63SQCLjxrLtSx9WOeqZAAHJCcDR/epMqTZmoCvFD/Kh49yCFLTyyTujswv1z4rnbCt5vU/bgaA9Q1+PblXsaPAwBx5yClBl48Agy+WNPR1Laa+CrQ8ztEl0YYjbx6j+sYHSPCt35UuK5JBhqkUh2EWuPQQ9t2KVI5by6wR3P+heXPTYTKm7FLq1Vk75kegeY3QJ3Ze0GO6dqvADFbKpi3cvrxvJtjet5gaB8s3cYjv5u+sZFHOMxBL5MN7ElMAuShC+eiWszMx7WoxSln8O2yrqtfB/vj3rUhnOjh64rboeoj79qYSCMx9oAmLX0m8Z6/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lxXLZqc7pg97iDq76OnyJbFKMKG5zSjpdgOPpbTHyE=;
 b=uIuLMi//SfcljkRf+bMsaPSawso10TqV2mGLVFeIM23bCE0RkWC+JWxT2RWS6jxwBlLsiH7gMCq4yudwqlur8Sj5EZdAU4WQKE2naIJ3Wr1O8gkM+hX+X2MqKI8wLH39ebxAyxUhlBKFQKa073D+krca6+u6bHVXxI7//2yb5tFkSwoj9XgoZ3Afne0Hr+WLv9kKfCByJH6AMKlmOU0QAHN750LX2zf4UTPbhE0yWL0BJ21oq1YoZik+bsnY/PFGNtUtqn/qUzf8CC6CeDUk6QHqpEKkZ3P1lGG/AeCgywzGgqIL4dAqMIveQcAGjdK5YhzlFjT9UICBZg1fUfcQZA==
Received: from BN0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:408:142::33)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 07:08:58 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::c9) by BN0PR08CA0011.outlook.office365.com
 (2603:10b6:408:142::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 07:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 07:08:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 23:08:44 -0800
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 23:08:38 -0800
Message-ID: <94bdab73-adc4-4b43-9037-5639f23e3d1e@nvidia.com>
Date: Fri, 14 Feb 2025 12:38:35 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sumit Gupta <sumitg@nvidia.com>
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <sashal@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
 <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
 <b45d0d81-e4f7-474e-a146-0075a6145cc2@huawei.com>
 <868d4c2a-583a-4cbb-a572-d884090a7134@nvidia.com>
 <8d5e0035-d8fe-49ef-bda5-f5881ff96657@huawei.com>
Content-Language: en-US
In-Reply-To: <8d5e0035-d8fe-49ef-bda5-f5881ff96657@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd1155f-268e-4fdc-96e2-08dd4cc67354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm1nNzBENkkzZmpMS2tqeU12NGlQUHh0dElHNlZXSmpNWlI0MjNvRXdFUmhs?=
 =?utf-8?B?bW1zTWROMlFMVkZ3S2tRVDhNWHVDMWJOTWMxQTdNZ2ozYnQ4UUFDRXNvTGRN?=
 =?utf-8?B?TkMwTHRSZXpEMDl1cTMwdXQ5dDdYZzdiUWNPMVlKN09mZVFkcytBZFMwd1h4?=
 =?utf-8?B?QnRsczgvdkwxamhEcGY3VnlmNmNKSnVDOCs2YmN1TE9BZFRSNnp4Mjd1TGJj?=
 =?utf-8?B?WGFjdkxXcjBrMzBicjZvNFRlVlV5cmhHb2hZaU0wbEw1SGVBUysreTlhb2Np?=
 =?utf-8?B?RGlXdnh1c0Y2WHJ6Sy9LR0ZXNDVJUUZyaU90bVphZzArREh0QWc0d2RwMGZu?=
 =?utf-8?B?QmtxS09DUlZzQkgwaGZwVllBdVVnMENuMCttSjJrcVBCeU9lazJPNnZVeHAy?=
 =?utf-8?B?aW1GYzVwZmpoMWpjcmZFVGhwN3VPVGZaQUV0UVNvczlrK1dVYnk4S3Nnem5r?=
 =?utf-8?B?d2RFbTYrWDJSQzZuWm5YaDVhV3Zia2Jsazc2am9GVkZnNlg4aUh1UXRYMmFs?=
 =?utf-8?B?WVpteUNmTnY3YmdLc0gzT1U0a3JIOUNmblFrWFFGRHVJbGk0czIyd29qN0hB?=
 =?utf-8?B?RUhjd3FOSjJTajdteEZYcXR0QUxiS1JCK09yLzRxT2kzLzlPQTdQNGdvWjFW?=
 =?utf-8?B?MWhEOWJHS2s4emZaamFuQTFlNHN2N2RhNUxYUUc2YVVUc0lleUQ2bkxOU1I2?=
 =?utf-8?B?VTNRZDZmaTFDbDFlczRnZUNPNE9GWFJjbXU0SnJwU01yVTlFN0F1RFJlbjR1?=
 =?utf-8?B?VUFGR3NzK01pTDlHRkZZQ2dtTFFtbzgyVDEvQ084cjBwbTdHR2FkK01GZFpI?=
 =?utf-8?B?TDkvdEI5Q1V3UGlQN1RES25CMGYrNS9EZ0N4ajFWNEVJckVBYlNHcEJzM1pa?=
 =?utf-8?B?clpzaVIvMHhIN3h5N05SUGpqUTFOM1E4T0xGWkJCTVM2cDJ1MEpjeEo0enJk?=
 =?utf-8?B?Z1BrNjNtRm9ocmNuYldaRW1qbVpZb0RvckFTT0s3WGQrWnhrRjhuTXZxRUxG?=
 =?utf-8?B?aDRqZDRkUndDQ2JzRWczaTlnSGgwclpZWVRpOTVCM0pJNVBuY2ljeHVXZFZp?=
 =?utf-8?B?MmxzOGsrUEtEUEdsYWpteGM3Q3ltNDJPbWFKS0xuMnFkQTBjOUJLaGxTNXVC?=
 =?utf-8?B?dE04YTVnOHVQeGM0ZU83U0NXWlFrU2dzTExxSlBlZkVvVUtaV1plUHZXK04r?=
 =?utf-8?B?aFNhbmVOc3IxZlo5VU1nQVJaU3dVd1pMQjJxUjRhOEZxRm5wYnNKbmg2bk1Y?=
 =?utf-8?B?ZFNkUEhuUG1XbHlzemoyV2s3T3dWTjlteHhaKytEcEROWXVTMEVUVkpoWUZ3?=
 =?utf-8?B?eVpuajFqeUxFNHg5ZlZPbXpnUTFSUUZObnVyZjNWbDdxcHlKeWRsUzZHZXVr?=
 =?utf-8?B?MkZVWERmNGdoZDZ6cG9YZVZjVUorNHRRclZQYUs3elA1WDIxS0YzbDFuWmpK?=
 =?utf-8?B?VUcrN2Noa2tZNENZMXFqdkFnT05XRisvVGR1L1VVUDEzRnU5QWtXNW9ITWl1?=
 =?utf-8?B?UDFUM1hvN1dqRFFBS0RHZjZycURpSTBhVURiQWRwcU9VcUorSlRTK2xvdUNG?=
 =?utf-8?B?bFN6ZmZTU09Ic2lQMjhTd2JLSG8wcXRwcXdBNkNiYXNJN0hDd00yZFhVQ2xj?=
 =?utf-8?B?UDg3ZGp3WmRDc0duTm9UeVZLUnN4L09uRHF2N2cxRzdPT1owTkRLZ0pXS3dE?=
 =?utf-8?B?N3Z5YUNJWUpSdnZFeVNGcFEwNUE0QkhtVGEyTkIzbGVkSnE4MkZCdlRaUTdN?=
 =?utf-8?B?aXF5SjhzTWhvUTJWN2VEeGZrcVdHZ3BtQzZjMlRjQXRYcVI0NnlXVzhnQmQ4?=
 =?utf-8?B?YnFGcENMWlVEVWVkL1NwZWxlSkFIRVBuVkVCTEFvQTB4Z3ZZV0M4NiszN21w?=
 =?utf-8?B?SGtkYnNYbVZNTUM0TUdNakRLOWg3M1VuS2xPUk16cm1wSTJ6WUpYUCtQc1Jw?=
 =?utf-8?B?aUc0ZFpsVVlaTnBJSHZiUitPQmpMSEtJMzIrMnpsSi9UN2UyK1J0a1dtcUhB?=
 =?utf-8?Q?dT0ExiXwWAhxOI4o3jsxdMwzA65Myg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 07:08:57.6762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd1155f-268e-4fdc-96e2-08dd4cc67354
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333



On 12/02/25 16:22, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2025/2/11 22:08, Sumit Gupta wrote:
>>
>>
>>>
>>> On 2025/2/11 18:44, Viresh Kumar wrote:
>>>> On 11-02-25, 16:07, Sumit Gupta wrote:
>>>>> This patchset supports the Autonomous Performance Level Selection mode
>>>>> in the cppc_cpufreq driver. The feature is part of the existing CPPC
>>>>> specification and already present in Intel and AMD specific pstate
>>>>> cpufreq drivers. The patchset adds the support in generic acpi cppc
>>>>> cpufreq driver.
>>>>
>>>> Is there an overlap with:
>>>>
>>>> https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
>>>>
>>>> ?
>>>
>>> Ha, it looks like we're doing something very similar.
>>>
>>
>> Hi Viresh,
>>
>> Thank you for pointing to [1].
>>
>> There seems to be some common points about updating the 'energy_perf'
>> and 'auto_sel' registers for autonomous mode but the current patchset
>> has more comprehensive changes to support Autonomous mode with the
>> cppc_cpufreq driver.
>>
>> The patches in [1]:
>> 1) Make the cpc register read/write API’s generic and improves error
>>     handling for 'CPC_IN_PCC'.
>> 2) Expose sysfs under 'cppc_cpufreq_attr' to update 'auto_select',
>>     'auto_act_window' and 'epp' registers.
>>
>> The current patch series:
>> 1) Exposes sysfs under 'cppc_attrs' to keep CPC registers together.
>> 2) Updates existing API’s to use new registers and creates new API
>>     with similar semantics to get all perf_ctrls.
>> 3) Renames some existing API’s for clarity.
>> 4) Use these existing API’s from acpi_cppc sysfs to update the CPC
>>     registers used in Autonomous mode:
>>     'auto_select', 'epp', 'min_perf', 'max_perf' registers.
>> 5) Add separate 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq'
>>     driver to apply different limit and policy for Autonomous mode.
>>     Having it separate will avoid confusion between SW and HW mode.
>>     Also, it will be easy to scale and add new features in future
>>     without interference. Similar approach is used in Intel and AMD
>>     pstate drivers.
>>
>> Please share inputs about the preferred approach.
>>
>> Best Regards,
>> Sumit Gupta
>>
>> [1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
>>
>>
> 
> Hi Sumit,
> 
> Thanks for upstreaming this.
> 
> I think the changes to cppc_acpi in this patchset is inappropriate.
> 
> 1) cppc_attrs are common sysfs for any system that supports CPPC. That
> means, these interfaces would appear even if the cpufreq driver has already
> managing it, e.g. amd-pstate and cppc_cpufreq. This would create multiple
> interfaces to modify the same CPPC regs, which may probably introduce
> concurrency and data consistency issues. Instead, exposing the interfaces
> under cppc_cpufreq_attr decouples the write access to CPPC regs.
> 

Hi Lifeng,

I think its more appropriate to keep all the CPC registers together
instead of splitting the read only registers to the acpi_cppc sysfs
and read/write registers to the cpufreq sysfs.

Only the EPP register is written from Intel and AMD.
  $ grep cpufreq_freq_attr_rw drivers/cpufreq/* | grep -v scaling
  drivers/cpufreq/acpi-cpufreq.c:cpufreq_freq_attr_rw(cpb);
 
drivers/cpufreq/amd-pstate.c:cpufreq_freq_attr_rw(energy_performance_preference);
 
drivers/cpufreq/intel_pstate.c:cpufreq_freq_attr_rw(energy_performance_preference);

We are currently updating four registers and there can be more in
future like 'auto_act_window' update attribute in [1].
Changed to make this conditional with 'ifdef CONFIG_ACPI_CPPC_CPUFREQ'
to not create attributes for Intel/AMD.

  +++ b/drivers/acpi/cppc_acpi.c
  @@ static struct attribute *cppc_attrs[] = {
          &lowest_freq.attr,
  +#ifdef CONFIG_ACPI_CPPC_CPUFREQ
          &max_perf.attr,
          &min_perf.attr,
          &perf_limited.attr,
          &auto_activity_window.attr,
          &energy_perf.attr,
  +#endif

> 2) It's inappropriate to call cpufreq_cpu_get() in cppc_acpi. This file
> currently provides interfaces for cpufreq drivers to use. It has no ABI
> dependency on cpufreq at the moment.
> 

cpufreq_cpu_get() is already used by multiple non-cpufreq drivers.
So, don't think its a problem.
  $ grep -inr "= cpufreq_cpu_get(.*;" drivers/*| grep -v "cpufreq/"|wc -l
  10

> Apart from the changes to cppc_acpi, I think the whole patchset in [1] can
> be independent to this patchset. In other words, adding the
> cppc_cpufreq_epp_driver could be standalone to discuss. I think combining
> the use of ->setpolicy() and setting EPP could be a use case? Could you
> explain more on the motivation of adding a new cppc_cpufreq_epp_driver?
> 

With 'cppc_cpufreq_epp_driver', we provide an easy option to boot all
CPU's in auto mode with right epp and policy min/max equivalent of
{min|max}_perf. The mode can be found clearly with scaling_driver node. 
Separating the HW and SW mode based on driver instance also
makes it easy to scale later.
Advanced users can program sysfs to switch individual CPU's in and out
of the HW mode. We can update policy min/max values accordingly.
In this case, there can be some CPU's in SW mode with epp driver 
instance. But a separate instance will be more convenient for the
users who want all CPU's either in HW mode or in SW mode than having
to explicitly set all the values correctly.

Regards,
Sumit Gupta

> [1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
> 
> Regards,
> Lifeng
> 
>>>>
>>>>> It adds a new 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq' driver
>>>>> for supporting the Autonomous Performance Level Selection and Energy
>>>>> Performance Preference (EPP).
>>>>> Autonomous selection will get enabled during boot if 'cppc_auto_sel'
>>>>> boot argument is passed or the 'Autonomous Selection Enable' register
>>>>> is already set before kernel boot. When enabled, the hardware is
>>>>> allowed to autonomously select the CPU frequency within the min and
>>>>> max perf boundaries using the Engergy Performance Preference hints.
>>>>> The EPP values range from '0x0'(performance preference) to '0xFF'
>>>>> (energy efficiency preference).
>>>>>
>>>>> It also exposes the acpi_cppc sysfs nodes to update the epp, auto_sel
>>>>> and {min|max_perf} registers for changing the hints to hardware for
>>>>> Autonomous selection.
>>>>>
>>>>> In a followup patch, plan to add support to dynamically switch the
>>>>> cpufreq driver instance from 'cppc_cpufreq_epp' to 'cppc_cpufreq' and
>>>>> vice-versa without reboot.
>>>>>
>>>>> The patches are divided into below groups:
>>>>> - Patch [1-2]: Improvements. Can be applied independently.
>>>>> - Patch [3-4]: sysfs store nodes for Auto mode. Depend on Patch [1-2].
>>>>> - Patch [5]: Support for 'cppc_cpufreq_epp'. Uses a macro from [3].
>>>>>
>>>>> Sumit Gupta (5):
>>>>>     ACPI: CPPC: add read perf ctrls api and rename few existing
>>>>>     ACPI: CPPC: expand macro to create store acpi_cppc sysfs node
>>>>>     ACPI: CPPC: support updating epp, auto_sel and {min|max_perf} from
>>>>>       sysfs
>>>>>     Documentation: ACPI: add autonomous mode ctrls info in cppc_sysfs.txt
>>>>>     cpufreq: CPPC: Add cppc_cpufreq_epp instance for Autonomous mode
>>>>>
>>>>>    Documentation/admin-guide/acpi/cppc_sysfs.rst |  28 ++
>>>>>    .../admin-guide/kernel-parameters.txt         |  11 +
>>>>>    drivers/acpi/cppc_acpi.c                      | 311 ++++++++++++++++--
>>>>>    drivers/cpufreq/cppc_cpufreq.c                | 260 ++++++++++++++-
>>>>>    include/acpi/cppc_acpi.h                      |  19 +-
>>>>>    5 files changed, 572 insertions(+), 57 deletions(-)
>>>>
>>>
> 

