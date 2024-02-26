Return-Path: <linux-acpi+bounces-3961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF0A8683B9
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 23:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21B028BE6A
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 22:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE170132C30;
	Mon, 26 Feb 2024 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VkbNiS16"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37AE132C2E;
	Mon, 26 Feb 2024 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986478; cv=fail; b=YzCT06N/x3+zeZ3yHEEuh5j3v0XzHgshWA6VeH4Nsz4UUtZOsq+/F9Hie9AX/q8X640YntUKJw+wC3mJky8VPUOSM4IJ53XDgYTP6hPznB8YMQTokYkdrWZ0FZULkdMe2O1yODXsT6rISLjI/1KjT8IDnLh4oOTxtAVgyUicg5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986478; c=relaxed/simple;
	bh=bSkeKSHBNvKfA17GX7h08MgEzqdmbqyhtPyhTavKUbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDqxFEGAK2MShFTrUOvcHV4EaTOkZEZma+xwXkb3SCcc5MkhxG+XuhD4FoF/wr8uKUsUjUFiqaCAci0SHW//rzju/Cs9RYsFTCMOXJineDMJ8pIwPycZpAjTWZcbI4DYVPK42Py/oTB1WwPZUwtnmjQO5/U5zxJNeMhddDl3GU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VkbNiS16; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S15Ofp44Y7aDqOvV3D3G8Vz/VArEfv6hrmfrPn4G84h4Bf2DUTG9A89lMEFG+yxPsxUkaffylfNpvx+yGN9RMi7fgWf8OPxDCe6nnw9O+4DDSSm884S8odVgvLDsdhoFC8GLmfdaQa0QO9Ihbqi+DR6C0GGwHYY6XY1VkKisS34j99ZvMrkO5sIG9KkuzBiIYNgO6IAuZFHG2yOof5GO7i+pd8aacTYxK0+xfl7p9Pfxyjw0YAA5B10OxKjJXCOOnPDm5Lo9WwoeLQLFdoFNOTL99ZaipucnXUpFatAw4fH3IOMZHbjtxWREKmenUsD5b25sN9cg85l9gBdaOQ2tmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4YxU/AZ7s74oS9DoBjfIW0oQOX/NVlJ3YU/SCFjzUA=;
 b=R00ZyO2e41IbIM+SVPph10jhXDECMAF1fet41ElM/d+BatG0Ij13pad4NmSoGXHl61V+ZarIHwXFWG68KzWfojz/Ls4uH/RFG6hx6YkWsC2SCrsNpAPUMv64yluqe1SppUtqWguRtHPzavgjZD/LZcJaNnH6m+aPKpqST4CohDXJt/ENbUCfpBScSaPSOXx/9JDciA56EhEDyHsYQbzk/qznUnlMPc57bOqMbphVcxdNta5QQXEuUAVZ2HIWrrc/qk/rP7eUT4D8lF8TrNFeJUhh095JF6XGA+bqxOSJVUT8tTc0zlrOcqQHB8lXjCOXGns45IZtW/e6kgma65r4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4YxU/AZ7s74oS9DoBjfIW0oQOX/NVlJ3YU/SCFjzUA=;
 b=VkbNiS16aqjvy/aAmqoRjvWPJmNEJrXsUjiWSJCgMssbDyFBTwBles4fUum4g/2FpfWCgPA41L0ZTXUIe4xwOFdzDyaq1gJj1pqZ0jloAfjAHTtg+HXQ7adRhdWrM3CSOE2LGcWQfM2C5f1kvDEA561s4gYA/mF2gieVIPa4w20=
Received: from DM6PR07CA0090.namprd07.prod.outlook.com (2603:10b6:5:337::23)
 by CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 22:27:51 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::26) by DM6PR07CA0090.outlook.office365.com
 (2603:10b6:5:337::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 22:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 22:27:51 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 16:27:47 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v14 2/4] EINJ: Add CXL error type support
Date: Mon, 26 Feb 2024 16:27:02 -0600
Message-ID: <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|CH0PR12MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b683ff3-ac45-4ecd-e21f-08dc371a2b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KVNDy8cQc/Dd91P0ogT8dE7VvvLhurM3Zp3X6VOQuMRpnn++NWmq4WG6PWT9Yf/b1e0t+Hk7W13SdXcF75TmDiv6LGoauE7ATF7lyD2KX0kn8E3T6xKld3i6U+unxPUnI0OsjFe3ejSqaHt7lHZzUM0nOl2KfLJeSI4VgznM22Q9d9n1ONv6dLhrs476yFTr4v0FRY9V9gacNooS7s0MEDJyQ3FrRQ0L65tuNbY2pycjlMGjJSaGcoJyXLzWgCoqIOwKEH7FRkPz+/zCcBtGGEDG9r9Vi02me/dGneSgixnNa79Kdkpz2VNqg9oqCUKexbJY1F7B3k9VX5IgbEXOAPy2l6idUvUVSFkDRrCJHzoPs8RMaPKDUUemThxKjDQRy+1UUcjri+eBZUtXARkdOTP7xSDEfNHCTbNOBx8iTkka3Y2cAT5KwGlcAbjUhN/R8axgE7ypHTiwg+D68xbrn2M7lswRn0gQUmLDRr52Hb58OqPzUgPIALXvzz6Zw9zBTdH3tV1pv05LffFkqQ1rOqXDPlvvWkHTK8FPwPG77a21mFKDPFS//JSs0vXukJarbYR7WgWw9XJtLAsFLqTVMaIrq3oR8aMhO7QWxUXJqvCVi5CzFI99H67IJNqOfY/aqiOngEAvgNs9J1Vh5e/tliN+UPdCaUiCFsFjGyay/aFrhuSMp2Z2LPrb2PFGR5oXain8fSv4z0hEuOOdbyJnoOCgWrgQU3yAOwY4osKwaEqdYz6DMwwbje03DUX4QEV5
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:27:51.3139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b683ff3-ac45-4ecd-e21f-08dc371a2b3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5265

