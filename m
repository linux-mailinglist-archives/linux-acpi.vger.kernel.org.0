Return-Path: <linux-acpi+bounces-19334-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C771C8FFC2
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 20:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D38854E9386
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99430217F;
	Thu, 27 Nov 2025 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HXm5Ij3y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BA8462;
	Thu, 27 Nov 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270216; cv=fail; b=G19bbP/PzQuAvI1h2zwCjlVBHfr8swZ64X9O8+0KF5MiYNJQc+UI6KfspTA1cGkpD44n0W+kGyQbsbrUguftWR5tqjlZ679qX2+JC4hnxAA1MiSNjKY5kLSu4x0X/m7BrLSavCRIS7/U4m/BUoCj4bh/H+XEz0q4A2MpKX9nXw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270216; c=relaxed/simple;
	bh=9IGAAZrbUqPU6W3RQIyUh7SelE02YCysmEuBGyxtOUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ck5rlhulBcihv4jwhW/qjQdSeLM6jViJZXZkiRf1ciQsgUhDOYC/3AbaGczRz6z+Va8Glu/JgwQtsuCmraR6TdFcI7FcCMCq1RtXhcw6UAsqErysSV/MPVME3djE2SMbwvwllpy3ounhDgGOLTN1PgCa1mDj+mRhY+fZxd8SSiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HXm5Ij3y; arc=fail smtp.client-ip=40.93.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9iNFk8cb8a3SsNsrp7HiIL4DVdUrmtYU90GwzyP1jkJ2nt5uvBdD1M3IjO190DqZ/Bh6+EsAOxtdEyZ6tuxtq7FIcVUnykw0SNdAAEpIcwpMypAvIB1r92wIesitZ5lcYnuL3pgNjhkQIjQ4q8Nv6pBB4KFBltVzvnh6bC1iMVPG4rIrpgTGg24Ydt/XZVIrEpW0wf9SzEWeJEuVFo1gd4H8YxPZkR2czEzEkSz0RGZ8Vu6UbXykeYgxyPCsv7F7vQNasOjX1B1tq75YNtOhgsOhdhe5EMxyhJIqCgujzTz72WRdu7nGOzUoa8/NFzyVXTzjMQz9YfTqEIY7zgQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0USHeBaZQmkkO1YCBZ31wINjuwazMx8VRwgp9U4uZR4=;
 b=RVHwAlDFZY7QuaguqxViwfJkNY56+laTIfeYq2cPcSzaXC876BckItCaWfX9kLAFYWaL3SbhpxBudZCHEkkUEN6zxnXNNfdQMkzSbs9whn8tIBYDmwbuNMM9kYLf4v9kJSlZQgdlsKJwrO6pV5goTEQ0/3+dxoqDD14Dr++AhSlAHymDcuxgoX/pU46IK7EcUb+QwHHToOR8Bli8pPyUtOPEyZ00cNnufWTXUpr+lLn8ZC7aWoco9KjyCP4jvWIkoRZ7YorUrICp/foc9RwfzBDv6KGjq97YzkcwqmBnLNc7rjrf6r4HMR8eM33ESXgXwVvnnqgeGZDX+TeAbuzRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0USHeBaZQmkkO1YCBZ31wINjuwazMx8VRwgp9U4uZR4=;
 b=HXm5Ij3y04Xq2zP4MsfqFXNNtBLvWFg5Mez0uu+8sBPpChfj5D7KgaZ1IF8S1tlS4eTiLo10qCNcF/4/jH5BudgM1X49LsD6E7pgXGRQwuC3JA2yhfblbygCSAwJ4/wgq21i0ShdGsuN3r5e5bavMel13aXakEhklz2O8rJYp0E=
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.13; Thu, 27 Nov 2025 19:03:29 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::32) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.4 via Frontend Transport; Thu,
 27 Nov 2025 19:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 19:03:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 27 Nov
 2025 13:03:27 -0600
Received: from [10.252.222.129] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 27 Nov 2025 11:03:24 -0800
Message-ID: <7487e99d-421b-4ac5-bb77-e61c3131bb13@amd.com>
Date: Fri, 28 Nov 2025 00:33:24 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Urgent ACPI support fix for v6.18
Content-Language: en-US
To: "lihuisong (C)" <lihuisong@huawei.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, <kprateek.nayak@amd.com>, <dhsrivas@amd.com>
References: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
 <1ea445d0-0949-4a28-9f76-325861a3c57f@huawei.com>
