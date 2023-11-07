Return-Path: <linux-acpi+bounces-1327-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E0E7E3EA4
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 13:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF58A2809A3
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671A930CE2
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyUucl5G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE59651
	for <linux-acpi@vger.kernel.org>; Tue,  7 Nov 2023 12:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D43C433C9;
	Tue,  7 Nov 2023 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699358988;
	bh=oxL5q+LXqa/6GFIBeO17c/ibc8JlajUX3kY8hpeFTeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyUucl5GudI/RK99/s4VSeHFGoNQPD744fDd8rJFScAVW/8YtKU9LoZ5SWtXLP6zd
	 A/d4DaN65wJilgzw4JTcYGooQ/X6kj+chN3GuEfK3WiozO7ZMzPQN4nIowefRQPPTg
	 hoEWzDCF9fHh5mMbtYmN6OsEx8s8OrsjcqaNzSdOyAojqGmHQC4YUJwllzl9WwfqqO
	 DTgojUQGc++qcaXXygseUo9qcq0SuEXaWQLG5/TyobWExir/+vdp0MPDeMlHD6C+KY
	 PIOy7x6tavB5phbboaxznU1OnDxXlcrE0Y9S5naPEz7rKsMPcNSf29Q7Y4077JMXmq
	 grnOLQFaVV87g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiju Jose <shiju.jose@huawei.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	mahesh@linux.ibm.com,
	robert.moore@intel.com,
	pabeni@redhat.com,
	leoyang.li@nxp.com,
	tony.luck@intel.com,
	rostedt@goodmis.org,
	linmiaohe@huawei.com,
	linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org
Subject: [PATCH AUTOSEL 6.5 11/30] ACPI: APEI: Fix AER info corruption when error status data has multiple sections
Date: Tue,  7 Nov 2023 07:08:26 -0500
Message-ID: <20231107120922.3757126-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit

From: Shiju Jose <shiju.jose@huawei.com>

[ Upstream commit e2abc47a5a1a9f641e7cacdca643fdd40729bf6e ]

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
[ rjw: Subject edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 23 ++++++++++++++++++++++-
 drivers/pci/pcie/aer.c   | 10 ++++++++++
 include/acpi/ghes.h      |  4 ++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ef59d6ea16da0..63ad0541db381 100644
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
index f6c24ded134cd..67025ee2b7454 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -29,6 +29,7 @@
 #include <linux/kfifo.h>
 #include <linux/slab.h>
 #include <acpi/apei.h>
+#include <acpi/ghes.h>
 #include <ras/ras_event.h>
 
 #include "../pci.h"
@@ -1010,6 +1011,15 @@ static void aer_recover_work_func(struct work_struct *work)
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
index 3c8bba9f1114a..be1dd4c1a9174 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -73,8 +73,12 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 
 struct list_head *ghes_get_devices(void);
+
+void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
 #else
 static inline struct list_head *ghes_get_devices(void) { return NULL; }
+
+static inline void ghes_estatus_pool_region_free(unsigned long addr, u32 size) { return; }
 #endif
 
 int ghes_estatus_pool_init(unsigned int num_ghes);
-- 
2.42.0


