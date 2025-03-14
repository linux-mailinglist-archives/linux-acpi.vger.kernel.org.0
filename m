Return-Path: <linux-acpi+bounces-12242-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF2AA6122B
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBCB1B63037
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9F1FF609;
	Fri, 14 Mar 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tMZoemAm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8F1FF605;
	Fri, 14 Mar 2025 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957920; cv=fail; b=fW81iahGbv5eo7IvgMcSPH3C9C6IK8z7YbvtUtpb/SL+MXSUFQyprfrfnEPz0M+eOodYk0IAuP3yq8vEuzzyV7DjK6fIDE0tEFgPW1e/Q05ymNFAsVtoACXpkFikiUzJYM3lariPqlrCiC6P80mzKppUnBnrxYA50+FnPSgXo1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957920; c=relaxed/simple;
	bh=7ATV2sBQTCyNgqWJJQdc6Mi0xK3zCoBD7aBCZRplhVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oxO3lz272ZaEjDkPwLeHF5aimvB8YmhBqfyoSXHGjzFa3dYmr4aqTpLTjWk8aSpxob0Pm/EBZWqwvMtcGlfwGXZ6YRPCqX3Wzih2fb8J98o9zYDM9m1/Nq3tKuebR7PBu/5AinM4Ja1okxi0p2Yw8cO6sbLd//4c1UtBBWeuTtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tMZoemAm; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHIyx0dyYLxRdrBgNzYqAa5Fly4/0NadOGDjroh0bbA7Pt26dxF/Cwdgbner4J6bGNmGrj2uB2pc+n4VjMP1RO0WkYJB1n9raTnEtBKD4GpcqEtX8I2LELbxCXcLS8J6ium4zO08o1UjAEBKVu5iX+hF+gCq8woYKBX1CwYs7RskiJi5hiXGo0Xgg4gwZ33ky+1IApXd3kNkp+m4Ugm30rrErWZT+TSBZfq5MxZFv9m9ZL/G0aSa1eB0ULEkq2vHAV1yzG7YfhufNnc4rY7FHO2yAFgjPlu6jA54Vdl4xKotv8O1oRm0X5hAfaSvdTLMecb0ruFefscEyMpeqHrocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Kcd+oV0ocZ8cE75EgDRJRaCh/rRFS1gernAbao/tS0=;
 b=h8GIC1Zu6rk44++VtuXXOfuN/5dXWpLSlWdOLzPV9qKCxgnGHRg0iYgzerTzQrQ7cKW14SZRsMgpVbo7MC/VAQtVq7zsbOSE7SZtJTbJMOdTR+2D6Os9ffRHfzq9hyw8Wl/X9MB2FIGJm6LqaC2e0HJS/eDhqHP2G0TuTkD4U8o1s0IWV4FyAA8cdyod/X1UfAoalFNbeNRlfoFNDjWoVYTlik+PTyz8IlcFWuKlPtfoHDIiCube/tpSp9uwM6peHk66mhGCRmNZjQCrsrB0YPLpUtQ/ZsvnkFfGsOiyIG5fPFUX5uaRaVsWkH1jyBPt9V0RFCJlSfeVBEyD5f8U/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Kcd+oV0ocZ8cE75EgDRJRaCh/rRFS1gernAbao/tS0=;
 b=tMZoemAmDaxXmh+2+ytFMqD/3oNdvPIIz4aU5ynLT/wklR2PKKWZPFDeL+wjJHoLfdyU4etwMuSlkJWFEaiKI9oZj6vzxI03Mqv/FCpUkGuoeH+w3dM8YenvfN9hEPMXHiXuoMgpQw8FS1Q7MjPmNJXmERPLrY3CvNfMulobYJhrUS6Bw4Kgm7TSNwkTZXwtM61o+9ElDvnZob0QkeSG6m5XOFhf13o73i1EVrQxf7ewyNoOzRsjFhTxCCk4BoQCt1eSaLB0N3LI62XKg6O0LVkdDb1k+1IyXrpDBjBpGOSMuWkeQEL5kf9fBir5ps5XkjDpwG+PcRI3JxW7BE9oOg==
Received: from CH5PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:1ed::28)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 13:11:54 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::35) by CH5PR02CA0011.outlook.office365.com
 (2603:10b6:610:1ed::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 13:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 13:11:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Mar
 2025 06:11:36 -0700
Received: from [10.41.21.119] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Mar
 2025 06:11:30 -0700
Message-ID: <b2bd3258-51bd-462a-ae29-71f1d6f823f3@nvidia.com>
Date: Fri, 14 Mar 2025 18:41:28 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 3/5] ACPI: CPPC: support updating epp, auto_sel and
 {min|max_perf} from sysfs
