Return-Path: <linux-acpi+bounces-4249-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8880F878196
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 15:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812BE1C21C9F
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3953FE20;
	Mon, 11 Mar 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3HIIDJPR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CF4084D;
	Mon, 11 Mar 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167172; cv=fail; b=hMkoN6Z38mlrlKoJhc6sBDsalX9M5fMrpvGD3EMDk46Dj7sSAFV08In7THbVr8wThWTmmBEK/7tq1tJbYbg9ZsAuUqAp9zOlaplm7rIxJIZT1dYGi24u//fJSZ8mOBhsm4CyQyFwBmRiOrkZL4MhKKHld8suXUXTENLN+Yo2phM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167172; c=relaxed/simple;
	bh=TKM1kd1XFlvg9B/8g8mySOwC89mtdmeWAgMIT6+Jgsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIjEO5T/JslisidHh4HdK9q229rEud48Xe56BE5iiPPLpI59p1WCKDxvQV3z4ehE6dl48XQNXLU2p2dIVOOwiOjzbJ7r4EEliBGmW/kQo+F49Dy5GfRcHamT/Kvu4/y+SVcRA+eh5AKOuiWCMrb1WhuvR6vqQZCNa+UsrnDrj9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3HIIDJPR; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRicrQP7WOm0OErwyO9KpYSv1pGMHdx7A/glHb0t+7UlmCpyWlgunLZ5O9f0pgt/ugzww7SoLp+aX1HTiK9nB3CRlZZ45SDWcHSKSJDb99d8hylqtpBzpejZ8dnKt1iOcX5NsMwUegvZiAw5b4fUES+cZD4ZHiyX1fLTAhx82xBBbRCIkGY1gas2Ki+HkG4Vi3kgVByRT2ga/potWXmta2zLXd4QxooEnfDBKauvhp5Ab3ehix55K+fmgsHC8joj7YUKpL/TRhXULQKhIPsGgE5SY2L+Fhme3hffG00IGgbdbRW8mTP8rBREBjOJZcHQl4yZqkfd8Z7N3yLmZ4hlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAwzFdJycQF4gIZVK/583IG0BZoOYeC5/WuLmh4c8h8=;
 b=KcQ3D9chOcFeZtQxk15KFtResyB+pFr2WAz/MEhgUTK8HTca6sB4kAISiBepPgMZ9UItnyZLvhgf6CRe8rIXcg63MOkdlUO/WUt7st3LiB7MW0UHQFj/uQwliQe8ld3Gw1aWpbcB+/ym15ispiRcihDeSFIMUye4UcUt+WvMRiK17QusHG+7eMhZjC7dBuBSTerVct6w/qqz7wL43ZtnlaMmk8eYlNnfFxozvXOcNAEJpNfBqpPKYPw6OHhkkkeige1rbHwQvf9LPrjmfGfWqSxCsWmS8FgQqgBE1+NGrniBzVSJ9kI7OrL//Rri7uQolDtcP4ypr9gngEWzfn10Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAwzFdJycQF4gIZVK/583IG0BZoOYeC5/WuLmh4c8h8=;
 b=3HIIDJPRpcrhCV5uLxI5U2Tm+d/GFB7xvfRz/QeN7IEIHKLWPEPaQdFU3y//47brkwmcSYH+as+DD/DVbPmgRSR01fdNd6xGwrDzVizlKJE7D6iESdJGCT7ho8KxHCs9dQ6cXEFKXu3+wz0mw00ZlhxYINlJbtDBCK3EguM65IA=
Received: from BN0PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:143::13)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 14:26:03 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::d4) by BN0PR10CA0011.outlook.office365.com
 (2603:10b6:408:143::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 14:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 14:26:02 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 09:25:55 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v15 2/4] EINJ: Add CXL error type support
Date: Mon, 11 Mar 2024 09:25:06 -0500
Message-ID: <20240311142508.31717-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
References: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: ede48c85-efb4-4ca0-e316-08dc41d72e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rqW3Cme9QuwS90eoFrrbr0AB7A6nnwGlteNyTL2NOFBB92xmbls+1IYvCPLw56aaF7HaV3Hqy/RMLcS57FgJtDKc3RNqUxgTyoVJfoPu0pD7PJqA3v19FIBdXyyPiEVDsu6sM0CjTnSindasB2oCKYJB/Hq/F5bYiknSmlyXr9mig0v/Lz3AW99midOx253zEODVgtOyg9ekEWIJGg65xbIshXgD2W5HTaK4wrCm0oUFrC975YK0rubbo7BNOg2fsZj8k90hhpWZHOMYRurC9gxTalJkPxEXJjpdG7TJKPtG/JzEZtCl9IvpkhoZ3l6snVLn4jl8wiDZSsDEdQubVdxb6PQyBkQdkRVMCDWdVSghsgIqPwTU3jj2asBy8cFAngkwoLjHbPYr5NOAW7o3+smqFMwvj0h6HbyNvwnFztCsJOyWKZmW9hnkXwufxlueWzXs1LFWv3HZurhiXVHfP6A1B3nMDV642tN5LGcSvYficxUYzuPh+YMLxn7+jC/LXLaFdHSO6Qjh5ojlB3yxdsBReniafwHzuCf2ovbIB7/Uqexpax+2wEv17bRb861n0oa2ReuqkBjTd36oVBtcI6K8mhGnp5rPbCPDyTpFaHGXINA1DN5Ma0e3BVBf9OT6/bAoGqkwIpO1KiV2DrKMwqg6ndkrJvZV5FGwFrL5G6yZyHTLTwKiu5KNdnKGMwyr1JfmlQxpjr4U97xA20n5w/HY+1oe+4oicfLz4d2JH3dzs5ggwCIoD6Mv6u/v52Sm
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:26:02.9536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede48c85-efb4-4ca0-e316-08dc41d72e47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467