Remove CXL protocol error types from the EINJ module and move them to
a new einj_cxl module. The einj_cxl module implements the necessary
handling for CXL protocol error injection and exposes an API for the
CXL core to use said functionality. Because the CXL error types
require special handling, only allow them to be injected through the
einj_cxl module and return an error when attempting to inject through
"regular" EINJ.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 MAINTAINERS                               |   1 +
 drivers/acpi/apei/Kconfig                 |  12 +++
 drivers/acpi/apei/Makefile                |   2 +
 drivers/acpi/apei/apei-internal.h         |  16 +++
 drivers/acpi/apei/{einj.c => einj-core.c} |  78 +++++++++-----
 drivers/acpi/apei/einj-cxl.c              | 120 ++++++++++++++++++++++
 include/linux/einj-cxl.h                  |  40 ++++++++
 7 files changed, 244 insertions(+), 25 deletions(-)
 rename drivers/acpi/apei/{einj.c => einj-core.c} (94%)
 create mode 100644 drivers/acpi/apei/einj-cxl.c
 create mode 100644 include/linux/einj-cxl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecaaec6a6bf..90cf8403dd17 100644
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
index 6b18f8bc7be3..f01afa2805be 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -60,6 +60,18 @@ config ACPI_APEI_EINJ
 	  mainly used for debugging and testing the other parts of
 	  APEI and some other RAS features.
 
+config ACPI_APEI_EINJ_CXL
+	bool "CXL Error INJection Support"
+	default ACPI_APEI_EINJ
+	depends on ACPI_APEI_EINJ && CXL_BUS <= ACPI_APEI_EINJ
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
index 4dfac2128737..2c474e6477e1 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -2,6 +2,8 @@
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
 obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
+einj-y				:= einj-core.o
+einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
 obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
 
 apei-y := apei-base.o hest.o erst.o bert.o
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 67c2c3b959e1..ab039d24cd22 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -130,4 +130,20 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 }
 
 int apei_osc_setup(void);
+
+int einj_get_available_error_type(u32 *type);
+int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
+		      u64 param4);
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
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
similarity index 94%
rename from drivers/acpi/apei/einj.c
rename to drivers/acpi/apei/einj-core.c
index 937c69844dac..1a5f53d81d09 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj-core.c
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
@@ -141,7 +147,7 @@ static DEFINE_MUTEX(einj_mutex);
 /*
  * Exported APIs use this flag to exit early if einj_probe() failed.
  */
-static bool einj_initialized __ro_after_init;
+bool einj_initialized __ro_after_init;
 
 static void *einj_param;
 
@@ -166,7 +172,7 @@ static int __einj_get_available_error_type(u32 *type)
 }
 
 /* Get error injection capabilities of the platform */
-static int einj_get_available_error_type(u32 *type)
+int einj_get_available_error_type(u32 *type)
 {
 	int rc;
 
@@ -536,8 +542,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 }
 
 /* Inject the specified hardware error */
-static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
-			     u64 param3, u64 param4)
+int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
+		      u64 param4)
 {
 	int rc;
 	u64 base_addr, size;
@@ -560,8 +566,16 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (type & ACPI5_VENDOR_BIT) {
 		if (vendor_flags != SETWA_FLAGS_MEM)
 			goto inject;
-	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
+	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
 		goto inject;
+	/*
+	 * If the error type is for a CXL 1.0/1.1 port then skip address
+	 * checking here. The einj-cxl module should have already verified the
+	 * supplied MMIO address is correct.
+	 */
+	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
+		goto inject;
+	}
 
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
@@ -613,12 +627,6 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
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
 
@@ -640,29 +648,21 @@ static int available_error_type_show(struct seq_file *m, void *v)
 
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
@@ -671,9 +671,37 @@ static int error_type_set(void *data, u64 val)
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
+bool einj_is_cxl_error_type(u64 type)
+{
+	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
+}
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
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
new file mode 100644
index 000000000000..34badc6a801e
--- /dev/null
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -0,0 +1,120 @@
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
+/* Defined in einj-core.c */
+extern bool einj_initialized;
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
+	if (!einj_initialized)
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
+	if (!einj_initialized)
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
+	return einj_initialized;
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_is_initialized, CXL);
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


