Return-Path: <linux-acpi+bounces-11018-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F08A30DCC
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 15:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341791887438
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCCA24CEE0;
	Tue, 11 Feb 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fM+kifAs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A89124CEC2;
	Tue, 11 Feb 2025 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739282961; cv=fail; b=TvCTU2LtD5IajNbGH58mF13Mfm7rOy+wQmWTBAQSLYslnYiq7kH+6SY/uDImWBmFWtbqnwsh1dPpzmKG1LKmCF9tPRespw+gJ11LFtrT9dWSymJWJWOqdA92+ANPHMHUekHB2j2fAot0ChUR1HLQLOACMuHQI/Fg9hmiHVgnTo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739282961; c=relaxed/simple;
	bh=91Den3JnjZe34Of1lC3mdEj6AHv6AopxLfgExPPe/c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f0C1YBvgYoUFUd+22SIFwJ5l9kdm+8g0YV8jW2PkltWdzlIVexACe6w2No3EIcMfDr6VttDt+W5ByLCFWRomvkWRnyxfLLuGCZlOvzsT9dgMsCEgNtOHXod/yt8esisqrCLyNIP9OWFhoO/2mn98QLTJ8QY9ev+7vpRD2PeieXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fM+kifAs; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sY1Qwo+X8npJexn9027bnbdG6OlEyYkW5SH6Cw1jgp1Xl2+aeEMzAYXYOnLCiw++02qMCl7BaCbp75N2UWecwDHrBiqFmO0z1sy6fKrhUhTQ4nYBLqE1/lE678P6CZyZ0YNtqsFFcvLtRModWqJ3eZqTb82A3XOXSSFG8MDF5U68VrzhNzv/QeeZP913H3yvbgAt+703T/QLcoI/vXepJH0PxpoPo7ihccP4ZVAxuicuiYCSSdiv0FhjSghyIG0w6kVwNpNRuAeLt2ixNMzvjRT+NV+E5LGFvmzsx5P2f5FDwT/0vPxF/gqj44t5U0IkAOROE6V0IyPQD4YPPuMR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0qrc8Y/w+OTiGrAu9QluRWGhvp3LSW/xD2o7SSiowI=;
 b=IcSAeh6CLJPuwor1dhtw1uKG8eldSXjXaQGMPmnng5npDcXQCg6S03BVBBlpWCXmwvK25VjGBTNiBKLtLV3VoKlF8Z+S14AlbMr2SGSirQO93tqq3O/7SiFTZUVMb68KE2vS4bdWdZrbE4jqkK1dnuRHLLDCGX3W0J+YUmLmQT2AQXMdmrstZbfTIr9MupQVHRuXQKgn1/q+VLfhgKex5yXHrEy05fuNIh3ZiYGy/aRDKXcoOazw2GeMz7aLLXnF6dj88AR47mY7h79meMDcMohIwscceJf6W18IFlESd3xskzrCFvvNeh2nGKAAEnWJmiNiGcUcX/qoTI3VBrSORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0qrc8Y/w+OTiGrAu9QluRWGhvp3LSW/xD2o7SSiowI=;
 b=fM+kifAsTiX3u0qCgRtJbrpOwNywzaRWLa2ctNh/lXW3qcXIn+ZCT4Kh9PxWALtghYNmd/7GcXbMy2eGZfio1Gy/H/WYgsilth9F/RyJYBJeewh92kb/AIes7muHmbMIPOm2AW0Jq23clyioqKR5d0Aj09Ko4onsCQvThdglWOLY3jFeAKPf1edGHZ0ygLM0MwUoV5vLRen2emxBTovR8SOyTjP/r67pPH/S7iIMtLG6S7bMXfM5Zj+/c1SRsfIbAiTd99uBiTFeVgMwXqqxOk4SxYoXNSrt7SspZx0RnVNTadlM0brUCHNmJmegTyIZ0kZKQKEUjfvbg7cJtpLUYg==
