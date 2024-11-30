Return-Path: <linux-acpi+bounces-9827-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7DD9DF0F8
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE71280F0A
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41B1A9B27;
	Sat, 30 Nov 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QomlhRyH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53741A7271;
	Sat, 30 Nov 2024 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975675; cv=fail; b=lIVvpMpyISy0uiimybNcyALlouMLqh708i0y+ACFBHHE5xpuC10N4WswAHT18Ul4A+N2EUw8f7UJc1r4myKFpd88N+mDCgN3ijdCqqYqzx0vQFyhWEtuXf8fz0Zky3wsMyH+ClYdQ0W6tXObP7a8TBKVa0u6kpJ42sDO+HWHW7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975675; c=relaxed/simple;
	bh=Mv/elKRugYeCY4Rr1u2Vip63588Go70CN6+iTYqb6Os=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kh+b7o5mqjoFG7AUqKKT2isCvH5kQWXf46irLAvzsV2eX+LYfg4UeciFbBYgNJiBdhcOWi5rtc1hgGBtTaFDhyIF1reZhQEdry1cWeuj4UjFzU6R6bGe1WtwV04VBTrJcdeKdbY0LQgy7cLfYCPxVUYDJNteAVb69PMmVwsONss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QomlhRyH; arc=fail smtp.client-ip=40.107.100.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frwfhB53i1ecYWqHVuCZmHo204luyAbmXVCCEGbYSBcqCGPjSttkruF7LupK3AzWkuoNQ2SiK2OJbJXlBiemJLY2NtFTlCUfzW+9Z+EPDYN9jpgeSe+qNRc1Unk8bhzCFXayAon8TXibBVR6a25kO7taoCEMjEs+tPgN4kVkOL5GaoISog/T+5q4zYWcdMcDjqL75bqtEkoRHSTG1/nn41SjobC1F4UpUbSgox0bQAEwAkO+SEbFiUwwJS53G1F4t3LGOoHgSPjG/50UYRhVtELFP/ZoG040MY2Sg6YPsqYbJAj6QKxSrvqpwu+ndIGiPfUNZ5iuQVuZB6zo/eusig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBnR76A1DApi1COQCNWfiO01/rdFBhyA/9yhkZQinVc=;
 b=vH/nif99JSBV/P4xEZxn0bfYmOAwhgFzh1PwdbCp8YC6/oVbXNMkgb9bi5kFhG0tFP2QJf6koDDPDrwoTPNapPBngqLK5IqKDWj2WSdfYDa59QpYyq1+jFHt3XLSm29Ye5K6wpamxt4wDBdZI9ZWp8L3rGZc9QlDxRpKBQtuFNmQZ2063efbuqRYtkK3V7KukJ3A+rFuie84VZjzK8Vj9Qr57S0/mFCIMyIvQCobmuKHvgqfZm1B/RUVtrM+MJ/QO9E6t+OSw4yty2uIMji+1k9nTvKCsZRw/ZMUS2HSqJoVuevOTIlcczy64BJHnAcWRgC6uyRq7oO4hI0uyktkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBnR76A1DApi1COQCNWfiO01/rdFBhyA/9yhkZQinVc=;
 b=QomlhRyHS7826IuE96c42Mj9vMwZHgzoZAgS9BFoMuPlw+nK7m61sL1ZfepLYH76eXh3qx+QlntOuowR4jvdDdMtsC+4wwdJ5wJORCdP77vV/ee2kguag4rj3RF1CeGXpI2y87zDSjcsYrLnt013BZ4/PWII+c73Wd+sokhY5WQ=
Received: from PH7PR17CA0010.namprd17.prod.outlook.com (2603:10b6:510:324::10)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Sat, 30 Nov
 2024 14:07:47 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::a) by PH7PR17CA0010.outlook.office365.com
 (2603:10b6:510:324::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sat,
 30 Nov 2024 14:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:44 -0600
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
	Perry Yuan <Perry.Yuan@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v7 04/12] platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
