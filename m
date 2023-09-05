Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F7792D9D
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjIESqs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 14:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjIESqr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 14:46:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3C3191;
        Tue,  5 Sep 2023 11:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N42ibbCzUBXputMo3eUwGsNI6o7nbkHkqRmyctgpjYjaYlJkDJvDZ9h7/wsPtN7d7WDMEqIuEnma1UIG1kOIulz42z7CGgY03U/wS/a64oSgaYao8v/glq2sns8peJikoS6IcVIEokm94hQDuBaDAJ3UYk15ucNYjHARMzXFd9CC4ySNXEfq5ixlcevmR8yBRfIvtMK6DnltKcGEx+KQnnCwLq/9bWjham1WIFIinxUUcIg+TRc9rySoqnUoEswA1ptbgViyAY3AORiNW0SLU/Xu4gMQaMtLkyJoLrZOLzNfiik7mL0g4x2alUdwiJljyWLmhz7imqSDS1+lbwyCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG6FnCDWh6zjISAf5Y7bomRitCC4+700mrkfE++p2kk=;
 b=kLX6hdHiLCAQzResHhqvcqNbR5o+0WlK7i8vkiwaQ6nEf8/ZVhctphrB3d0rPsn9NYdX34aKw78N8uZ9bvUg1xxSdWS9CbliAoh47lP5Lqzgq2r9hvnwX8sUrLG9z5QMFhjtYinvbLp/NqEwzQOdF226Z7MAwx1e2ESomRcKFJKUAbhKoW0w0LA6ZyGGIuECe9IbtDuhyfsGPob6hkZrDgvegKI/8lwHbhJ6Ve3WYEpvNxt+l8PTVUZz4oNefEeJ76G1my5g7yVQaDS5IzXYauiUvtn/9Fo3sURL18Yn9WiZSpZxNSrMbFgIIQbscQC1fV7fHz7NbZ/4MAqa5Kr8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG6FnCDWh6zjISAf5Y7bomRitCC4+700mrkfE++p2kk=;
 b=itJtC1Kmd7l8t3juIotdQJsws3vDIW5VKZ2ozb/NTat01ZO2/2ZDYiXiG2Me22oEZz6j1OZaAfcXFQNweX/0pQAznxFHNqJBXu2S5iM4OI0til/62oVzcw+E1oxaiZoXnPdrdiJrr/sISV2dWlZyGA9XZ1SpuM27Rws0V/VREBo=
Received: from SJ2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:a03:505::25)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:44:54 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::f9) by SJ2PR07CA0002.outlook.office365.com
 (2603:10b6:a03:505::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 18:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 18:44:54 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 13:44:52 -0500
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
        <yazen.ghannam@amd.com>
Subject: [PATCH v3 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type support
Date:   Tue, 5 Sep 2023 13:44:05 -0500
Message-ID: <20230905184406.135851-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905184406.135851-1-Benjamin.Cheatham@amd.com>
References: <20230905184406.135851-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: c670849b-d035-4bff-b494-08dbae4031f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eo+0xS5sZlWep6qkVXPnmmsxZ+kEZwShr+vft6hboaddKY1fKb5WsvKtr85pzk7+DVxH10ltO5HxKGg69hvYqi8iaFZYmKPvLVWNPDsTKqYKrxUP9DSX+NBNQOaLJkcHlqPE1iEMFCmu2VVu/d8T6OQvilbACqGTJNvOsWFeNQOatJGoVCAhwknvUu5+JSB8IueDSAHANxL6fmeRyf7S4nWt+7k0TRLwMWkpD6h0JCTpUt0wOwh/ojhjqu534NGieoIgvH4HT6R9tXWXs14MthNxt+N8iau/yDp22CC70BsW51Nuwigt+KjAQQCGoNMUoEp8tk0HGMjCP7sckjOZIgtpsTkp1Arcxg6TA4DYnlHb19fTSr54Tik+mjCwDmRHw8QlN7YEMQ72izPEPeXYHpJ5H+tYS3rkI1P01VUkPgGGmKjm8G0gDeuGT/q8nSEoAcVkkmvy8D2DNWKtRsnelfYdrAdC88Qr9fIHQTMMglBslnZcEQsqqavl6Q13W8KJVN794KMy3nSqbl/5tpDldumqczlpdA7jcr+XKzqa5Mk2Cd/hMoVu1xsYT9yMHDH/wIrTPiuCXXH0aqKoVKO+BQlPYqtUrBGjp1ArcIAJamSbbgfM+T0Cv+eQdaF5NMcAg8UHFQImdXPkTgnNnmVY2miii4ZUhNdumU3LAorT5Y6wEo6X0fukWQEOGehDpNHWs2GicTnxrf0Gptu66EacE9AxyILIs/Hsk0uXFXYABNkzX1AZwTRaBGQzCO6od8xBfVl6jE/x/MIXcSge0b8Mog==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(54906003)(316002)(2906002)(36756003)(110136005)(86362001)(70586007)(40480700001)(70206006)(8936002)(5660300002)(8676002)(4326008)(41300700001)(40460700003)(1076003)(36860700001)(2616005)(83380400001)(336012)(26005)(16526019)(47076005)(426003)(82740400003)(478600001)(356005)(81166007)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:44:54.1108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c670849b-d035-4bff-b494-08dbae4031f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/acpi/apei/einj.c | 26 +++++++++++++++++++++++++-
 drivers/cxl/core/port.c  | 17 +++++++++++++++++
 drivers/cxl/cxl.h        |  1 +
 include/linux/cxl.h      | 18 ++++++++++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/cxl.h

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92..0783ddd3ab4d 100644
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
@@ -512,6 +514,24 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	return rc;
 }
 
+static int is_valid_cxl_addr(u64 addr)
+{
+	struct cxl_dport *dport;
+
+	if (IS_REACHABLE(CONFIG_CXL_ACPI)) {
+		dport = cxl_find_rch_dport_by_rcrb((resource_size_t) addr);
+
+		if (!IS_ERR_OR_NULL(dport))
+			return 1;
+	} else {
+		pr_err("CONFIG_CXL_ACPI is not reachable.\n");
+		return 0;
+	}
+
+	pr_info("Could not find dport with rcrb 0x%llx\n", addr);
+	return 0;
+}
+
 /* Inject the specified hardware error */
 static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			     u64 param3, u64 param4)
@@ -537,8 +557,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
@@ -807,3 +830,4 @@ module_exit(einj_exit);
 MODULE_AUTHOR("Huang Ying");
 MODULE_DESCRIPTION("APEI Error INJection support");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b69fd1c1d5d6..3961f099a775 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1122,6 +1122,23 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
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
index 000000000000..09889581d9f1
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
+struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base)
+{
+	return NULL;
+}
+#endif
+
+#endif
-- 
2.34.1

