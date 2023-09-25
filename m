Return-Path: <linux-acpi+bounces-114-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFEB7AE04F
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 22:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ABD7028150A
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 20:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AE223764
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 20:30:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B08179B4
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 20:02:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA6510E;
	Mon, 25 Sep 2023 13:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab5Lz4Ezs9/54pGusAJ+SkKWORpXm/IphOG5bX/iRPUImE20VJM8wnb1qRc7En+vLKXiQQr/GHYQOHDg/uZPvPvjdmyRm9vwApkXlKtJn1rNDNkxVs9B7sujUUDkd2nsOUNJO8N9qZWNNEeO54LAkE7MhwLgr9Ic8VZYtcK0NCY9eAq8GNlpC8PKghZ8/TzaoFrIqbg9yo2TBjFcCx9++YrrlMYUF0Jg6ohVqjV/IHWXRtvkUkFuaUBBThANDNL0Og2esFIHCYD1HF8mG7wSHF7/3w4ciuRSryoMGdy6vA18hScmnVcKaCTyyil2Jx7PD4sAGeEastMHwOIdraDudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFr85a3FD3FOunThPZ7hcSo+d37/Irdbc5+OynULZq4=;
 b=Gf5Mae2XbTfI4+0X6hh0SwP5AESlm8rqsqMeQRvU9jytVAAfZnDbBgV5XA0wixjP06FgHUnA9SS7QiF9qxFxR9aAWPYyJdr3GDMDsSQPT1xgcBTTlq1YOQBkql26kT4OFQ4LaKgYmxmse4Ntq6wghvsyxfsr7NPbQ6axTZelZcRjA/fotKs9/zFt0cUCjR1recwct6RYPnCWL5ynuXCvLDTyvUX9wGz+B5gFvfwA60Z/RX0skbQRGTh4b1zmxgc6iCdKV5JJ4DD608AfZKV6wpnh/tcSmy5wBTi2vGkXtM10NKdpSiZcwFqMcD3qeeCH8hCze83fH9mK5OOS8iTZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFr85a3FD3FOunThPZ7hcSo+d37/Irdbc5+OynULZq4=;
 b=KXbJ1xf9RiLueONHkfiAn1qIwqAnHPWxdw+cP/d89Km5eqZK6l60UyzHgcH1DCMO+85xAV3YiG25ln6AIZVACBdzZlBmVQGlzvBP8Xb9xl3SZGbE6CX6DWQRK8hLQGXrFoXGNG6/WUaW7ty/3rmK4OZ6IvBww0iY0toJtI3z1Zc=