Date: Sat, 30 Nov 2024 08:06:55 -0600
Message-ID: <20241130140703.557-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d1461d-18cd-4c8f-2cb0-08dd11485df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+6TqqPgfBkDRXb7rWkVHkz9i7gRbA09FE7kAUUDYUU1Ln820+nsCzomQL9Rm?=
 =?us-ascii?Q?ZF/1GaemgtE71jzhY+FevGsu9Fg08eQwlQohe28AJ6L2x6jJmuXO0KxHobBq?=
 =?us-ascii?Q?sXdpXrcBMpHriRkpoK27B0j5gE3xDzsphizsvQa0z+cBOu63VgDC+l4lbGOf?=
 =?us-ascii?Q?dryyQkgtoSIVhCHBTD9fD5CSxHsp16f8GrZ9SRR+uNEHDC/kedRrhYCEvuOu?=
 =?us-ascii?Q?sZ1/KA17XuOSTL+gjRAPBsl0de6rv3O+PsEo+r15/QoHGC/0h7n/L3l6SSDR?=
 =?us-ascii?Q?UKXHQuBfrOi2SpFKLhhmwpDWe2RlzCRQJWp+eaWR2ZcBGlrxeaUL0+xtnzem?=
 =?us-ascii?Q?66CMrJE+ZSq0JknO+UpDb3Baat7PKJNbIFX5QSK+RoKSrgtPF2AAwB+bvxt4?=
 =?us-ascii?Q?6MHTFk+c22W/B4eM1Zjs4q+AwMl1cnPBlS+ggWDvQz7trJg+wC9kVICm81Co?=
 =?us-ascii?Q?My2iICLUPP3RStgylHRMBO48lsBhuq3dt8mKpt1OSTTpexgFONokSeZbd9IL?=
 =?us-ascii?Q?m+YsmIgOP/StLaWXWE2kSH1mFnjyt5N+vpNL5GP5/1jIyi8HwzhrVAD9JjU0?=
 =?us-ascii?Q?jE4rIfobPq48SHYeXLBmUDRT7rCL7OHtbH8DshtN6ditmEZAXxiUwg5MG4LH?=
 =?us-ascii?Q?QSrE8G/aKTllE44OdVa2Sciy6IdgCbLrDHzXRUGJvpLuHAP6vKOf6tFCBiYJ?=
 =?us-ascii?Q?bu2RPzDsggVipr9EuRKRtYI4Z68ZP1AZVVxjRzPwUq5nEmtxfIxsY62nBwEd?=
 =?us-ascii?Q?09RFcdqHSGzos0kaoxVeX9+JYiCMRtEQkqDl4zeBExd9nrA4SQvN2UbaAVHs?=
 =?us-ascii?Q?pjmV0FfzA4hRYEZhZ+zVEPzUr86uIsYCcB1nu+bxorp2f+obXREEZvHTr3wv?=
 =?us-ascii?Q?CwofquTAbkhqf42ioK6t0tiGBzlH3n3vhA+kYFe2KbrK+LXHEFeUAw0v7GJU?=
 =?us-ascii?Q?hVnQGsbgFgAzLvGQSq0qIboa/Sr3zus7Vxfn1ub1BTlzc5RYxWvSBAWX/rN+?=
 =?us-ascii?Q?X4YPMP0T3N9U2Ec/FaITqNLERiwEPkm0t5bd6Nix1S8mR7Hp/WK/Tbd77q7H?=
 =?us-ascii?Q?Vh7/4rgPfblKkm7WGSI3eJTBC7SD6FdoHkRjZZH08F38afB9WIg6MRtqRd2M?=
 =?us-ascii?Q?mlMf4m+SXMrMeZbz5n1eK7IUtZFYIPF2I/XQsDD0QXTaY4mTC4UMojH2ipF4?=
 =?us-ascii?Q?xjbTEs7jnitxiVOoDsvih0JhN8b1iFCPzxh7uc3J0zh6dL8luhmGjPsrnQbY?=
 =?us-ascii?Q?EgkVONv1ijRCMhuc4pWURGMW8ZtqsMz+Xy/ZK1V3hmCCR6R3t8QZU7C/WOt8?=
 =?us-ascii?Q?UWD7b7jQsBqAukqpwICU3mQ9iQwAseTVYQCa+0QVnww5/1blMeLZMYJkmKW5?=
 =?us-ascii?Q?3n3/2nMgFDTVLXzySF7Ehnq0AdjZDphh4cNJ6ofLa+lJgD4PRRUpUoDRLSPi?=
 =?us-ascii?Q?bWc4OHSwRKVFPhtJDt8NYQs3dUaJ4yfL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:46.7363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d1461d-18cd-4c8f-2cb0-08dd11485df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