From: "Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
In-Reply-To: <1ea445d0-0949-4a28-9f76-325861a3c57f@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 042096bc-aea6-4dc9-6750-08de2de7a638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|30052699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjZCSHU5MjhuWUQrcVZUbzZud3ZaRWFBNTlYQ0hlUWFYUVFUdlNYVlpDdUZL?=
 =?utf-8?B?VzlRYXFvSXFnb2cvN2FvTHR6MnhwTzNVZEV0SzNNeDU1QnRpY3ROVDE2ajVq?=
 =?utf-8?B?ZWZLSm9pUTlramc5eVpsc3B6T3ZPZU5IVmZMM0E2Z2FHeXorZXBuSXdUUTR0?=
 =?utf-8?B?RU9EVFl4OGZWUm5DSXFwUEhRK3Y5N3crdDZrUWZxTTUzZzNpK1ErTFhZWTNj?=
 =?utf-8?B?NmkzR1lhbnVKTHR5WGg4Mmw3QmVYQkhGZk1WaXpGczUrcG9wdXFxWVJpVEdN?=
 =?utf-8?B?VHJ1bkxWbDZDZnVBQ1FvK3U0cEY3dkpSa1VFcW5CS2FFOGtjWXB3WjNlVDFk?=
 =?utf-8?B?R3NNampIWUVvODNqRjlMYjROY3R6R3llN0JUdVBsV3g4SWlsMXFLOGdyV3FB?=
 =?utf-8?B?Q21rOUlJdzlMbmlyT0lJbWZZekFhQXV5V3VoK0hwOEFzQ1pDdUNEcHlxd2to?=
 =?utf-8?B?TjlqK09PNlRPT0hSSzlpN0I2WGJkeGpON3Fsb0g2M0FkL0FBY0pIZ1BqWnVB?=
 =?utf-8?B?YlBuN09Ed3JVNU50NmhIYzZlVzlyZS9oYThGdlRWekdkU2lIM29HTEdvbzN5?=
 =?utf-8?B?bjEvanJaSE1mcmFna2U4U2F6MzNRWWxHeEZwWVZvb0xYR0FJYmlZSTFLZEky?=
 =?utf-8?B?eloyMHo4eU15RFZpYkEzQTdTVmU2TG54VjZLaTVQSUlaVGxSak1FK2M4c0ZG?=
 =?utf-8?B?ZmhrNXFxV3NWVzBYWnExWjFBZ3dsTlZhaVdqOTQ0MEt5UUtyUGJLeXZLVjMw?=
 =?utf-8?B?UjlqSVk5NlJWL05tRW5IWmVVTkxNYk9NeC9zTFVLVVpBa2VwYitHZjYrUWRJ?=
 =?utf-8?B?bmV3dHRlNDM5RVh2NTZmTlBsdFdwYVp0RGtqWjZjMnZtNy81c1NIZDl4NEdm?=
 =?utf-8?B?VkprWEpyZW9nWGdrVHpWVVd3SlNHL1l1c2c0MTcvdGFEZzZNWE9iYVIvbEdF?=
 =?utf-8?B?K2MxUGV0YlliZU05dW0xM1FrRlhVSEFzWWFtMUZWZEVtQUdvbVBoSUtqR2gv?=
 =?utf-8?B?RFhaTDNmTTJtRTZQNktkQ2RVS3dOa1ZMMnNRTWlCdC9BNlNFZlp2Ym1VdkdQ?=
 =?utf-8?B?NDkvanJvTnpaZituc01hOUdMYlkxVWVPTk1uVFVlMVd5Qy9OcFBVMng4YnM0?=
 =?utf-8?B?clpsZzdjcTNmU3ppdzN3ZGRnSVBWb2E4eVdCckNaQUlWdldXQ29PNDNZVUxG?=
 =?utf-8?B?ZW9QU2o0aU1CTmM3TzZJbnNVK3k1YTZ5T0JQekhFVFUyQTVETGxocFJQV1pt?=
 =?utf-8?B?MXQyNjFWTlYzQ0l3ZlhzM1dTWFk0bVN6Y2tUeEhIazFIYkJHY2trNHZubDYx?=
 =?utf-8?B?RndYczlDSHYrUDIxc0c5bUZKZW1CcEY0OW1mTS9QZmR5UlVsNVBLdyswN3RU?=
 =?utf-8?B?TnlpMHhNWlJsVW4yejJZcXBBbXdFZHNzbXlrcU85YVRuNUVqazd6MU53WE1T?=
 =?utf-8?B?Y3ZGL3FNcTl4TDhINytPVVhLaXN2MlhPOGRtYm1mTFFJQkdkUTdDMkU4cVcv?=
 =?utf-8?B?L0pxbVFxWUNPVjBsYWFSQksxOFJyNXdmNFJxNXdQaEVTdm4xVTVodG1JSklV?=
 =?utf-8?B?ZDBBUDM0elBrQzNCbnpwU0RrelhJQU95MVcvNnZzWlRqV1UzMlc3dnp0UVA3?=
 =?utf-8?B?ckE1NXMrc1NEYlZUODcrajFCR0t0eGlJb2lTMFhLZUVmaWVLVGc0MVcwVWli?=
 =?utf-8?B?OG12M2FmQXVhOWJNQkUzZ1lJM0VDUkJBUDZ2a1E0cXFvdVNDbU5sU3UxWUZn?=
 =?utf-8?B?T2NUbFRnYUplMzdjdTdUaUliaWxmbkhrMXExMThheW1ZV0Y1ZmdGS21xa25n?=
 =?utf-8?B?MGRWK1Z1eGhua3hteXdGMzZDNjlaSG5EWC9JS2VHeEZ1VVA2b1cxa0NHeG1B?=
 =?utf-8?B?QTJ3dUFOdW5nWmx3OU5IN21ZZ0VaSGNNbnlGbXBWTHdMRXNxbkR2TGZsNW1u?=
 =?utf-8?B?VTlkY0NXNXhEdzdrSU5vb2RyT2Iwc0pDVjZrcHlCY01nQVZ0bUNxVFR1SnNx?=
 =?utf-8?B?THBpNVlpbzF4MldEeE84VkFwYXN0WjhvMzF2WmhWMGw3RTVlN29heGhIVG1K?=
 =?utf-8?B?UURnTjNYNE11ZEVPYldCZmtQVEl2ZENpUUVqOWNwaGlWYk0rdlVnQlhhOTdJ?=
 =?utf-8?Q?iq9k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(30052699003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 19:03:28.1809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 042096bc-aea6-4dc9-6750-08de2de7a638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995

Hi all,

On 11/27/2025 7:39 AM, lihuisong (C) wrote:
> Hello Rafael,
> 
> 在 2025/11/26 20:54, Rafael J. Wysocki 写道:
>> Hi Linus,
>>
>> Please pull from the tag
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>   acpi-6.18-rc8
>>
>> with top-most commit 43ff36c4a5a574ee83b4b0d3f3d74f09a3a8c2d3
>>
>>   Revert "ACPI: processor: idle: Optimize ACPI idle driver registration"
>>
>> on top of commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
>>
>>   Linux 6.18-rc7
>>
>> to receive an urgent ACPI support fix for 6.18.
>>
>> This reverts a commit that attempted to make the code in the ACPI
>> processor driver more straightforward, but it turned out to cause
>> the kernel to crash on at least one system, along with some further
>> cleanups on top of it.
> I just found that "ACPI: processor: idle: Optimize ACPI idle driver 
> registration" depends on the change
> about cpuhp_setup_state in the commit [1]. Or many CPUs don't create 
> cpuidle directory.
> What is the crash? Do you have releated trace?
> 
> [1] https://lore.kernel.org/all/20240529133446.28446-2- 
> Jonathan.Cameron@huawei.com/

We have observed the same issue. After booting the system with the 
latest kernel, the sysfs path /sys/devices/system/cpu/cpu*/cpuidle does 
not exist. Bisecting between v6.18-rc7 (good) and master (bad) led us to 
the following commit:

43ff36c4a5a574ee83b4b0d3f3d74f09a3a8c2d3 Revert "ACPI: processor: idle: 
Optimize ACPI idle driver registration"

After debugging, we identified a code change that resolves the issue on 
our systems. Below is the code diff:

diff --git a/drivers/acpi/processor_driver.c 
b/drivers/acpi/processor_driver.c
index 7644de24d2fa..65e779be64ff 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -166,7 +166,7 @@ static int __acpi_processor_start(struct acpi_device 
*device)
         if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
                 dev_dbg(&device->dev, "CPPC data invalid or not 
present\n");

-       if (cpuidle_get_driver() == &acpi_idle_driver)
+       if (!cpuidle_get_driver() || cpuidle_get_driver() == 
&acpi_idle_driver)
                 acpi_processor_power_init(pr);

Thanks,
Amandeep

>>
>>
>> ---------------
>>
>> Rafael J. Wysocki (5):
>>        Revert "ACPI: processor: Do not expose global variable 
>> acpi_idle_driver"
>>        Revert "ACPI: processor: idle: Redefine two functions as void"
>>        Revert "ACPI: processor: idle: Rearrange declarations in header 
>> file"
>>        Revert "ACPI: processor: Remove unused empty stubs of some 
>> functions"
>>        Revert "ACPI: processor: idle: Optimize ACPI idle driver 
>> registration"
>>
>> ---------------
>>
>>   drivers/acpi/processor_driver.c |   6 +--
>>   drivers/acpi/processor_idle.c   | 115 +++++++++++++++ 
>> +------------------------
>>   include/acpi/processor.h        |  34 +++++++++---
>>   3 files changed, 76 insertions(+), 79 deletions(-)
>>


