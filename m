Return-Path: <linux-acpi+bounces-9823-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC389DF0F0
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFFB2812A7
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C119DF4B;
	Sat, 30 Nov 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ss6z/XMQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3A1990C9;
	Sat, 30 Nov 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975664; cv=fail; b=j2xprfgXULUyljn84BNVCF4wMJK1MrtWvOHyWVBrW8aE3jucXND6V68IATB15UdE1pelucpTa4zYpkPkkUqXP1FBOahRKtwj8wakOcw3tDT+U5JjQStjp52Vq1mFJu1nf6i81pVsm4647FzOV49YuaoSD21BJNMu3xLgeXwFyfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975664; c=relaxed/simple;
	bh=htJ6C6iIe2+2xs2Lzih1UffueevFwc4+pCim2iuMfmM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sjNnbPXZKqZhu+AUpOAuW2DYaNc/qJlHKh8znu2HYDz9A8ZWtD0imMOdG81+qP+/A6FtHnpz8axlVKIm5Jr+nYp6kEduMsoSCqlls8YZPFiRKKH4Gle48uaRDHDuxzz90UShzlnljDSGFnvj8BJN23ShojzGX8DHKFOnOh6bLUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ss6z/XMQ; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nh2A5pCPcYlwgEtJlrR+9b2KYIqmO+lPHiH+Rf3NWudkzR+FtsIgUR0lkTEFIOa1gha3WzTm/v+MW4/FJCnzqoJ+wBstM9bEd3cPp8tGrHbu+f5eTusawzSIpuYCNBMdWOrElCwUVVJCWfPRkXgs49yZDpHpPBxPjJneaQivTSUUD0zV4z/JU0xEdDZE7YTTAZvDYAtYoJl3adaw6mlj3zx93+/LYekR2Nlk49RD+KrQn7cG16WMDE/6RqQ7pzYMxKjmJbk0tsDGZAZU/SDPt1+rSOvctzWfXKfIEfR/ZDv1M1VlVRzxfIUGX8l3dqIaL/UaVFD1TIq7/FN0gvLNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yiv2S/pAPwqqzxx8/Yz6mRECdy9CirrlQK1Tyf2MfV8=;
 b=bFv5nLk3XfGsVsxZN0Jkzc9rrtJ5qsbd1aV70sHzQkAuw6uliKaZ58bwvRB7jmcq30wSk5JSljCPQ1xMVuF7Qh/tGqrCIm4u5Ulwe6vCg2+VWlnXFNEbxudiNf/xjbWUoIqR004TaJkKMpHtA+Wc1dcWH987p5nc6BpLr5yMo19hv+iCQEEumsXoAWOcc2ZmpAyYKybwv4Ns2X8XaNJ+7TbZgqlDJQEBemJbwHBPeWwWecOO16b2KYrGW4d9dtMJIGuhsUCp3owHsM8emLo22s2bn15Hf9Kyna+JqCl6M10Gxgq78lmqybayYlgXFd/eGzBhwAGudX+HYPvWeXm7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yiv2S/pAPwqqzxx8/Yz6mRECdy9CirrlQK1Tyf2MfV8=;
 b=ss6z/XMQlejpliwggwDUz2p1J4n9fX9vsqNKoRwwFZIiOZ0LHCcleuyfkkRUSB7NKyl49mBwyvkve780eRT9iqH1zo0sAaLEWyNKzgkzAx42fdyJJp1/iL9GxkPUXN7jaUAFwR5B5qt8aQ+Eksb9jXwgaeRwnerbXWEIUq/uAUw=