From: Perry Yuan <Perry.Yuan@amd.com>

The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
provide behavioral classification and a dynamically updated ranking table
for the scheduler to use when choosing cores for tasks.

There are two CPU core types defined: `Classic Core` and `Dense Core`.
"Classic" cores are the standard performance cores, while "Dense" cores
are optimized for area and efficiency.

Heterogeneous compute refers to CPU implementations that are comprised
of more than one architectural class, each with two capabilities. This
means each CPU reports two separate capabilities: "perf" and "eff".

Each capability lists all core ranking numbers between 0 and 255, where
a higher number represents a higher capability.

Heterogeneous systems can also extend to more than two architectural
classes.

The purpose of the scheduling feedback mechanism is to provide information
to the operating system scheduler in real time, allowing the scheduler to
direct threads to the optimal core during task scheduling.

All core ranking data are provided by the PMFW via a shared memory ranking
table, which the driver reads and uses to update core capabilities to the
scheduler. When the hardware updates the table, it generates a platform
interrupt to notify the OS to read the new ranking table.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Adjust Kconfig to 80 characters
---
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  20 ++++
 drivers/platform/x86/amd/hfi/Makefile |   7 ++
 drivers/platform/x86/amd/hfi/hfi.c    | 161 ++++++++++++++++++++++++++
 5 files changed, 190 insertions(+)
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index c3e086ea64fc6..589d61ebf726b 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -6,6 +6,7 @@
 source "drivers/platform/x86/amd/hsmp/Kconfig"
 source "drivers/platform/x86/amd/pmf/Kconfig"
 source "drivers/platform/x86/amd/pmc/Kconfig"
+source "drivers/platform/x86/amd/hfi/Kconfig"
 
 config AMD_3D_VCACHE
 	tristate "AMD 3D V-Cache Performance Optimizer Driver"
diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index 56f62fc9c97b4..c50e93c3334cf 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)		+= pmc/
 obj-$(CONFIG_AMD_HSMP)		+= hsmp/
 obj-$(CONFIG_AMD_PMF)		+= pmf/
 obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
