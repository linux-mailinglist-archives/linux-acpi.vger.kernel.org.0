Return-Path: <linux-acpi+bounces-9824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67AC9DF0F2
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96768281056
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029021A2543;
	Sat, 30 Nov 2024 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tia6PNWd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177961A0BE3;
	Sat, 30 Nov 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975669; cv=fail; b=sWogneyuaMrgw5pJEMZhigXSx8sT3ZrP7GgDdYCYsOqOAZfOQiUvC+6W/l+5KCWXCK+aHePNzwYwTb5Ih74WqFH1llsuyuTFmyHPJ8e3gcbq3uQsXMSMoggg/SBGOXwxCrH19p+KqmLal8mobcE2NAnc8ZPpc08AOB2SYmHTssM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975669; c=relaxed/simple;
	bh=DMjuuDJSJxfHSpL4ibtc9T2fw/bT7ago7AntzlFc7a4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+nQBcP41KiRmu0q4U3vNPTBgWO7ZOKvClIwWSl+kGq2ywwNzhaM/Ibbx+MeeAkg3XhUBgKvGundooyLU2Z5F7Ghn1Owi6m+qS0qsnZPzYcQTfScFiLgAb7qKvbRrt7RmIcZWaHNCNp6bDPVzSYuBw83D1M9juThUNTkKw2adDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tia6PNWd; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI5OPpxdPn53NecFdqc3IU/u+18jahyTPvd9BvBadw6VHsj2ceZIGmTxTvgF7bTJzHLe8ghNTchYwCC0+3cG0qI2g59zSudqaQR6ggfB64FTUUvIEGfl6CiL5STOWH5sV/84c+13sz0qlrCYwon2XddZnrXJyvPqNYEsTbeQFdhtSU+xTocDzsp7rAF4+O8lyrGChm0aVPRDWED1UpuA7Wvouos6GpW5EmtwsMWwq08YcfopFTkP7B0mbXL1MU3OusHvRFkQCCbporj6uVOk5GsjGpJ65LdbWaxrzJjQr/RlYZEV/vKPmbsTZgYuUwiJWxdJ26wyYdq+hl4ibszx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMJT/T88UaQRulFTCrjZGsRHX2tB2kPq7JxN+LCfSgE=;
 b=LymUvHaUlTvZNPI9hLFG+KCu32WdE/qUzvkTzx18+25QV0Dw2k2ZQJaWtrCcFLM17Qgdg1YDvqS+H8UaSHbSBFKKd7kFa3kJU5XaU6gGqKZwGatdU0c9oA/6R35116/AgkxU8dA8hrT2woSJa7NiNpxfcpoiMjSWcspIcCm38ujtek/20k5L76iVtbA1xNM4BnQgcKdoq1jlrVXc8/5KfUnUFI56N2RzcZ3pLF56SdA5nqlgAt+XANYtw+MeGoy13H3fHSJ5k0TpCYtZT8ySLBwxq4hPrq1NRRGlAFe8YirfWkaLv/TP4yP2ezSDUqbGgd4+OlqXwF8LOaI7jOZSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMJT/T88UaQRulFTCrjZGsRHX2tB2kPq7JxN+LCfSgE=;
 b=tia6PNWd3D4Gst80GICXvF+6o98PEEE7RZWSIHDEr2eNfyZEH9Ag3v68wAM9OkIp5TE9YdTnP2K6xAPrgdZUAfVlxymq6Rf12SibYCoCVViwDTK9d/e4uGF+MfAzkggnE+4MXBYyxZ+KHi/HkSvDNcV/1JBLqqi0K34b+AJJCiI=
Received: from PH7PR17CA0024.namprd17.prod.outlook.com (2603:10b6:510:324::21)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:07:41 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::8b) by PH7PR17CA0024.outlook.office365.com
 (2603:10b6:510:324::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:38 -0600
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
	<linux-pm@vger.kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Perry Yuan <Perry.Yuan@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v7 01/12] Documentation: x86: Add AMD Hardware Feedback Interface documentation
