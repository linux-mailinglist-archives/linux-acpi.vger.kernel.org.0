Return-Path: <linux-acpi+bounces-3738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0AC85CA81
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C4B2836F0
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 22:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E76152E05;
	Tue, 20 Feb 2024 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PAKsfxIl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6F151CCC;
	Tue, 20 Feb 2024 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467164; cv=fail; b=UuuhTLUXAc9ADYvAcAdV0xRDKnFAxLxpuHD3Geg7frvmslhaG9GDHH50359XI47wf9dS+e4cb/W1Aivxk8XP2KXiT/MeIiNHXZddipoUhGoJMBCn3+gugCylmXOxD4v4vLjLAKyqLyalt9FUpODLKOseJKdHERb3GcZFSIwwboI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467164; c=relaxed/simple;
	bh=et5DZ7n5KORvAoiDtJ0JUBn8tVnFZkzDj3nF+Usp6D8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gabuWme6i5ZhmGAKvtgHyCWpV/YMgM7RUm7BshdFUjOpXkdN/Nnk+FXBJ7NRbqgcqiwdOnr6Kjv3x/GMqihMTY01lB26d8Ql9fukFSWm85dof8i2f5eT4xhL6sjs/hl2fQqQfQWbuynwB20JKqkuvA6EMDxnpMSOiWQi1O37hek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PAKsfxIl; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE7wSBtQg/cqTw6yqJyNK78WlEBknpdl3ftIuFtqmaNpTVxyJbR3pKJXhYnFDJDJ/4IWwzclGDF0PyfdMCmkUxOTiBqqt6QEhpSksk0GWYXICFiN9qziR2619BDGqcQotr0EGtqdHahckaCyOwMWyCw2NVwNX9Gp4Fjefa9Dxkqizz2MEVmGqxOKPQOr7PH2w0UUivxlERdmjw9wFUXW5wgkc6sk9LjA1FRczq9SFAk+YJQ/PsJ2pDBXzogje6HA6uFJ7iROj+9j/91nxHBsoHe5CmdYiU/eFRzz7UVPuIMG3TQ2xutSSJiSmYwB4FKTNGuSAYKEbll8BgZzfXdJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVQFvhScXI5bqgJiH88CNkIi9A9QmQibdv+hvsNLiDE=;
 b=m63H+/yraLba6NzDqO0FQaOCo1IwjQu57qa6ollpRfkUdO5Fk2djY9FrFTrXNErDwwofhZ0jlstLTkjxV94ArwGLz1AlnX1Jka/ZcJCmGCI5Lhd922jAZx/0w003Ii/CnkPOmNrWfMicKpeA/+S13GO18DZrlH5WK38soXpEaNZl2tJH+I4nTbRVex7IIxhuBvYJfJKL/DXbzUd+kZNcFiXrAVQPLBjksZd3NXc+SQA/ZldDSO+vGMzMDd3cAemsRCB9Z3H+Le2JiHrxu3IKgwQURJDOHjulOqwQCnO997W4Y+Yge6rzo0upmedezMFLzlf8Dq4+x4N6EHOb68B+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVQFvhScXI5bqgJiH88CNkIi9A9QmQibdv+hvsNLiDE=;
 b=PAKsfxIlvHtkbFjieWXUa4ISM7baVVCFB/uc0HKnNepx1mDY1twXOI1emFNdTriXikCsGkb09lRA1A/H1sYzae9vbu1TW0g9XPjpv0RZNYtQN7eyvG3UzgZ9cqrSIn2E9Mw9PPlaLDi2Dyx/ZVsIKN+TzPwt/iiKRs+0kQ3i7p8=
Received: from PR1P264CA0043.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::20)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 22:12:39 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10a6:102:2cb:cafe::aa) by PR1P264CA0043.outlook.office365.com
 (2603:10a6:102:2cb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 22:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 22:12:37 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 16:12:29 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v13 2/4] EINJ: Add CXL error type support