+obj-$(CONFIG_AMD_HFI)		+= hfi/
diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
new file mode 100644
index 0000000000000..532939eb08a6a
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AMD Hardware Feedback Interface Driver
+#
+
+config AMD_HFI
+	bool "AMD Hetero Core Hardware Feedback Driver"
+	depends on ACPI
+	depends on CPU_SUP_AMD
+	help
+	 Select this option to enable the AMD Heterogeneous Core Hardware
+	 Feedback Interface. If selected, hardware provides runtime thread
+	 classification guidance to the operating system on the performance and
+	 energy efficiency capabilities of each heterogeneous CPU core. These
+	 capabilities may vary due to the inherent differences in the core types
+	 and can also change as a result of variations in the operating
+	 conditions of the system such as power and thermal limits. If selected,
+	 the kernel relays updates in heterogeneous CPUs' capabilities to
+	 userspace, allowing for more optimal task scheduling and resource
+	 allocation, leveraging the diverse set of cores available.
diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
new file mode 100644
index 0000000000000..672c6ac106e95
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# AMD Hardware Feedback Interface Driver
+#
+
+obj-$(CONFIG_AMD_HFI) += amd_hfi.o
+amd_hfi-objs := hfi.o
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
new file mode 100644
index 0000000000000..2cd71d79a22c9
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Hardware Feedback Interface Driver
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Authors: Perry Yuan <Perry.Yuan@amd.com>
+ *          Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#define pr_fmt(fmt)  "amd-hfi: " fmt
+
+#include <linux/acpi.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/smp.h>
+
+#define AMD_HFI_DRIVER		"amd_hfi"
+#define AMD_HETERO_CPUID_27	0x80000027
+static struct platform_device *device;
+
+struct amd_hfi_data {
+	const char	*name;
+	struct device	*dev;
+	struct mutex	lock;
+};
+
+struct amd_hfi_classes {
+	u32	perf;
+	u32	eff;
+};
+
+/**
+ * struct amd_hfi_cpuinfo - HFI workload class info per CPU
+ * @cpu:		cpu index
+ * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
+ * @class_index:	workload class ID index
+ * @nr_class:		max number of workload class supported
+ * @amd_hfi_classes:	current cpu workload class ranking data
+ *
+ * Parameters of a logical processor linked with hardware feedback class
+ */
+struct amd_hfi_cpuinfo {
+	int		cpu;
+	cpumask_var_t	cpus;
+	s16		class_index;
+	u8		nr_class;
+	struct amd_hfi_classes	*amd_hfi_classes;
+};
+
+static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
+
+static int amd_hfi_alloc_class_data(struct platform_device *pdev)
+{
+	struct amd_hfi_cpuinfo *hfi_cpuinfo;
+	struct device *dev = &pdev->dev;
+	int idx;
+	int nr_class_id;
+
+	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
+	if (nr_class_id < 0 || nr_class_id > 255) {
+		dev_err(dev, "failed to get number of supported classes: %d\n",
+			nr_class_id);
+		return -EINVAL;
+	}
+
+	for_each_present_cpu(idx) {
+		struct amd_hfi_classes *classes;
+
+		classes = devm_kzalloc(dev,
+				       nr_class_id * sizeof(struct amd_hfi_classes),
+				       GFP_KERNEL);
+		if (!classes)
+			return -ENOMEM;
+		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
+		hfi_cpuinfo->amd_hfi_classes = classes;
+		hfi_cpuinfo->nr_class = nr_class_id;
+	}
+
+	return 0;
+}
+
+static const struct acpi_device_id amd_hfi_platform_match[] = {
+	{"AMDI0104", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
+
+static int amd_hfi_probe(struct platform_device *pdev)
+{
+	struct amd_hfi_data *amd_hfi_data;
+	int ret;
+
+	if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
+		return -ENODEV;
+
+	amd_hfi_data = devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data), GFP_KERNEL);
+	if (!amd_hfi_data)
+		return -ENOMEM;
+
+	amd_hfi_data->dev = &pdev->dev;
+	ret = devm_mutex_init(&pdev->dev, &amd_hfi_data->lock);
+	if (ret)
+		return ret;
+	platform_set_drvdata(pdev, amd_hfi_data);
+
+	ret = amd_hfi_alloc_class_data(pdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct platform_driver amd_hfi_driver = {
+	.driver = {
+		.name = AMD_HFI_DRIVER,
+		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
+	},
+	.probe = amd_hfi_probe,
+};
+
+static int __init amd_hfi_init(void)
+{
+	int ret;
+
+	if (acpi_disabled ||
+	    !cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES) ||
+	    !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		return -ENODEV;
+
+	device = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
+	if (IS_ERR(device)) {
+		pr_err("unable to register HFI platform device\n");
+		return PTR_ERR(device);
+	}
+
+	ret = platform_driver_register(&amd_hfi_driver);
+	if (ret)
+		pr_err("failed to register HFI driver\n");
+
+	return ret;
+}
+
+static __exit void amd_hfi_exit(void)
+{
+	platform_device_unregister(device);
+	platform_driver_unregister(&amd_hfi_driver);
+}
+module_init(amd_hfi_init);
+module_exit(amd_hfi_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");
-- 
2.43.0