To: Pierre Gondois <pierre.gondois@arm.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <sashal@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>, "Sumit
 Gupta" <sumitg@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
 <20250211103737.447704-4-sumitg@nvidia.com>
 <ecd2190d-09a2-4e7e-a076-08f517fe20de@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ecd2190d-09a2-4e7e-a076-08f517fe20de@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4fea79-1798-43c3-6c85-08dd62f9ca82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWliQzJpVVhSd0pQY0ZROUdEUnlxMnVZL1d0UER4azhJZTlYcUpxVWNPblJN?=
 =?utf-8?B?VUgyVDhjd0VtR2NYdUg1L2xxZ3hiTkhpN044Um9pbzgxaUNVSUJVSDNPY3pz?=
 =?utf-8?B?SXdPSDhYMWVvbDMzR1lpeUUwUi8wRXBBK1Y4YTdmWVRHcDh1SExaeUlsdWdq?=
 =?utf-8?B?aEpOaElqRkxRcEdyT1I4eDRhTXhHcEpTcG1Eb3JmeDVtRUNaMXRxRzdVVUdT?=
 =?utf-8?B?dUJacXlIc2V0SnZMSG5CUFA4L0RhcFVZYnUxOUh6a0xBZXhKNEk2Y21wUEJv?=
 =?utf-8?B?S1ZpdUJEVTVjTWYxWlRMWGNVc1grTmQyak9idUNHeFFCU0FlcktSQlpCQk95?=
 =?utf-8?B?MGl5SnBCQURUME5MdVJLbWhHLzJ6cXJEK3dYd0wzMm1rV0VDUjlvbW12UkFj?=
 =?utf-8?B?SkVXWTdSK1NJeVVIdU05V2psMEptaEdjYzFWTGt5WHRMK1RwTHdtb2FCWDJr?=
 =?utf-8?B?TDhmdFY2K0lvVFJ1c1Z3N0M0Smp6SERuc3l1dXB4SEQ2STBFZjJCVmt4QnY1?=
 =?utf-8?B?T0d6SDY2dlNFV0dmMFJ0b21HeERnNEQ5OXJFeTZZZTRNNU1LSDE4OTMwYlFL?=
 =?utf-8?B?U2YrSFAyS1labHdPV29NSDdhRnp4TTRFSlQ5dzJlQVRqVzlRTTlmQk0vUzZI?=
 =?utf-8?B?Q0NaQWtZOG9nbEkzN2JPQ0VJWFcrdzYwb1hIYmdlVnk5OWREZ2NkeWI2Tndm?=
 =?utf-8?B?MmZveWRWWTVUdThseFJXOFNtK3NmeXhaaS8wdkllRmdjOHV1UE9sWUhjQUd6?=
 =?utf-8?B?U0c0S2FhMGczbWNEemhsQ0FwWWlLUjZSd2JoNTA1YkZUZDUvdHBCcDREeGFo?=
 =?utf-8?B?a2ovck9iT3JKNk4vZHRycjBaMTRBYWNPekNEVUY5MkpRTkFFR1hQSG11TSt2?=
 =?utf-8?B?MHk1QUg4OEVSd0l2Nmc5K0FPalh6SkF5K2tXY2o4TDZNamlrejRjcExGKzB2?=
 =?utf-8?B?R1BxbnlLZTgvRjBTeEtYOEZxRlk5bWhsQk5udXgzMTR0a25UT2thbkpETkNz?=
 =?utf-8?B?YzFhSXZvNzZ2bHpkVXRmb1dCTExQeHQxenp4aVlCWGF5bFNuem9CTGJtRjAw?=
 =?utf-8?B?SmFXWmIybysyL0p5bFpWSk9YRDVna0xOYnpRS0tWMGorMnUvUVpRVUliUGFu?=
 =?utf-8?B?ZVBqYllnRmNIMUZPbzJXUXBZWlFPM09mRUNoMjFNUk0rcGxjL211ZklEZENQ?=
 =?utf-8?B?eTJRYXJLVzdOYXV6alBMVkhUUDBWUFZBSHlUaTl4TVRlWDhDVVIzVm9XanFD?=
 =?utf-8?B?Y21Tb3dEZmhCa0FNUEJMc3pwdXZFdjhleHJDWU9FMnJCR2plV1RNRDdzUEhS?=
 =?utf-8?B?djA2VW9uV1RDR1AyM1ZXaXFtYzFCeW1scWhrUGlZU3VRS1lRYmpFZTV0L0k3?=
 =?utf-8?B?d0Q4c0JCKzBxQ0UrcmRqVVE2SDNldnJIZHVLY0lSNno4N20vVnNoaFdtRFds?=
 =?utf-8?B?RDRBYWEwYmllS1NKSkEwakxoSGRtNm5MNXdHczdoVWFmQ29GUkVmaHJlZDl0?=
 =?utf-8?B?OHd4ZzFjZUZUZEtXQnY5aGI1NWJVQ0hCWTFWVFBXaGlLcnBMRjBpczUvVzFW?=
 =?utf-8?B?MTVuZGlsdmFHaUlUK2ZpM3QwdVAzNEc4dWR2VjR1OUJ4c2Vta1czK3NjcUto?=
 =?utf-8?B?dXZaYzRNNGU4MzZlbDk3MWhBVGYvOXl4Mkhlbll4cmxlZTlRZUdIVmF5WlJW?=
 =?utf-8?B?alhKazNnd3NwV3l5cEI2VlMvejNoZUpWRTZQdlFlZHJ5bGp2ZHhMWXBaQVB1?=
 =?utf-8?B?MXpsVHdudlpkdzNKUzkwUmxxaGRabVhkaTVGanVwR2pHMkJzVW0rY2JIMEZs?=
 =?utf-8?B?UXJmc2dTdTdUY0d2S0VNZC9JZjZqRUU5ZzZ6ajRhcFI1NlRpTGszNmVkaERs?=
 =?utf-8?B?bFpBSVpWMUw4K1NhNThieG4yd3E1UzQvL3lZYmdkWVVKR2tOU3RjZmNpc2Np?=
 =?utf-8?B?NS9qUTNESldGc256bWx6TkpuT1Z0UmxtaGZOSHpjT0N2SHBVTmlTODFZcUZu?=
 =?utf-8?B?b214SUhGMm5BSXNLSTZZUjZuY09FbjRDNGNMZjdJK1pGY3NzTmU2ZmpEbDJL?=
 =?utf-8?Q?lIKVDX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 13:11:53.7433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4fea79-1798-43c3-6c85-08dd62f9ca82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898