Move CXL protocol error types from einj.c (now einj-core.c) to einj-cxl.c.
einj-cxl.c implements the necessary handling for CXL protocol error
injection and exposes an API for the CXL core to use said functionality,
while also allowing the EINJ module to be built without CXL support.
Because CXL error types targeting CXL 1.0/1.1 ports require special
handling, only allow them to be injected through the new cxl debugfs
interface (next commit) and return an error when attempting to inject
through the legacy interface.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 MAINTAINERS                               |   1 +
 drivers/acpi/apei/Kconfig                 |  12 +++
 drivers/acpi/apei/Makefile                |   2 +
 drivers/acpi/apei/apei-internal.h         |  18 ++++
 drivers/acpi/apei/{einj.c => einj-core.c} |  77 ++++++++++----
 drivers/acpi/apei/einj-cxl.c              | 116 ++++++++++++++++++++++
 include/linux/einj-cxl.h                  |  44 ++++++++
 7 files changed, 252 insertions(+), 18 deletions(-)
 rename drivers/acpi/apei/{einj.c => einj-core.c} (93%)
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
index 67c2c3b959e1..cd2766c69d78 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -130,4 +130,22 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 }
 
 int apei_osc_setup(void);
+
+int einj_get_available_error_type(u32 *type);
+int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
+		      u64 param4);
+int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
+			      u64 param3, u64 param4);
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
similarity index 93%
rename from drivers/acpi/apei/einj.c
rename to drivers/acpi/apei/einj-core.c
index 937c69844dac..9affbe807ded 100644
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
@@ -560,8 +566,18 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (type & ACPI5_VENDOR_BIT) {
 		if (vendor_flags != SETWA_FLAGS_MEM)
 			goto inject;
-	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
+	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
 		goto inject;
+	}
+
+	/*
+	 * Injections targeting a CXL 1.0/1.1 port have to be injected
+	 * via the einj_cxl_rch_error_inject() path as that does the proper
+	 * validation of the given RCRB base (MMIO) address.
+	 */
+	if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)) {
+		return -EINVAL;
+	}
 
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
@@ -593,6 +609,21 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	return rc;
 }
 
+int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
+			      u64 param3, u64 param4)
+{
+	int rc;
+
+	if (!(einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)))
+		return -EINVAL;
+
+	mutex_lock(&einj_mutex);
+	rc = __einj_error_inject(type, flags, param1, param2, param3, param4);
+	mutex_unlock(&einj_mutex);
+
+	return rc;
+}
+
 static u32 error_type;
 static u32 error_flags;
 static u64 error_param1;
@@ -613,12 +644,6 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
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
 
@@ -647,22 +672,26 @@ static int error_type_get(void *data, u64 *val)
 	return 0;
 }
 
-static int error_type_set(void *data, u64 val)
+bool einj_is_cxl_error_type(u64 type)
+{
+	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
+}
+
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
@@ -671,9 +700,21 @@ static int error_type_set(void *data, u64 val)
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
+static int error_type_set(void *data, u64 val)
+{
+	int rc;
+
+	rc = einj_validate_error_type(val);
+	if (rc)
+		return rc;
+
 	error_type = val;
 
 	return 0;
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
new file mode 100644
index 000000000000..bde7e20c7fbb
--- /dev/null
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -0,0 +1,116 @@
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
+#include <linux/seq_file.h>
+#include <linux/pci.h>
+
+#include "apei-internal.h"
+
+/* Defined in einj-core.c */
+extern bool einj_initialized;
+
+static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
+	{ ACPI_EINJ_CXL_CACHE_CORRECTABLE, "CXL.cache Protocol Correctable" },
+	{ ACPI_EINJ_CXL_CACHE_UNCORRECTABLE, "CXL.cache Protocol Uncorrectable non-fatal" },
+	{ ACPI_EINJ_CXL_CACHE_FATAL, "CXL.cache Protocol Uncorrectable fatal" },
+	{ ACPI_EINJ_CXL_MEM_CORRECTABLE, "CXL.mem Protocol Correctable" },
+	{ ACPI_EINJ_CXL_MEM_UNCORRECTABLE, "CXL.mem Protocol Uncorrectable non-fatal" },
+	{ ACPI_EINJ_CXL_MEM_FATAL, "CXL.mem Protocol Uncorrectable fatal" },
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
+	/* Only CXL error types can be specified */
+	if (!einj_is_cxl_error_type(type))
+		return -EINVAL;
+
+	rc = einj_validate_error_type(type);
+	if (rc)
+		return rc;
+
+	return einj_cxl_rch_error_inject(type, 0x2, rcrb, GENMASK_ULL(63, 0),
+					 0, 0);
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
+
+int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
+{
+	u64 param4 = 0;
+	int rc;
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
index 000000000000..624ff6ff41f9
--- /dev/null
+++ b/include/linux/einj-cxl.h
@@ -0,0 +1,44 @@
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
+#include <linux/errno.h>
+#include <linux/types.h>
+
+struct pci_dev;
+struct seq_file;
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