Received: from PH8PR21CA0013.namprd21.prod.outlook.com (2603:10b6:510:2ce::22)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 14:09:11 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::14) by PH8PR21CA0013.outlook.office365.com
 (2603:10b6:510:2ce::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.5 via Frontend Transport; Tue,
 11 Feb 2025 14:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 14:09:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Feb
 2025 06:08:50 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Feb
 2025 06:08:44 -0800
Message-ID: <868d4c2a-583a-4cbb-a572-d884090a7134@nvidia.com>
Date: Tue, 11 Feb 2025 19:38:42 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <b45d0d81-e4f7-474e-a146-0075a6145cc2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 98513222-33e1-4493-2c06-08dd4aa5a78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2Y5T29ZREUzcFNHSGZYSUdraGNCRTB6OGNQeml4YTIrUGRnQWVHVkExZWc4?=
 =?utf-8?B?dk9zL0pqdmk4TTVwcTJIZTE1L3pqQytTQTgxZHZLcktudTE5S1JTa3ZDdHZh?=
 =?utf-8?B?T1NGa0tPOUVpZmMzT1ViN0FkeDAySmQ3Z3FucG4vcVI3SS9GNWxReTFIdHBP?=
 =?utf-8?B?R2djRjg3OFFCbytvcGl0SDIwdjYxQzdlZCswQnJZbHZMK1daYXFzRE53dkdr?=
 =?utf-8?B?cnFpOGhZOHd2Z0JhOUZLVmpNSml2WXpzaWdCdFJnZmZBUWJrR1FVajdOcEZp?=
 =?utf-8?B?Nisrb1ZwZXk2RzdZak52YUpvbHdtQjI3ZUpweTZWWkdxNmJySUgwc2dnczhr?=
 =?utf-8?B?VjdpYmd3TlVEOVV4UmNlaXhicmF5eXdvazU5L1c4d3B0OXUxR3JXSXN3cm9r?=
 =?utf-8?B?RmQwd2hPdzA4UjR2R2c1SzdEOHA2dXlCK1podXMzNHJ3VkIyUk0xNTE1LzZR?=
 =?utf-8?B?UGREL1pKQ1kvazVwZ01WdVduMVhmRFQ1MUJDbDhvZTZyRWErS2JFOG9XOEJu?=
 =?utf-8?B?SENYTGlXR2hMK3ZFVHBDdEdrbGhLUnlpSWlRdEQ2Z09nRkJqbmtMZUFHMDE0?=
 =?utf-8?B?RzFqWkQzT3B3NnorVU85OENraWk4RDFST3NSUGxTbjRmbnc5ekxCUG42KzJj?=
 =?utf-8?B?eUlBQ0xhS01jemFxMURVRzFaL2lqZ005QVgxbGRkMzhvb3N6Z0FvYk9DTlA4?=
 =?utf-8?B?MSs5WG5QK3cyNTJrVDRkc1FwaU1HMlZnNlVVSGdCZzJIc3kxTzNRZVZXOG5n?=
 =?utf-8?B?RDVoNGxLejN1LzZlYzIzN0JEN0FjdjRMNVVKVUNRbUV0aEFZM3RGUGF1YkFT?=
 =?utf-8?B?eU5uMmhCa2psN2JJMEJqZUFORjIvSkFlS3gwdi81U1R4b2FDTnNXc0R0QW5r?=
 =?utf-8?B?MVQwRnduVkhQeXpFUXd4VjRqRlpqSStDMnNsa1UwZzNIZXpvSWFoQVNja0wy?=
 =?utf-8?B?Z2JRYldYNkNjR3NNRmdQWjVIVXh1NXR1RFpEcjl1TnhrNDg2RjR4WFdUR2hN?=
 =?utf-8?B?RHV3bW5QbElkanowRTFmRHdJNUVaclplWVNZQ2FzLzVMYXVwcmY2ZFJpZWJR?=
 =?utf-8?B?RzErVURWVVRxenNJRm1rT1M2V1AyYjhaQVgwaTdqbFNDRWNia29CWUQ3RUNu?=
 =?utf-8?B?R2tTTytkcWV4TXMrK0hFNEJDNk84dWtsbjZKREpSQWZlcHVQMzdoT2ZvMDdK?=
 =?utf-8?B?ODZ3TkQrcXo1ZmVwdkVpajhUazdDK084UmFJMHRxSmRRaGxWNVdKV2lGUzdZ?=
 =?utf-8?B?QjdMbkRjMlZ2UE14V1IvYjUrQ0dhNlQwMjFITXcxcGdsNFFsaUZocXlReDhp?=
 =?utf-8?B?cDZ4Y0NuL2lsb3dJaDJsNzFJQUlGaE5NdWhFMkxySFJzNGhUQ1VLN0pSeGZE?=
 =?utf-8?B?RFNTL3l4Y25SclE2OUY4RmNnTUlRN2NLbHZ5RUJMOVU2YVBrem5rNUZzdFpu?=
 =?utf-8?B?czZlRWJCUkF4c00vUzc0VFlSalpSczJUNVU3WHhmc3Y3L2NkN0l5NmhPRWNk?=
 =?utf-8?B?SU9PbUZTRzhmU3NQNHcybkZibEhnTlY3cGZjVHg1aEhhekN0M0NlTFJRcGM2?=
 =?utf-8?B?VVNDQWN0cVMybFZaNkZqSmgzVmhUZU9BdDgvNmhGekc2K3FwOE9FNDRaWDQz?=
 =?utf-8?B?WUcrRDArbWx6dXFkZlR0aEFUMWpFZFhHYUdxMnI4ckxpZENmMGdJeVRCblNv?=
 =?utf-8?B?WXQ0aGRiaUdYcWsyVlRYMmlQdWdqSzM1ODF4VW93b2dicDJmMXA0MGJvdzdL?=
 =?utf-8?B?QWIxU2w4TkFSM3IvT0xYMmozUWRPSHJMdDNVbVp3eG15VmN0MTVma0NSMlFx?=
 =?utf-8?B?MTl0amZ0V2Nvd3BSMkVuUVN1Z09JV1V5b2NyTTdQeHZLRnVwc1RROURqbWdn?=
 =?utf-8?B?UUhxeWZnYnU1WWdCNWd4d1JYV2czeFI2d2NJYXpFdFpxZTJWVnZCMTVqSDNQ?=
 =?utf-8?B?WG5rT0VIeEJmc3NVdkQ0N1VDRzVybUhvNlViU1dxOFJ2YkFHV01oZHJSTkgw?=
 =?utf-8?Q?1h05BXcji6BCaHEovnnQE6Wx+OvbYo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 14:09:09.5981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98513222-33e1-4493-2c06-08dd4aa5a78a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041



> 
> On 2025/2/11 18:44, Viresh Kumar wrote:
>> On 11-02-25, 16:07, Sumit Gupta wrote:
>>> This patchset supports the Autonomous Performance Level Selection mode
>>> in the cppc_cpufreq driver. The feature is part of the existing CPPC
>>> specification and already present in Intel and AMD specific pstate
>>> cpufreq drivers. The patchset adds the support in generic acpi cppc
>>> cpufreq driver.
>>
>> Is there an overlap with:
>>
>> https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
>>
>> ?
> 
> Ha, it looks like we're doing something very similar.
> 

Hi Viresh,

Thank you for pointing to [1].

There seems to be some common points about updating the 'energy_perf'
and 'auto_sel' registers for autonomous mode but the current patchset
has more comprehensive changes to support Autonomous mode with the
cppc_cpufreq driver.

The patches in [1]:
1) Make the cpc register read/write API’s generic and improves error
    handling for 'CPC_IN_PCC'.
