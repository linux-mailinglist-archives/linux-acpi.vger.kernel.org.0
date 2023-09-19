Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C8C7A5D8B
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Sep 2023 11:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjISJQA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Sep 2023 05:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjISJQA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Sep 2023 05:16:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ECEDA;
        Tue, 19 Sep 2023 02:15:53 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RqbVv1kbcz6DB7k;
        Tue, 19 Sep 2023 17:11:03 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 10:15:50 +0100
From:   <shiju.jose@huawei.com>
To:     <helgaas@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <bp@alien8.de>,
        <ying.huang@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH v2 1/1] ACPI / APEI: Fix for overwriting AER info when error status data has multiple sections
Date:   Tue, 19 Sep 2023 17:15:43 +0800
Message-ID: <20230919091543.794-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

ghes_handle_aer() passes AER data to the PCI core for logging and
recovery by calling aer_recover_queue() with a pointer to struct
aer_capability_regs.

The problem was that aer_recover_queue() queues the pointer directly
without copying the aer_capability_regs data.  The pointer was to
the ghes->estatus buffer, which could be reused before
aer_recover_work_func() reads the data.

To avoid this problem, allocate a new aer_capability_regs structure
from the ghes_estatus_pool, copy the AER data from the ghes->estatus
buffer into it, pass a pointer to the new struct to
aer_recover_queue(), and free it after aer_recover_work_func() has
processed it.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
Changes from v1 to v2:
1. Updated patch description with the description Bjorn has suggested.  
2. Add Acked-by: Bjorn Helgaas <bhelgaas@google.com>.
---
 drivers/acpi/apei/ghes.c | 23 ++++++++++++++++++++++-
 drivers/pci/pcie/aer.c   | 10 ++++++++++
 include/acpi/ghes.h      |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ef59d6ea16da..63ad0541db38 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -209,6 +209,20 @@ int ghes_estatus_pool_init(unsigned int num_ghes)
 	return -ENOMEM;
 }
 
+/**
+ * ghes_estatus_pool_region_free - free previously allocated memory
+ *				   from the ghes_estatus_pool.
+ * @addr: address of memory to free.
+ * @size: size of memory to free.
+ *
+ * Returns none.
+ */
+void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
+{
+	gen_pool_free(ghes_estatus_pool, addr, size);
+}
+EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
+
 static int map_gen_v2(struct ghes *ghes)
 {
 	return apei_map_generic_address(&ghes->generic_v2->read_ack_register);
@@ -564,6 +578,7 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
 		unsigned int devfn;
 		int aer_severity;
+		u8 *aer_info;
 
 		devfn = PCI_DEVFN(pcie_err->device_id.device,
 				  pcie_err->device_id.function);
@@ -577,11 +592,17 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 		if (gdata->flags & CPER_SEC_RESET)
 			aer_severity = AER_FATAL;
 
+		aer_info = (void *)gen_pool_alloc(ghes_estatus_pool,
+						  sizeof(struct aer_capability_regs));
+		if (!aer_info)
+			return;
+		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
+
 		aer_recover_queue(pcie_err->device_id.segment,
 				  pcie_err->device_id.bus,
 				  devfn, aer_severity,
 				  (struct aer_capability_regs *)
-				  pcie_err->aer_info);
+				  aer_info);
 	}
 #endif
 }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e85ff946e8c8..388b614c11fd 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -29,6 +29,7 @@
 #include <linux/kfifo.h>
 #include <linux/slab.h>
 #include <acpi/apei.h>
+#include <acpi/ghes.h>
 #include <ras/ras_event.h>
 
 #include "../pci.h"
@@ -996,6 +997,15 @@ static void aer_recover_work_func(struct work_struct *work)
 			continue;
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
+		/*
+		 * Memory for aer_capability_regs(entry.regs) is being allocated from the
+		 * ghes_estatus_pool to protect it from overwriting when multiple sections
+		 * are present in the error status. Thus free the same after processing
+		 * the data.
+		 */
+		ghes_estatus_pool_region_free((unsigned long)entry.regs,
+					      sizeof(struct aer_capability_regs));
+
 		if (entry.severity == AER_NONFATAL)
 			pcie_do_recovery(pdev, pci_channel_io_normal,
 					 aer_root_reset);
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 3c8bba9f1114..40d89e161076 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -78,6 +78,7 @@ static inline struct list_head *ghes_get_devices(void) { return NULL; }
 #endif
 
 int ghes_estatus_pool_init(unsigned int num_ghes);
+void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
 
 static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
 {
-- 
2.34.1

