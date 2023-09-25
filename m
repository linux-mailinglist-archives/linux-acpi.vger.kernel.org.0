Return-Path: <linux-acpi+bounces-75-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CFF7AD36F
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 10:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B78B12816FE
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7BF11CAA
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187910A22;
	Mon, 25 Sep 2023 07:44:54 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B87A1A5;
	Mon, 25 Sep 2023 00:44:50 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vsmvt3._1695627886;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsmvt3._1695627886)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:44:47 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	ardb@kernel.org,
	robert.moore@intel.com
Cc: linux-hardening@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com
Subject: [RFC PATCH v2 8/9] ACPI: APEI: ESRT: print AER to report serialized PCIe errors
Date: Mon, 25 Sep 2023 15:44:25 +0800
Message-Id: <20230925074426.97856-9-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce a new pstore_record type, PSTORE_TYPE_CPER_PCIE, so that
serialized PCIe errors can be restrived and saved as a file in pstore file
system. While the serialized PCIe errors is retrieved from ERST backend,
print AER information.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 15 +++++++++++++++
 fs/pstore/platform.c     |  1 +
 include/linux/pstore.h   |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 786d46c767ee..e0c44ea46acc 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -27,6 +27,8 @@
 #include <linux/mm.h> /* kvfree() */
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
+#include <linux/aer.h>
+#include <linux/pci.h>
 #ifdef CONFIG_X86_MCE
 /* only define CREATE_TRACE_POINTS once */
 #include <trace/events/mce.h>
@@ -1077,6 +1079,19 @@ static ssize_t erst_reader(struct pstore_record *record)
 		record->type = PSTORE_TYPE_CPER_MEM;
 		arch_apei_report_mem_error(0x2, (struct cper_sec_mem_err *)rcd->data);
 		atomic_notifier_call_chain(&ghes_report_chain, 0x2, rcd->data);
+	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SEC_PCIE)) {
+
+		struct cper_sec_pcie *pcie_err = (struct cper_sec_pcie *)rcd->data;
+		unsigned int devfn = PCI_DEVFN(pcie_err->device_id.device,
+				  pcie_err->device_id.function);
+		struct pci_dev *pdev = pci_get_domain_bus_and_slot(
+			pcie_err->device_id.segment, pcie_err->device_id.bus,
+			devfn);
+
+		record->type = PSTORE_TYPE_CPER_PCIE;
+		cper_print_aer(
+			pdev, AER_FATAL,
+			(struct aer_capability_regs *)pcie_err->aer_info);
 	}
 	else
 		record->type = PSTORE_TYPE_MAX;
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 4e63ac8be755..40a062546fe4 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -52,6 +52,7 @@ static const char * const pstore_type_names[] = {
 	"pmsg",
 	"powerpc-opal",
 	"cper-mem",
+	"cper-pcie",
 };
 
 static int pstore_new_entry;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index d18ecaacd1b5..e63f51e9c22e 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -42,6 +42,7 @@ enum pstore_type_id {
 
 	/* APEI section */
 	PSTORE_TYPE_CPER_MEM		= 9,
+	PSTORE_TYPE_CPER_PCIE		= 10,
 
 	/* End of the list */
 	PSTORE_TYPE_MAX
-- 
2.41.0