Received: from SN6PR05CA0002.namprd05.prod.outlook.com (2603:10b6:805:de::15)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 20:02:18 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::b0) by SN6PR05CA0002.outlook.office365.com
 (2603:10b6:805:de::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19 via Frontend
 Transport; Mon, 25 Sep 2023 20:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 20:02:18 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 25 Sep 2023 15:02:17 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
	<yazen.ghannam@amd.com>
Subject: [PATCH v5 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type support
Date: Mon, 25 Sep 2023 15:01:26 -0500
Message-ID: <20230925200127.504256-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 88565e7b-3a4c-4876-7ace-08dbbe025242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GuY3WNzoZsKmhYk1TZ3GVvsi/9jpfo7+lR0auTtdcqG6ABQtwbPYZ2TGy1BZx9UiOWEqqkK/LySrTS0SI0QlHqdw94vr7f5OLuTC9VGTUQcYT68Wgs96yrHnXazEtbxe91Nva0JfraQK8SnnzXKwxoglHPu3nqDVDgPnB176ZHxz5hXSowXvS6VuLQGvekAugfFTELtd4ivGxmM4y99WSITFk0R8F81NxOYxegEdAV+eE6+X87XjsxroWetsEkvhfea/XQtXGLJjFl7pUSpDkBpsZpmogAQiRkAK+Lmuj81k4E7pOVmQYpIHtIhe9CWazTi4lCeNXTAuKO0cqqIcerjw/Ed7Jrg0eiZUT1OiZ62QxpWpCXpDpdp9fZ+qhQnUlmub3nVGrYF3aKwSmcplKYu8uxr6IKRzk2dqzoMOLN9rPUBpRW83xBZAxtZZi4fBlP1Siz7opR3OBPSLGlbhOkW2o+rxw8AgMhOOf+N53qcKS5tyILk/UNYR9xD7qkWIIuitKRhjKN+lLA/WlGb2iziKV+2sOacKDy4+3K6fpkt5kU1T9C085gbN1eG7iRiPxAfJWFRNqOHtLXLlPChoIQ2RUNbGhkrAaE1b9Dp7fjA5xTB8NCXWey2XWOX0J6KSIuqnPpV9QpOnB//8kPLY0kxVhq2mRlAeWz4sOOvuA1aYKZc8wstgRAaG+yHHIu+p9qkn4JcRxc5Oa9v0ADFtac8MfRb7PYY9R1zS4vEX3MZ79SFbkBuaIbcVUOLK3uRc1yqujPZLbBUFA7kXxOtZrg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(26005)(16526019)(8676002)(4326008)(2616005)(8936002)(40460700003)(2906002)(83380400001)(40480700001)(47076005)(5660300002)(36756003)(336012)(36860700001)(81166007)(426003)(356005)(478600001)(7696005)(6666004)(86362001)(82740400003)(54906003)(316002)(110136005)(70586007)(70206006)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:02:18.1888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88565e7b-3a4c-4876-7ace-08dbbe025242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for CXL EINJ error types for CXL 1.1 hosts added in ACPI
v6.5. Because these error types target memory-mapped CXL 1.1 compliant
downstream ports and not physical (normal/persistent) memory, these
error types are not currently  allowed through the memory range
validation done by the EINJ driver.

The MMIO address of a CXL 1.1 downstream port can be found in the
cxl_rcrb_addr file in the corresponding dport directory under
/sys/bus/cxl/devices/portX. CXL 1.1 error types follow the same
procedure as a memory error type, but with param1 set to the
downstream port MMIO address.

Example usage:
$ cd /sys/kernel/debug/apei/einj
$ cat available_error_type
    0x00000008      Memory Correctable
    0x00000010      Memory Uncorrectable non-fatal
    0x00000020      Memory Uncorrectable fatal
    0x00000040      PCI Express Correctable
    0x00000080      PCI Express Uncorrectable non-fatal
    0x00000100      PCI Express Uncorrectable fatal
    0x00008000      CXL.mem Protocol Correctable
    0x00020000      CXL.mem Protocol Uncorrectable fatal
$ echo 0x8000 > error_type
$ echo 0xfffffffffffff000 > param2
$ echo 0x2 > flags
$ cat /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
0xb2f00000
$ echo 0xb2f00000 > param1
$ echo 1 > error_inject

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/Kconfig |  2 ++
 drivers/acpi/apei/einj.c  | 24 +++++++++++++++++++++++-
 drivers/cxl/acpi.c        |  1 +
 drivers/cxl/core/port.c   | 17 +++++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 include/linux/cxl.h       | 11 +++++++++++
 6 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/cxl.h

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 6b18f8bc7be3..eb9cc7157342 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -55,6 +55,8 @@ config ACPI_APEI_MEMORY_FAILURE
 config ACPI_APEI_EINJ
 	tristate "APEI Error INJection (EINJ)"
 	depends on ACPI_APEI && DEBUG_FS
+	imply CXL_BUS
+	imply CXL_ACPI
 	help
 	  EINJ provides a hardware error injection mechanism, it is
 	  mainly used for debugging and testing the other parts of
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92..8000417a5f26 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -21,6 +21,7 @@
 #include <linux/nmi.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/cxl.h>
 #include <asm/unaligned.h>
 
 #include "apei-internal.h"
@@ -36,6 +37,7 @@
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
 				ACPI_EINJ_MEMORY_FATAL)
+#define CXL_ERROR_MASK		GENMASK(17, 12)
 
 /*
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
@@ -512,6 +514,22 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	return rc;
 }
 
+static int is_valid_cxl_addr(u64 addr)
+{
+	struct cxl_dport *dport;
+
+	if (IS_REACHABLE(CONFIG_CXL_ACPI))
+		dport = cxl_find_rch_dport_by_rcrb((resource_size_t) addr);
+	else
+		return 0;
+
+	if (!IS_ERR_OR_NULL(dport))
+		return 1;
+
+	pr_info("Could not find dport with rcrb 0x%llx\n", addr);
+	return 0;
+}
+
 /* Inject the specified hardware error */
 static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			     u64 param3, u64 param4)
@@ -537,8 +555,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (type & ACPI5_VENDOR_BIT) {
 		if (vendor_flags != SETWA_FLAGS_MEM)
 			goto inject;
-	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
+	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
 		goto inject;
+	} else if (type & CXL_ERROR_MASK && is_valid_cxl_addr(param1)) {
+		goto inject;
+	}
 
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
@@ -807,3 +828,4 @@ module_exit(einj_exit);
 MODULE_AUTHOR("Huang Ying");
 MODULE_DESCRIPTION("APEI Error INJection support");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3e2ca946bf47..a7adf3d9814e 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -756,6 +756,7 @@ static void __exit cxl_acpi_exit(void)
 {
 	platform_driver_unregister(&cxl_acpi_driver);
 	cxl_bus_drain();
+	set_cxl_root(NULL);
 }
 
 /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c3914e73f67e..cb653cb1a1ea 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1147,6 +1147,23 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_rch_dport, CXL);
 
+struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base)
+{
+	struct cxl_dport *dport;
+	unsigned long index;
+
+	if (!cxl_root)
+		return ERR_PTR(-ENODEV);
+
+	xa_for_each(&cxl_root->dports, index, dport)
+		if ((dport->rch && dport->rcrb.base != CXL_RESOURCE_NONE)
+		    && dport->rcrb.base == rcrb_base)
+			return dport;
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_find_rch_dport_by_rcrb, CXL);
+
 static int add_ep(struct cxl_ep *new)
 {
 	struct cxl_port *port = new->dport->port;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4d5bce4bae7e..3e6779dbcd23 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/cxl.h>
 #include <linux/io.h>
 
 /**
diff --git a/include/linux/cxl.h b/include/linux/cxl.h
new file mode 100644
index 000000000000..6702caa78e7a
--- /dev/null
+++ b/include/linux/cxl.h
@@ -0,0 +1,11 @@
+#ifndef _LINUX_CXL_H
+#define _LINUX_CXL_H
+
+#include <linux/xarray.h>
+#include <linux/errno.h>
+
+struct cxl_dport;
+
+struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base);
+
+#endif
-- 
2.34.1


