Return-Path: <linux-acpi+bounces-3497-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE88553A4
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 21:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF4D1F2AD10
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 20:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E1613DB91;
	Wed, 14 Feb 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4CXqTQhv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF613A888;
	Wed, 14 Feb 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941281; cv=fail; b=Nu8Mg1qD435Emw8WjFEgYLHNWUsrRvElM+DQ6Gokp37J7EZwrZ1jPnvofk0c1yQav8mCKa2bGq0lDPtYOM/KVP24oTbeBRm7Qp9oM4wCoEIFcSNiU/qZguCu0cT0oQF6FIWvgPigFT95ybb1Jm7Nncqyr/1hOjgX2P4Z7vd82o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941281; c=relaxed/simple;
	bh=1vWE0a2PncP4oo80frN3/PAYSqZKS5J7QHSL8WDpoJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwtqkVWU23H5OWYPc2F+ESkhIX2YS/0+M1dUBUkbXHiXYxhYghWaKAWkCR3QyY6ULRVUVs9LLBqYefpLydPHJS1QsnqOQ0PH0q0AaiddLd/VQVmPszpKAprhDTeMdZSK3WQFiCitM9n1K7yHS7y5ZeJrB6bbHU9Q04BnlY/kplY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4CXqTQhv; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx8JNCGhO2xTHQvH3SwVieavHg0OzNh1NHVdlr5ZL08/+Q4oLckp8vm+gKTAmH0gnu8FbFHj4RJkMq5FdlR/M2HDElNjt/ClRGmxavfZFz9jsnn+KUsxdAM6Tl0pxjXdAIZ2r0VpXOROrU2ndvJD7OY4/B4siav3Nnnf31gn02k7wbzemBovulASGKvgxR7+zwnM3TI2smzFVFkrz40Iac8ZG7xdVazF4KHi/LPnwNSl8PW2bAv2xeK/3xgG8M9H3yyyX+o04lZtsOAb6DhlwMQgw9DTS2hGZLzotUiwZIh9Qsms/AmnGGOtXF6FPaiIgmuuHAoDSwRO8sz40BxdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUfLq69SphqwKIjWG/xpOGM5OPP2H79YD5UClP1/Rxo=;
 b=RkWPRuAD2vrcln34UVBLo2Oh4EFVrDae6uRfItV2do5yKG3zqLt79+ioAd14ze8YoEFxqUdin2ejlau9911j2wUBp+aUoU3SEPkxkAul10+lO/fLrgh8NCz6Ahb9zopo2GoCHebdc7CIb5H8adjxiHguleu00C19ljt4ZBwoKHSIGfl1c8HVLJ64EQUSs+GzOuCNGOUfZm/TiteRW65vZQaIh5pcnkoz4+E0guc3uX5fsc738UwfDq8hUFhUcqm8eVKUZvM78SkJT5OowUcl3JVc/l3f5LpKkiyWUo73jK11zYmtVp1r5dalh/zJXgeA5mA/48LG3Nsk4VXeipJxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUfLq69SphqwKIjWG/xpOGM5OPP2H79YD5UClP1/Rxo=;
 b=4CXqTQhvqRb9ryVy5BiZkzCB8Ts3wRouv2vcNDm+ZTubYRzbFJn3ah7o1LoHyxEkXlJZc2HSXiy5U6Xr3NSLKxyIUcXS+CvXoDwl2LIjJqMBzCsRrp7KIBC8XI0temx4TKdrTLJoHbtWESykou0m2XB2AGd6t8Q8lFN4+aIyRsA=
Received: from CH0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:610:77::8)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 20:07:56 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::83) by CH0PR04CA0033.outlook.office365.com
 (2603:10b6:610:77::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 20:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 20:07:55 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:07:52 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v12 2/3] cxl/core, EINJ: Add EINJ CXL debugfs files and EINJ helper functions