2) Expose sysfs under 'cppc_cpufreq_attr' to update 'auto_select',
    'auto_act_window' and 'epp' registers.

The current patch series:
1) Exposes sysfs under 'cppc_attrs' to keep CPC registers together.
2) Updates existing API’s to use new registers and creates new API
    with similar semantics to get all perf_ctrls.
3) Renames some existing API’s for clarity.
4) Use these existing API’s from acpi_cppc sysfs to update the CPC
    registers used in Autonomous mode:
    'auto_select', 'epp', 'min_perf', 'max_perf' registers.
5) Add separate 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq'
    driver to apply different limit and policy for Autonomous mode.
    Having it separate will avoid confusion between SW and HW mode.
    Also, it will be easy to scale and add new features in future
    without interference. Similar approach is used in Intel and AMD
    pstate drivers.

Please share inputs about the preferred approach.

Best Regards,
Sumit Gupta

[1] 
https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/


>>
>>> It adds a new 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq' driver
>>> for supporting the Autonomous Performance Level Selection and Energy
>>> Performance Preference (EPP).
>>> Autonomous selection will get enabled during boot if 'cppc_auto_sel'
>>> boot argument is passed or the 'Autonomous Selection Enable' register
>>> is already set before kernel boot. When enabled, the hardware is
>>> allowed to autonomously select the CPU frequency within the min and
>>> max perf boundaries using the Engergy Performance Preference hints.
>>> The EPP values range from '0x0'(performance preference) to '0xFF'
>>> (energy efficiency preference).
>>>
>>> It also exposes the acpi_cppc sysfs nodes to update the epp, auto_sel
>>> and {min|max_perf} registers for changing the hints to hardware for
>>> Autonomous selection.
>>>
>>> In a followup patch, plan to add support to dynamically switch the
>>> cpufreq driver instance from 'cppc_cpufreq_epp' to 'cppc_cpufreq' and
>>> vice-versa without reboot.
>>>
>>> The patches are divided into below groups:
>>> - Patch [1-2]: Improvements. Can be applied independently.
>>> - Patch [3-4]: sysfs store nodes for Auto mode. Depend on Patch [1-2].
>>> - Patch [5]: Support for 'cppc_cpufreq_epp'. Uses a macro from [3].
>>>
>>> Sumit Gupta (5):
>>>    ACPI: CPPC: add read perf ctrls api and rename few existing
>>>    ACPI: CPPC: expand macro to create store acpi_cppc sysfs node
>>>    ACPI: CPPC: support updating epp, auto_sel and {min|max_perf} from
>>>      sysfs
>>>    Documentation: ACPI: add autonomous mode ctrls info in cppc_sysfs.txt
>>>    cpufreq: CPPC: Add cppc_cpufreq_epp instance for Autonomous mode
>>>
>>>   Documentation/admin-guide/acpi/cppc_sysfs.rst |  28 ++
>>>   .../admin-guide/kernel-parameters.txt         |  11 +
>>>   drivers/acpi/cppc_acpi.c                      | 311 ++++++++++++++++--
>>>   drivers/cpufreq/cppc_cpufreq.c                | 260 ++++++++++++++-
>>>   include/acpi/cppc_acpi.h                      |  19 +-
>>>   5 files changed, 572 insertions(+), 57 deletions(-)
>>
> 