On 24/02/25 15:54, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello Sumit,
> 
> On 2/11/25 11:37, Sumit Gupta wrote:
>> Add support to update the CPC registers used for Autonomous
>> Performance Level Selection from acpi_cppc sysfs store nodes.
>> Registers supported for updation are:
>> - Engergy Performance Preference (EPP): energy_perf
>> - Autonomous Selection: auto_sel
>> - Maximum Performance: max_perf
>> - Minimum Performance: min_perf
>>
>> Also, enable show nodes to read of the following CPC registers:
>> - Performance Limited: perf_limited
>> - Autonomous Activity Window: auto_activity_window
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 191 ++++++++++++++++++++++++++++++++++++---
>>   include/acpi/cppc_acpi.h |   5 +
>>   2 files changed, 183 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index cc2bf958e84f..c60ad66ece85 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
> 
> [...]
> 
>>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf, ro);
>>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf, ro);
>>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf, ro);
>> @@ -177,9 +304,16 @@ sysfs_cppc_data(cppc_get_perf_caps, 
>> cppc_perf_caps, lowest_nonlinear_perf, ro);
>>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf, 
>> ro);
>>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq, ro);
>>   sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq, ro);
>> +sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, auto_sel, rw);
>>
>>   sysfs_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, 
>> reference_perf, ro);
>>   sysfs_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, 
>> wraparound_time, ro);
>> +sysfs_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, 
>> perf_limited, ro);
>> +
>> +sysfs_cppc_data(cppc_get_perf_ctrls, cppc_perf_ctrls, min_perf, rw);
>> +sysfs_cppc_data(cppc_get_perf_ctrls, cppc_perf_ctrls, max_perf, rw);
> 
> IIUC, this means that users can modify the min/max performance levels of 
> the CPU
> without having the cpufreq framework notified. Meaning that if a user 
> modifies these
> levels, the frequency selection will be done using the initial min/max 
> performance
> level.
> I think it would be better not allow users to modifies these values 
> directly. Reliying
> on existing scaling_min_freq/scaling_max_freq files would be better IMO.
> 
> Regards,
> Pierre


Hi Pierre,

Sorry to get back late on this.

Providing the option to modify these registers from sysfs will help to
easily tune for Power and Performance.
When min/max_perf are updated or auto_sel is enabled from sysfs, the
policy min/max can also be updated with those values.
When auto_sel is disabled for a CPU from sysfs, then its policy min/max
can be updated back to the nominal_perf and lowest_non_linear_perf.
Was thinking of doing this in v2 after conclusion of [1].

[1] 
https://lore.kernel.org/lkml/f0f1b31b-a0fc-4d21-8b79-c896833dae35@nvidia.com/

Best Regards,
Sumit Gupta