Date: Wed, 14 Feb 2024 14:07:08 -0600
Message-ID: <20240214200709.777166-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 816d9a1f-d66b-4ad2-8f94-08dc2d98a21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2IDx9aOopR0qMFCJVUFwDD7b1dE39nMZ8nNHpw+3MRFz2mPt6PFTplniml+XKnv4E2eS12knRBHf8NTGMUZx+/d71sflrLwAvm5Sdw8t8nQ1z5s5wbAAgYgWT/Vq6LzlnsLL9iz7WxTVStWWclZdFr5fTrlne2ryRpa6l/CKLgXSm+bWgQUXDXHbJ7+qzw5tCiCQgCu6BsZJq3tuDrKOHgu75y7v3xGsWwIDqlfo7DRuoNIlIerzwjDLG51GTkJsF8ANQN4n8GVi2s7ETV9GjMCGXwjw12yE2cR5MjqqdXOVBdsAqeRlyq0ObKlupTCPeiN0WEcObfJxU7zSnkKLbzlPeUIVCSMydMbY+aZXQOElj4jsbQt1D2xVAJ7JHu/N8rK47gYF9nz2F+y9sMVWQVVftvHBUHYwDozzKgRjsZGS2tlgQM/D5M0p8oxVB5xFex3sxrbwl//AnhOTZxHDXdrMkMDCHFa0K6SqwCPShWgeFj5azDLNThFXjJ8UBHSzZebLMm6ejNpFId0mhqzVYmZ+i0t4X+Eggn7dYrge4Kwr2uFytMaSl6Lxm6ZJ0D1C8qzo7y/d3lGmqKERAwNmfTw4dflblCIjB3RPDZ82fh8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(5660300002)(8676002)(2906002)(30864003)(7416002)(4326008)(8936002)(336012)(426003)(83380400001)(356005)(1076003)(16526019)(26005)(82740400003)(36756003)(86362001)(81166007)(54906003)(70206006)(70586007)(316002)(110136005)(2616005)(7696005)(6666004)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:07:55.7242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816d9a1f-d66b-4ad2-8f94-08dc2d98a21f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

Implement CXL helper functions in the EINJ module for getting/injecting
available CXL protocol error types and export them to sysfs under
kernel/debug/cxl.

The kernel/debug/cxl/einj_types file will print the available CXL
protocol errors in the same format as the available_error_types
file provided by the EINJ module. The
kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
error_type and error_inject files provided by the EINJ module, i.e.:
writing an error type into $dport_dev/einj_inject will inject said error
type into the CXL dport represented by $dport_dev.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/debugfs-cxl |  30 +++++
 MAINTAINERS                           |   1 +
 drivers/acpi/apei/einj.c              | 158 ++++++++++++++++++++++++--
 drivers/cxl/Kconfig                   |  12 ++
 drivers/cxl/core/port.c               |  41 +++++++
 include/linux/einj-cxl.h              |  40 +++++++
 6 files changed, 271 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/einj-cxl.h

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index fe61d372e3fa..4c0f62f881ca 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -33,3 +33,33 @@ Description:
 		device cannot clear poison from the address, -ENXIO is returned.
 		The clear_poison attribute is only visible for devices
 		supporting the capability.
+
+What:		/sys/kernel/debug/cxl/einj_types
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Prints the CXL protocol error types made available by
+		the platform in the format "0x<error number>	<error type>".
+		The possible error types are (as of ACPI v6.5):
+			0x1000	CXL.cache Protocol Correctable
+			0x2000	CXL.cache Protocol Uncorrectable non-fatal
+			0x4000	CXL.cache Protocol Uncorrectable fatal
+			0x8000	CXL.mem Protocol Correctable
+			0x10000	CXL.mem Protocol Uncorrectable non-fatal
+			0x20000	CXL.mem Protocol Uncorrectable fatal
+
+		The <error number> can be written to einj_inject to inject
+		<error type> into a chosen dport.
+
+What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Writing an integer to this file injects the corresponding
+		CXL protocol error into $dport_dev ($dport_dev will be a device
+		name from /sys/bus/pci/devices). The integer to type mapping for
+		injection can be found by reading from einj_types. If the dport
+		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
+		a CXL 2.0 error is injected.
diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..0980ed116dc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5291,6 +5291,7 @@ S:	Maintained
 F:	drivers/cxl/
 F:	include/linux/cxl-event.h
 F:	include/uapi/linux/cxl_mem.h
+F:  include/linux/einj-cxl.h
 F:	tools/testing/cxl/
 
 COMPUTE EXPRESS LINK PMU (CPMU)
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 4782ae0a0832..ab729a12dd7f 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -21,6 +21,7 @@
 #include <linux/nmi.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/einj-cxl.h>
 #include <linux/platform_device.h>
 #include <asm/unaligned.h>
 
@@ -37,6 +38,20 @@
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
 				ACPI_EINJ_MEMORY_FATAL)