Date: Tue, 20 Feb 2024 16:11:44 -0600
Message-ID: <20240220221146.399209-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: bce564b3-5284-4340-a40d-08dc32610be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QWjigG1sflX/nOgM2UNuK+gu90teDvUvKYT3FXHhfF7ZZJQFvHDbAgU3GxzVizU4otExgbDAAFJ7/DfkiNHj9tTlz563w1cDBmlna8axAj/O0n9sKZ9yZiZl6FH7EBMORiAJDMsb18yloUF4TlOcnHoGJp8WfJGhJVFLa2FTFcjrFX7Vy/qK6UXTwAgqNqfyOn7UYhRp/oGiy/vli90m1LduQNr9bn19Jyc/teOlLYxqGhGS2IzitJHpLVViWn32M5tL8Rk8Qw694sVA8O6xgPisF7uc9qBQ1rdt/kSNGYruK6xK0RBF85GE+2BXuweSPSjchDBTa9ZnI7ocB3xqA/5XFmYOLbQCxKatVvjOtJ6S3DYtNAsDK6n/MoukGtSYSeKsF3/BQRMtHe4OJUS6yPE5BZ1Imh438o3jBkSzp1S9vFFPVKd7372yv8LY6S9RBdRL/qZf47IlVsH4DUD5tPVZkafG35tRLaxoJ0rWyNzrwGzMXcGJ1R5+Imufd+sXl0w22h5oL+jr9GHvQrqaYXlm8Thhj+ATmf0D8jQsXPxQd8Qn4SKGhaJ/fFunk6wEiD+tBTaYzhjxAx/RaMpFF6vANLP34QC2Wp7OIGGNwrAXd9umvMKcIu7QHnAlmzuMkjV6EyGLBiGMgEXopqyw0K84596Tfdiv8LH6H0YhvIg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:12:37.1827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bce564b3-5284-4340-a40d-08dc32610be3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230

Remove CXL protocol error types from the EINJ module and move them to
a new einj_cxl module. The einj_cxl module implements the necessary
handling for CXL protocol error injection and exposes an API for the
CXL core to use said functionality. Because the CXL error types
require special handling, only allow them to be injected through the
einj_cxl module and return an error when attempting to inject through
"regular" EINJ.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 MAINTAINERS                       |   1 +
 drivers/acpi/apei/Kconfig         |  12 +++
 drivers/acpi/apei/Makefile        |   1 +
 drivers/acpi/apei/apei-internal.h |  17 +++++
 drivers/acpi/apei/einj-cxl.c      | 121 ++++++++++++++++++++++++++++++
 drivers/acpi/apei/einj.c          |  81 ++++++++++++++------
 include/linux/einj-cxl.h          |  40 ++++++++++
 7 files changed, 249 insertions(+), 24 deletions(-)
 create mode 100644 drivers/acpi/apei/einj-cxl.c
 create mode 100644 include/linux/einj-cxl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..51f9a0da57d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5289,6 +5289,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	drivers/cxl/
+F:	include/linux/cxl-einj.h
 F:	include/linux/cxl-event.h
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 6b18f8bc7be3..040a9b2de235 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -60,6 +60,18 @@ config ACPI_APEI_EINJ
 	  mainly used for debugging and testing the other parts of
 	  APEI and some other RAS features.
 
+config ACPI_APEI_EINJ_CXL
+	tristate "CXL Error INJection Support"
+	default ACPI_APEI_EINJ
+	depends on ACPI_APEI_EINJ
+	help
+	  Support for CXL protocol Error INJection through debugfs/cxl.
+	  Availability and which errors are supported is dependent on
+	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
+	  EINJ documentation for more information.
+
+	  If unsure say 'n'
+
 config ACPI_APEI_ERST_DEBUG
 	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
 	depends on ACPI_APEI
diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 4dfac2128737..c18e96d342b2 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
 obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
+obj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
 obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
 
 apei-y := apei-base.o hest.o erst.o bert.o
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 67c2c3b959e1..336408f4f293 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -130,4 +130,21 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 }
 
 int apei_osc_setup(void);
