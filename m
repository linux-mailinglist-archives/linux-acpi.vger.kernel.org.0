Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7AA797CA6
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 21:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbjIGTVV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 15:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjIGTVU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 15:21:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE891739;
        Thu,  7 Sep 2023 12:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/vNLP43Odety7dArVTdocicMlKajj/M/yDsr50ZXs8VYOT54dnMcL8xoo3PVnsamQ8qufibzdemO4RZWLiSCxaCIzGZZ9/8++VeyH3D31Gwnj2mBTd2YlCXi8rT0gTM3JRZ6oe02SkQoIwQR0PcKDQfVcoXiLtxQed4ct4scBg4LmRQozqH5bt7d/meyx7N24FtiBftDeMOGQdxefO5Win+u29QgGX81/ptXhMjbraFKLmsmwhOUo3+nYgVt52qPjjr2FNfn69QW/RyMvr/cXyaucwg/c6BOtyvkERaK3mkcrkK7S8i/W9R0qVSb54a+5cz6ci+UMgS4Po+7ryNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxVqRzgj/sUzHAH3Mn0ZvlxKfmt02ssVJyEQm2AGtgk=;
 b=BaD/E22hrZ99llZxZvJFf3Z8ug4N0eEMZ24yJPvBNX1SkIgLHr2SRpzDSpNv3v79xwm15m7ckh7A90rs4w+iNiTCMUVaCx+Q1vUlaanY84vCJ0X/WDC4wjfMr+nOUo3rxSptQ6O3tUoui6JW2iM6V+nkSjZ7rFH1R9hTV3iIO4/U+q/XZN3e+kBMvySHiMXjzJDLiKCpzMtceMOgiJuAoTzixU2MtmezvQevgmP2/95uJYHiHlyWjxjIEAsHUXyC/3hpLt0LExogPZSdciG3tH1ENSs79LNWRfiZSSEj0GLz5i3qVju4dl5SXAklEwoZzZ/7S02hPQOFr6VIDC2vkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxVqRzgj/sUzHAH3Mn0ZvlxKfmt02ssVJyEQm2AGtgk=;
 b=Z6fhHDHekAlGKG6r69DpvAlGdJgw5Qdh8GnMyMrqP/LgdOIXQgq7HCD24wVQQ2xDmgPjzVpsQs+OT6pDaMTX2YTV6uiLgjl/1G7GA1YZlGFnb0AjijFVRrVZ9Fv63KtRKgs8pXzEADK+2N4UBTT/XfcDQMh8+tAPi7jtzGcQnOA=
Received: from SN4PR0501CA0019.namprd05.prod.outlook.com
 (2603:10b6:803:40::32) by CH2PR12MB4892.namprd12.prod.outlook.com
 (2603:10b6:610:65::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 19:21:06 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:803:40:cafe::a8) by SN4PR0501CA0019.outlook.office365.com
 (2603:10b6:803:40::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Thu, 7 Sep 2023 19:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 19:21:06 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 7 Sep 2023 14:21:05 -0500
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
        <yazen.ghannam@amd.com>
Subject: [PATCH v4 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type support
Date:   Thu, 7 Sep 2023 14:19:55 -0500
Message-ID: <20230907191956.674833-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
References: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CH2PR12MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: d45ce91b-4098-421e-eb86-08dbafd79579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9kzyZtSxZTyT/bBz52gMXXynoiJ6gzkDSZwOSZBWwULFJzScEEVShHwTtQxWuQPrzShh66AUHOAlDp9DEx71ve/fu4dMNjP1jScgwD0GRvz64rdnETN6U7Kvo1rd6Q1lUbBmy/RUTRIrjweWerACm6xFCNkBNMgHGKGQUNtR4ihqIvcrtooDn/l8hbPQET5AT2q+sC9mwzEfF8SOjnQHm/d/gosX2SMtJEkQkUST+naaJQZVp6WyLAFynMxrQcmhmzVvZ4zuPj+LxtC8J71n5OmW/APKYqONZpAydCnWK4ch8TQmPZJCzd39PAXE/8mE5sSIEoixcsnHdpNG3G+EztFu/vkca3f6HkUPmkY6ubbtSs9UNB/gkv80cNET6zmNeLsWJdT/580QQcXVUifZlImFkkEKL0TWMBmQ7HNqZfvwQs+PTxg4sV6S/Xz+iobsyELaH+1FyciBn4aAfNh3StScyDgpbW1mOGbu0hdwFonsWHQ1NDRK2D3hSpbG2X0BUwFEhcdZyQtwikI1exgwXp+UZsPz7xlvuExoRSlXOAEk/BQ0+GSQLOvokUW4yYdUkSYmo/o9nK4FzqM3T6H7EmW6YT4dx8ytsGG4aSIJNKGQ9OI6j+9JYuG6Do1G5dJJReAAcuyFzWAaXPB4VY4x4JazSnu6shmKwrFRcaYlhner2gFn2GxW2CvfuHmZFHWrWdZhXT9mWkAux09CXtultmmkrIZCGFg3UZQa7iBulJ+Lr0sH0dARjY+0vxiikcdB1yYXNWhmC9k5jOSoAgNHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(7696005)(6666004)(2616005)(1076003)(83380400001)(478600001)(26005)(426003)(16526019)(336012)(2906002)(110136005)(54906003)(8936002)(8676002)(70586007)(5660300002)(316002)(70206006)(4326008)(40460700003)(40480700001)(47076005)(36860700001)(86362001)(36756003)(41300700001)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 19:21:06.3056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45ce91b-4098-421e-eb86-08dbafd79579
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

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
$ echo 0x3 > flags
$ cat /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
0xb2f00000
$ echo 0xb2f00000 > param1
$ echo 1 > error_inject

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/Kconfig |  2 ++
 drivers/acpi/apei/einj.c  | 24 +++++++++++++++++++++++-
 drivers/cxl/core/port.c   | 19 +++++++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 include/linux/cxl.h       | 18 ++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)
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
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 001ab8742e21..f8f300496140 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1122,6 +1122,25 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_rch_dport, CXL);
 
+#if IS_ENABLED(CONFIG_CXL_ACPI)
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
+#endif
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
index 000000000000..b57a4cc85005
--- /dev/null
+++ b/include/linux/cxl.h
@@ -0,0 +1,18 @@
+#ifndef _LINUX_CXL_H
+#define _LINUX_CXL_H
+
+#include <linux/xarray.h>
+#include <linux/errno.h>
+
+struct cxl_dport;
+
+#if IS_ENABLED(CONFIG_CXL_ACPI)
+struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base);
+#else
+static inline struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base)
+{
+	return NULL;
+}
+#endif
+
+#endif
-- 
2.34.1