+#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
+#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
+#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
+#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
+#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
+#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
+#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
+#endif
+#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_FATAL | \
+				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_FATAL)
 
 /*
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
@@ -560,8 +575,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
@@ -613,13 +631,16 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(9), "Platform Correctable" },
 	{ BIT(10), "Platform Uncorrectable non-fatal" },
 	{ BIT(11), "Platform Uncorrectable fatal"},
+	{ BIT(31), "Vendor Defined Error Types" },
+};
+
+static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
 	{ BIT(12), "CXL.cache Protocol Correctable" },
 	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
 	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
 	{ BIT(15), "CXL.mem Protocol Correctable" },
 	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
 	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
-	{ BIT(31), "Vendor Defined Error Types" },
 };
 
 static int available_error_type_show(struct seq_file *m, void *v)
@@ -640,29 +661,46 @@ static int available_error_type_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
-static int error_type_get(void *data, u64 *val)
+int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 {
-	*val = error_type;
+	int cxl_err, rc;
+	u32 available_error_type = 0;
+
+	if (!einj_initialized)
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
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
 
-static int error_type_set(void *data, u64 val)
+static int validate_error_type(u64 type)
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
@@ -671,9 +709,101 @@ static int error_type_set(void *data, u64 val)
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
+static bool is_cxl_error_type(u64 type)
+{
+	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
+}
+
+int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
+{
+	int rc;
+
+	if (!einj_initialized)
+		return -ENXIO;
+
+	/* Only CXL error types can be specified */
+	if (!is_cxl_error_type(type))
+		return -EINVAL;
+
+	rc = validate_error_type(type);
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
+	if (!einj_initialized)
+		return -ENXIO;
+
+	/* Only CXL error types can be specified */
+	if (!is_cxl_error_type(type))
+		return -EINVAL;
+
+	rc = validate_error_type(type);
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
+	if (is_cxl_error_type(val))
+		return -EINVAL;
+
+	rc = validate_error_type(val);
+	if (rc)
+		return rc;
+
 	error_type = val;
 
 	return 0;
@@ -709,6 +839,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
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
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 67998dbd1d46..d1fc3ce31fbb 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -157,4 +157,16 @@ config CXL_PMU
 	  monitoring units and provide standard perf based interfaces.
 
 	  If unsure say 'm'.
+
+config CXL_EINJ
+	bool "CXL Error INJection Support"
+	default ACPI_APEI_EINJ
+	depends on ACPI_APEI_EINJ = CXL_BUS
+	help
+	  Support for CXL protocol Error INJection through debugfs/cxl.
+	  Availability and which errors are supported is dependent on
+	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
+	  EINJ documentation for more information.
+
+	  If unsure say 'n'
 endif
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..3700700c4e0c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -3,6 +3,7 @@
 #include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/workqueue.h>
+#include <linux/einj-cxl.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -793,6 +794,39 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	return rc;
 }
 
+DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
+
+static int cxl_einj_inject(void *data, u64 type)
+{
+	struct cxl_dport *dport = data;
+
+	if (dport->rch)
+		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
+
+	return einj_cxl_inject_error(to_pci_dev(dport->dport_dev), type);
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
+
+static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
+{
+	struct dentry *dir;
+
+	if (!einj_is_initialized())
+		return;
+
+	/*
+	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
+	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
+	 */
+	if (!dport->rch && !dev_is_pci(dport->dport_dev))
+		return;
+
+	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
+
+	debugfs_create_file("einj_inject", 0200, dir, dport,
+			    &cxl_einj_inject_fops);
+}
+
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport_dev,
 					    resource_size_t component_reg_phys,
@@ -1149,6 +1183,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (dev_is_pci(dport_dev))
 		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
 
+	cxl_debugfs_create_dport_dir(dport);
+
 	return dport;
 }
 
@@ -2221,6 +2257,11 @@ static __init int cxl_core_init(void)
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
+	if (einj_is_initialized()) {
+		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
+				    &einj_cxl_available_error_type_fops);
+	}
+
 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
new file mode 100644
index 000000000000..92c0e2e37ad9
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
+#ifndef CXL_EINJ_H
+#define CXL_EINJ_H
+
+#include <linux/pci.h>
+
+#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
+int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
+int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
+int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
+bool einj_is_initialized(void);
+#else // !IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
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
+static inline bool einj_is_initialized(void) { return false; }
+#endif // CONFIG_ACPI_APEI_EINJ
+
+#endif // CXL_EINJ_H
-- 
2.34.1