Date: Sat, 30 Nov 2024 08:06:52 -0600
Message-ID: <20241130140703.557-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140703.557-1-mario.limonciello@amd.com>
References: <20241130140703.557-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: f988543f-a21f-45c1-3eb8-08dd11485abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KjFLqHoU6wUm1vg9Qq9+Vr4dUbVOnlqwleBofnDuCSScl2om3gCi7W9+p6a3?=
 =?us-ascii?Q?0FP5pf2hlFW2Rj9H0d17440lWzqHvpwIq2RI6adIfLB0U2A9f5SoDdWf+1MZ?=
 =?us-ascii?Q?pl65bElosn6gUTBZKotE8L97OcMtG80KHr15w6bC9LmuLagp6dLql4dZ9Kps?=
 =?us-ascii?Q?BJq2B/UNVzgK/RertVAN6bOU9ZDTDY/uYuoz0sdtKB6SvthJ4wb8SOdrmuzO?=
 =?us-ascii?Q?oS2BNET12Xl3pXSG7AHjMwl4XdAjSC+V4LFfGq86nGAtNhNMCtA/eI+oVlcx?=
 =?us-ascii?Q?0IFKCbcTTLxVqgCFTQ5DmRMFiBIDPl4YCJu9Gz/CQb1rTK2szgREp5rVuSyB?=
 =?us-ascii?Q?1wKOs72KKkM7XCxnVn+0z/gssir/EmXBlhzMy9BxL+pz+gL8lRAka7hlDlVr?=
 =?us-ascii?Q?thKhUFMDIe3UPgsaTnJ00kkxdomSv8JqC0gC39IUtoBG/UXy2ouslqH7nvDv?=
 =?us-ascii?Q?7wktdHNgtDsFbtbk6TPszyGbhuGQQKDB/p8ipvKCXndVU0JtB5skV+HINclf?=
 =?us-ascii?Q?DNHFVaM0q/x/mpmrTSxipwPZisnoDzfgd0MQ7yR85wOUHqYULYHt5bCkkjOq?=
 =?us-ascii?Q?fFvNrOV1BGb/PZN+l79zuwiQnc3Ma+Eyn3oIeUghT6Kj4J6XAKti8euSsd/2?=
 =?us-ascii?Q?DavkcS0/oA3KhSpk79b4/haZ4SaZ44m5qXAH8AJDGnS2YAYTqrycocQDyRCX?=
 =?us-ascii?Q?TjpvCZqdkxrYL6xELqi140BWj8oOKg1IYzhoXTJg6QAgc3vG34Kaei0AqXFK?=
 =?us-ascii?Q?M5EcQFKNkjvfqzcwQb3B1pGYVPXBzqeuBsv6HrgWONGx4XSa/p7mYr1vvBEB?=
 =?us-ascii?Q?85N8yPEjdaJZiaboWxgJqOTnJgMUM91GHfVWHaKFmiXJ60OMCOFzbyPQ2WFy?=
 =?us-ascii?Q?cjZJR/YYsi830vwI7NBMGGpnVC6xCkpeIzaE4SbmOSsJ8xsA+ZQFq93Np+Zr?=
 =?us-ascii?Q?f+Sk7rtlYF9vN3H131edZ4ZzmAbU+j0DxQ55gmINPxLo8lrlH2I9wTODCZKA?=
 =?us-ascii?Q?3gjAAV6szpc36StWPfPO25PenT+JiVgeb6hHvmWi6+QCuw7MzyYt9uYmkV9D?=
 =?us-ascii?Q?WNb7pij8jAhNcGjWXeb0L7v6OMa2FHkBHoZQ+pUyaZqSMAU7Q1vzJluJvay4?=
 =?us-ascii?Q?hAkm6cGBY6pZNKaoeQxUMOxRh9GuWSq0JA7Zu6Xb9djmGw3cRH5aqWq6mwTz?=
 =?us-ascii?Q?ulf9ZyM2AGAeCOzb4AvA+9OMgGEW39aHp1W8qiZVnsTlBrvzade4o7T3Vzsr?=
 =?us-ascii?Q?ezclcaw8kv7T0RVAV8PXdbCP1RHbg8b/wE1NCLR30/bR11qYM0CYFerKipMm?=
 =?us-ascii?Q?yr07gygl1cytFZO9RCeszGoFCSDuapir6r+s68U8/M+gCCNdqV8QKNwq39WR?=
 =?us-ascii?Q?KapBZRi2dwz6zKD71qKGjwdbogpu/0qqPH6FpSTMSzVn/WZh5leruoNrtwMB?=
 =?us-ascii?Q?B3IB/PlxFOZdJvy7VdCLgDxLC/ytbifU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:41.3300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f988543f-a21f-45c1-3eb8-08dd11485abc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce a new documentation file, `amd_hfi.rst`, which delves into the
implementation details of the AMD Hardware Feedback Interface and its
associated driver, `amd_hfi`. This documentation describes how the
driver provides hint to the OS scheduling which depends on the capability
of core performance and efficiency ranking data.

This documentation describes
* The design of the driver
* How the driver provides hints to the OS scheduling
* How the driver interfaces with the kernel for efficiency ranking data.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/arch/x86/amd-hfi.rst | 127 +++++++++++++++++++++++++++++
 Documentation/arch/x86/index.rst   |   1 +
 2 files changed, 128 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst

diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-hfi.rst
new file mode 100644
index 0000000000000..5d204688470e3
--- /dev/null
+++ b/Documentation/arch/x86/amd-hfi.rst
@@ -0,0 +1,127 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================================
+Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
+======================================================================
+
+:Copyright: 2024 Advanced Micro Devices, Inc. All Rights Reserved.
+
+:Author: Perry Yuan <perry.yuan@amd.com>
+:Author: Mario Limonciello <mario.limonciello@amd.com>
+
+Overview
+--------
+
+AMD Heterogeneous Core implementations are comprised of more than one
+architectural class and CPUs are comprised of cores of various efficiency and
+power capabilities: performance-oriented *classic cores* and power-efficient
+*dense cores*. As such, power management strategies must be designed to
+accommodate the complexities introduced by incorporating different core types.
+Heterogeneous systems can also extend to more than two architectural classes as
+well. The purpose of the scheduling feedback mechanism is to provide
+information to the operating system scheduler in real time such that the
+scheduler can direct threads to the optimal core.
+
+The goal of AMD's heterogeneous architecture is to attain power benefit by sending
+background thread to the dense cores while sending high priority threads to the classic
+cores. From a performance perspective, sending background threads to dense cores can free
+up power headroom and allow the classic cores to optimally service demanding threads.
+Furthermore, the area optimized nature of the dense cores allows for an increasing
+number of physical cores. This improved core density will have positive multithreaded
+performance impact.
+
+AMD Heterogeneous Core Driver
+-----------------------------
+
+The ``amd_hfi`` driver delivers the operating system a performance and energy efficiency
+capability data for each CPU in the system. The scheduler can use the ranking data
+from the HFI driver to make task placement decisions.
+
+Thread Classification and Ranking Table Interaction
+----------------------------------------------------
+
+The thread classification is used to select into a ranking table that describes
+an efficiency and performance ranking for each classification.
+
+Threads are classified during runtime into enumerated classes. The classes represent
+thread performance/power characteristics that may benefit from special scheduling behaviors.
+The below table depicts an example of thread classification and a preference where a given thread
+should be scheduled based on its thread class. The real time thread classification is consumed
+by the operating system and is used to inform the scheduler of where the thread should be placed.
+
+Thread Classification Example Table
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
++----------+----------------+-------------------------------+---------------------+---------+
+| class ID | Classification | Preferred scheduling behavior | Preemption priority | Counter |
++----------+----------------+-------------------------------+---------------------+---------+
+| 0        | Default        | Performant                    | Highest             |         |
++----------+----------------+-------------------------------+---------------------+---------+
+| 1        | Non-scalable   | Efficient                     | Lowest              | PMCx1A1 |
++----------+----------------+-------------------------------+---------------------+---------+
+| 2        | I/O bound      | Efficient                     | Lowest              | PMCx044 |
++----------+----------------+-------------------------------+---------------------+---------+
+
+Thread classification is performed by the hardware each time that the thread is switched out.
+Threads that don't meet any hardware specified criteria will be classified as "default".
+
+AMD Hardware Feedback Interface
+--------------------------------
+
+The Hardware Feedback Interface provides to the operating system information
+about the performance and energy efficiency of each CPU in the system. Each
+capability is given as a unit-less quantity in the range [0-255]. A higher
+performance value indicates higher performance capability, and a higher
+efficiency value indicates more efficiency. Energy efficiency and performance
+are reported in separate capabilities in the shared memory based ranking table.
+
+These capabilities may change at runtime as a result of changes in the
+operating conditions of the system or the action of external factors.
+Power Management FW is responsible for detecting events that would require
+a reordering of the performance and efficiency ranking. Table updates would
+happen relatively infrequently and occur on the time scale of seconds or more.
+
+The following events trigger a table update:
+    * Thermal Stress Events
+    * Silent Compute
+    * Extreme Low Battery Scenarios
+
+The kernel or a userspace policy daemon can use these capabilities to modify
+task placement decisions. For instance, if either the performance or energy
+capabilities of a given logical processor becomes zero, it is an indication that
+the hardware recommends to the operating system to not schedule any tasks on
+that processor for performance or energy efficiency reasons, respectively.
+
+Implementation details for Linux
+--------------------------------
+
+The implementation of threads scheduling consists of the following steps:
+
+1. A thread is spawned and scheduled to the ideal core using the default
+   heterogeneous scheduling policy.
+2. The processor profiles thread execution and assigns an enumerated classification ID.
+   This classification is communicated to the OS via logical processor scope MSR.
+3. During the thread context switch out the operating system consumes the workload(WL)
+   classification which resides in a logical processor scope MSR.
+4. The OS triggers the hardware to clear its history by writing to an MSR,
+   after consuming the WL classification and before switching in the new thread.
+5. If due to the classification, ranking table, and processor availability,
+   the thread is not on its ideal processor, the OS will then consider scheduling
+   the thread on its ideal processor (if available).
+
+Ranking Table
+-------------
+The ranking table is a shared memory region that is used to communicate the
+performance and energy efficiency capabilities of each CPU in the system.
+
+The ranking table design includes rankings for each APIC ID in the system and
+rankings both for performance and efficiency for each workload classification.
+
+.. kernel-doc:: drivers/platform/x86/amd/hfi/hfi.c
+   :doc: amd_shmem_info
+
+Ranking Table update
+---------------------------
+The power management firmware issues an platform interrupt after updating the ranking
+table and is ready for the operating system to consume it. CPUs receive such interrupt
+and read new ranking table from shared memory which PCCT table has provided, then
+``amd_hfi`` driver parse the new table to provide new consume data for scheduling decisions.
diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
index 8ac64d7de4dc9..56f2923f52597 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -43,3 +43,4 @@ x86-specific Documentation
    features
    elf_auxvec
    xstate
+   amd-hfi
-- 
2.43.0