Received: from SA0PR11CA0052.namprd11.prod.outlook.com (2603:10b6:806:d0::27)
 by SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 14:07:39 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::30) by SA0PR11CA0052.outlook.office365.com
 (2603:10b6:806:d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Sat,
 30 Nov 2024 14:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:35 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE
 (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, Peter
 Zijlstra <peterz@infradead.org>, Li RongQing <lirongqing@baidu.com>, "open
 list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:AMD PSTATE DRIVER"
	<linux-pm@vger.kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v7 00/12] Add support for AMD hardware feedback interface
Date: Sat, 30 Nov 2024 08:06:51 -0600
Message-ID: <20241130140703.557-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c241329-0c62-44c2-a88d-08dd11485956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVhhd2NwSWZmakt1dXhtVHJsekV4TzVOalBrcjJOOTlzeVBEREljU0RuWTJu?=
 =?utf-8?B?VDhUbEd2anh1TmtxTXAwbkttZm5ubm5ZdCtCcjVDaTRPWVhRNjEzWXROYXV5?=
 =?utf-8?B?M0Rab05GM2tUaWlJTG5VaEpwRFZUWGtNVDJCdDhnSFYzZGpnY2RoZEd2aFpp?=
 =?utf-8?B?MFRtQ1ZsWlpXVjJNTmkwVzFESEJWQ3RSdG4xclFSYStsV0dtekhHOGpYOHpn?=
 =?utf-8?B?OWw3NTEyQUpKTmZUVnV2elFlenIydjM4M1pRdVRiOE9jaXd1VXhOMVBLK0FT?=
 =?utf-8?B?NW5YcXV4SFpBNFYzNHBqUGFYenFlVW4xeXFwZTBWR05rYzdiWFM0MHdQQno5?=
 =?utf-8?B?Z3NpUjFDeHVXMUxRV05OV0lNTzBPZTF0ZXVJNjZib1hBTVFOOGhzd1VtMzZC?=
 =?utf-8?B?Zm5FU0Zsd00zU1BYT1pVSXZpZ1U1ZTNVRUdxY0tOR21Nd3NhVjkzVWpiR3Vu?=
 =?utf-8?B?OEk3Wk1PSUxEUU5ndVA1R2Y0NmQzMGlMMjNHNFNNRUN1NDV2S0oybWJXTWll?=
 =?utf-8?B?QXgzOHltVDI5eDk4ajVwMk5ZSzNFdm5qU3g5V0J5eFZiRzU4dU55Ui9JdzBQ?=
 =?utf-8?B?WFQxMXFEOXZhQkIyS0tSRmkwWGx2VEtXWU5VN3NoS3c3b21KT1lyTjg2NWo4?=
 =?utf-8?B?ZGlQSXRBQ25vZmErOWExeFNOMUxZK3RwekhLblVzVVJ4MzB2R2JHMUhzdndK?=
 =?utf-8?B?SnBORG9mMW1HOTJxZDZNdDF1bTV3N2R0OVloQTVobWdkWUN1UWc3SDBHRE5r?=
 =?utf-8?B?Zi9KZ1dXQ2FlbVI0b1pmZjAzTlVUbEorcDZGaVljbVcxRXE1STVNczJuUG9S?=
 =?utf-8?B?eXd3VStXSnZuMllPYVNMQVVvaTRwMVZLTU1sNXhyeG1pd3hLOC9xSHc2TDVn?=
 =?utf-8?B?YU1BZEJCb2Y2Nmp0MFlGVzRINFRJRUZidk53aEptTFFOQisveFVyaFdyTCtK?=
 =?utf-8?B?cUNiWDNTb2pVWi85R1NydkhGWGMydEs1ZHFCSFNVRjlydENhS3dldWNENzEz?=
 =?utf-8?B?bXhSYitOQXlMaUROVTloRWtWVTd6cE5XZ0x6OW9NeWxCMldUTWVkVmhJMlh5?=
 =?utf-8?B?VjhYV29MUm1FczZQMUEzbFNhOXhwMjd6VVlVM3lrUldLSzJEN2NYcTBLbjZm?=
 =?utf-8?B?MlV6N3lkL0xMclFjaitzRldKZWJVNk1oWDFQVktrdzdZQjZZQW9nWXNFbEZL?=
 =?utf-8?B?dG1xWGRwMXRIeHRVQTFUSDN3UkVRZzdsVEdGVzc5NEkwQVpQdk5SejhUWW5X?=
 =?utf-8?B?U1JSYm9KMUd2ZldTNXlISk5USWNXcGVoV1VXdDhrMmxHTHR5VGNPbFY1VXBm?=
 =?utf-8?B?Y3NRMiszVzMzeVFwcS9tVjYvcnFCSXo1cFRFYi9TRGQ1Z3ozVWdXcXU1Y3l0?=
 =?utf-8?B?cjlwRUFzaXZMazRDNHNhckhPOW1tR0hmRTF0bGE5RFZoQ21ZaEdNcEVNck1N?=
 =?utf-8?B?YlVSeHpOd0xCVktwcE5CMURIU3lHaE12RlZXTUVmQzdheUl1bFBSNm5ZMHZv?=
 =?utf-8?B?aVg4L290Sm16UGgxRy9meWpoTnZ6cnZjTE1hWHRUY05QZk5JaFBNV2ljTi9E?=
 =?utf-8?B?UHJuS0NKYkJWVFNPMjA1MXBVbnZyT0lhSmxGemd3N0hjVWllUVlNUmI2OUU3?=
 =?utf-8?B?UGF4dStxc1BKYXFWdzl4aWh5YzluazNSZHV1T3NweFk0cXViUGNGNlQxOXFU?=
 =?utf-8?B?dnp2WnNvYWEydmZUUTlXMEhVWkt0Q3NRV0xMY1VDSnp0VHpvNHpqU0RWeUVM?=
 =?utf-8?B?eEplUXZ6enU2NjZDYXlOQUlpL1VPOUtLb1BKbyszRFIxaDdQUWdQWVc2OGhD?=
 =?utf-8?B?NElvVkdZL3RWS2Ruc09KRFdUakJ2Y1lBMmFhdUEveU1sOWNzWXQwUzZvZ2xO?=
 =?utf-8?B?WGMweWhmWDBwVWt4NVJsMEd5WlBZSDZFeVU2ZWlkMnZjQTRMenBNU1V3ZHJs?=
 =?utf-8?Q?x1KA8jaQ21HoG3G7i4vlgJgPN+c1/mRg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:38.8772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c241329-0c62-44c2-a88d-08dd11485956
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901

The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
provide behavioral classification and a dynamically updated ranking table
for the scheduler to use when choosing cores for tasks.

Threads are classified during runtime into enumerated classes.
Currently, the driver supports 3 classes (0 through 2). These classes
represent thread performance/power characteristics that may benefit from
special scheduling behaviors. The real-time thread classification is
consumed by the operating system and is used to inform the scheduler of
where the thread should be placed for optimal performance or energy efficiency.

The thread classification helps to select CPU from a ranking table that describes
an efficiency and performance ranking for each classification from two dimensions.

The ranking data provided by the ranking table are numbers ranging from 0 to 255,
where a higher performance value indicates higher performance capability and a higher
efficiency value indicates greater efficiency. All the CPU cores are ranked into
different class IDs. Within each class ranking, the cores may have different ranking
values. Therefore, picking from each classification ID will later allow the scheduler
to select the best core while threads are classified into the specified workload class.

This series was originally submitted by Perry Yuan [1] but he is now doing a different
role and he asked me to take over.

Link: https://lore.kernel.org/all/cover.1724748733.git.perry.yuan@amd.com/

On applicable hardware this series has between a 2% and 5% improvement across various
benchmarks.

There is however a cost associated with clearing history on the process context switch.
On average it increases the delay by 119ns, and also has a wider range in delays
(the standard deviation is 25% greater).

Mario Limonciello (4):
  MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
  cpufreq/amd-pstate: Disable preferred cores on designs with workload
    classification
  platform/x86/amd: hfi: Set ITMT priority from ranking data
  platform/x86/amd: hfi: Add debugfs support

Perry Yuan (8):
  Documentation: x86: Add AMD Hardware Feedback Interface documentation
  x86/msr-index: define AMD heterogeneous CPU related MSR
  platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
  platform/x86: hfi: parse CPU core ranking data from shared memory
  platform/x86: hfi: init per-cpu scores for each class
  platform/x86: hfi: add online and offline callback support
  platform/x86: hfi: add power management callback
  x86/process: Clear hardware feedback history for AMD processors

 Documentation/arch/x86/amd-hfi.rst    | 127 ++++++
 Documentation/arch/x86/index.rst      |   1 +
 MAINTAINERS                           |   9 +
 arch/x86/include/asm/msr-index.h      |   5 +
 arch/x86/kernel/process_32.c          |   4 +
 arch/x86/kernel/process_64.c          |   4 +
 drivers/cpufreq/amd-pstate.c          |   6 +
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  21 +
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 546 ++++++++++++++++++++++++++
 12 files changed, 732 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

-- 
2.43.0