+
+int einj_get_available_error_type(u32 *type);
+int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
+		      u64 param4);
+bool einj_is_initialized(void);
+bool einj_is_cxl_error_type(u64 type);
+int einj_validate_error_type(u64 type);
+
+#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
+#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
+#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
+#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
+#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
+#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
+#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
+#endif
+
 #endif
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
new file mode 100644
index 000000000000..607d4f6adb98
--- /dev/null
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CXL Error INJection support. Used by CXL core to inject
+ * protocol errors into CXL ports.
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Ben Cheatham <benjamin.cheatham@amd.com>
+ */
+#include <linux/einj-cxl.h>
+#include <linux/debugfs.h>
+
+#include "apei-internal.h"
+
+static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
+	{ BIT(12), "CXL.cache Protocol Correctable" },
+	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
+	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
+	{ BIT(15), "CXL.mem Protocol Correctable" },
+	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
+	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
+};
+
+int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
+{
+	int cxl_err, rc;
+	u32 available_error_type = 0;
+
+	if (!einj_is_initialized())
+		return -ENXIO;
+
+	rc = einj_get_available_error_type(&available_error_type);
+	if (rc)
+		return rc;
+
+	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
+		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
+
+		if (available_error_type & cxl_err)
+			seq_printf(m, "0x%08x\t%s\n",
+				   einj_cxl_error_type_string[pos].mask,
+				   einj_cxl_error_type_string[pos].str);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
+
+static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
+{
+	struct pci_bus *pbus;
+	struct pci_host_bridge *bridge;
+	u64 seg = 0, bus;
+
+	pbus = dport_dev->bus;
+	bridge = pci_find_host_bridge(pbus);
+
+	if (!bridge)
+		return -ENODEV;
+
+	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
+		seg = bridge->domain_nr;
+
+	bus = pbus->number;
+	*sbdf = (seg << 24) | (bus << 16) | dport_dev->devfn;
+
+	return 0;
+}
+
+int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
+{
+	int rc;
+
+	if (!einj_is_initialized())
+		return -ENXIO;
+
+	/* Only CXL error types can be specified */
+	if (!einj_is_cxl_error_type(type))
+		return -EINVAL;
+
+	rc = einj_validate_error_type(type);
+	if (rc)
+		return rc;
+
+	return einj_error_inject(type, 0x2, rcrb, GENMASK_ULL(63, 12), 0, 0);
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
+
+int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
+{
+	u64 param4 = 0;
+	int rc;
+
+	if (!einj_is_initialized())
+		return -ENXIO;
+
+	/* Only CXL error types can be specified */
+	if (!einj_is_cxl_error_type(type))
+		return -EINVAL;
+
+	rc = einj_validate_error_type(type);
+	if (rc)
+		return rc;
+
+	rc = cxl_dport_get_sbdf(dport, &param4);
+	if (rc)
+		return rc;
+
+	return einj_error_inject(type, 0x4, 0, 0, 0, param4);
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
+
+bool einj_cxl_is_initialized(void)
+{
+	return einj_is_initialized();
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_is_initialized, CXL);
+
+MODULE_AUTHOR("Ben Cheatham");
+MODULE_DESCRIPTION("CXL Error INJection support");
+MODULE_LICENSE("GPL");
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 6ea323b9d8ef..e76e64df97a7 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -37,6 +37,12 @@
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
 				ACPI_EINJ_MEMORY_FATAL)
+#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_FATAL | \
+				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_FATAL)
 
 /*
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
@@ -166,7 +172,7 @@ static int __einj_get_available_error_type(u32 *type)
 }
 
 /* Get error injection capabilities of the platform */
-static int einj_get_available_error_type(u32 *type)
+int einj_get_available_error_type(u32 *type)
 {
 	int rc;
 
@@ -176,6 +182,7 @@ static int einj_get_available_error_type(u32 *type)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(einj_get_available_error_type);
 
 static int einj_timedout(u64 *t)
 {
@@ -536,8 +543,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 }
 
 /* Inject the specified hardware error */
-static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
-			     u64 param3, u64 param4)
+int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
+		      u64 param4)
 {
 	int rc;
 	u64 base_addr, size;
@@ -560,8 +567,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (type & ACPI5_VENDOR_BIT) {
 		if (vendor_flags != SETWA_FLAGS_MEM)
 			goto inject;
-	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
+	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
 		goto inject;
+	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
+		goto inject;
+	}
 
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
@@ -592,6 +602,7 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(einj_error_inject);
 
 static u32 error_type;
 static u32 error_flags;
@@ -613,12 +624,6 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(9), "Platform Correctable" },
 	{ BIT(10), "Platform Uncorrectable non-fatal" },
 	{ BIT(11), "Platform Uncorrectable fatal"},
-	{ BIT(12), "CXL.cache Protocol Correctable" },
-	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
-	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
-	{ BIT(15), "CXL.mem Protocol Correctable" },
-	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
-	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
 	{ BIT(31), "Vendor Defined Error Types" },
 };
 
@@ -640,29 +645,21 @@ static int available_error_type_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
-static int error_type_get(void *data, u64 *val)
-{
-	*val = error_type;
-
-	return 0;
-}
-
-static int error_type_set(void *data, u64 val)
+int einj_validate_error_type(u64 type)
 {
+	u32 tval, vendor, available_error_type = 0;
 	int rc;
-	u32 available_error_type = 0;
-	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
-	if (val & GENMASK_ULL(63, 32))
+	if (type & GENMASK_ULL(63, 32))
 		return -EINVAL;
 
 	/*
 	 * Vendor defined types have 0x80000000 bit set, and
 	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
 	 */
-	vendor = val & ACPI5_VENDOR_BIT;
-	tval = val & 0x7fffffff;
+	vendor = type & ACPI5_VENDOR_BIT;
+	tval = type & GENMASK(30, 0);
 
 	/* Only one error type can be specified */
 	if (tval & (tval - 1))
@@ -671,9 +668,39 @@ static int error_type_set(void *data, u64 val)
 		rc = einj_get_available_error_type(&available_error_type);
 		if (rc)
 			return rc;
-		if (!(val & available_error_type))
+		if (!(type & available_error_type))
 			return -EINVAL;
 	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(einj_validate_error_type);
+
+bool einj_is_cxl_error_type(u64 type)
+{
+	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
+}
+EXPORT_SYMBOL_GPL(einj_is_cxl_error_type);
+
+static int error_type_get(void *data, u64 *val)
+{
+	*val = error_type;
+
+	return 0;
+}
+
+static int error_type_set(void *data, u64 val)
+{
+	int rc;
+
+	/* CXL error types have to be injected from cxl debugfs */
+	if (einj_is_cxl_error_type(val))
+		return -EINVAL;
+
+	rc = einj_validate_error_type(val);
+	if (rc)
+		return rc;
+
 	error_type = val;
 
 	return 0;
@@ -709,6 +736,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
+bool einj_is_initialized(void)
+{
+	return einj_initialized;
+}
+EXPORT_SYMBOL_GPL(einj_is_initialized);
+
 static int __init einj_probe(struct platform_device *pdev)
 {
 	int rc;
diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
new file mode 100644
index 000000000000..4a1f4600539a
--- /dev/null
+++ b/include/linux/einj-cxl.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CXL protocol Error INJection support.
+ *
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Ben Cheatham <benjamin.cheatham@amd.com>
+ */
+#ifndef EINJ_CXL_H
+#define EINJ_CXL_H
+
+#include <linux/pci.h>
+
+#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL)
+int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
+int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
+int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
+bool einj_cxl_is_initialized(void);
+#else /* !IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL) */
+static inline int einj_cxl_available_error_type_show(struct seq_file *m,
+						     void *v)
+{
+	return -ENXIO;
+}
+
+static inline int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type)
+{
+	return -ENXIO;
+}
+
+static inline int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
+{
+	return -ENXIO;
+}
+
+static inline bool einj_cxl_is_initialized(void) { return false; }
+#endif /* CONFIG_ACPI_APEI_EINJ_CXL */
+
+#endif /* EINJ_CXL_H */
-- 
2.34.1


