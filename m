Return-Path: <linux-acpi+bounces-74-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BAF7AD36E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 10:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BE5A8281538
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D7811CA1
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174610A1F;
	Mon, 25 Sep 2023 07:44:54 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69EB196;
	Mon, 25 Sep 2023 00:44:49 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vsmvt1q_1695627884;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsmvt1q_1695627884)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:44:45 +0800
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
Subject: [RFC PATCH v2 7/9] ACPI: APEI: ESRT: kick ghes_report_chain notifier to report serialized memory errors
Date: Mon, 25 Sep 2023 15:44:24 +0800
Message-Id: <20230925074426.97856-8-xueshuai@linux.alibaba.com>
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

Introduce a new pstore_record type, PSTORE_TYPE_CPER_MEM, so that
serialized memory errors can be retrieved and saved as a file in pstore
file system. While the serialized errors is retrieved from ERST
backend, kick ghes_report_chain notifier.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 5 +++++
 fs/pstore/platform.c     | 1 +
 include/linux/pstore.h   | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 82f57aaf89ad..786d46c767ee 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -26,6 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h> /* kvfree() */
 #include <acpi/apei.h>
+#include <acpi/ghes.h>
 #ifdef CONFIG_X86_MCE
 /* only define CREATE_TRACE_POINTS once */
 #include <trace/events/mce.h>
@@ -1072,6 +1073,10 @@ static ssize_t erst_reader(struct pstore_record *record)
 		trace_mce_record((struct mce *)rcd->data);
 #endif
 		record->type = PSTORE_TYPE_MCE;
+	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SEC_PLATFORM_MEM)) {
+		record->type = PSTORE_TYPE_CPER_MEM;
+		arch_apei_report_mem_error(0x2, (struct cper_sec_mem_err *)rcd->data);
+		atomic_notifier_call_chain(&ghes_report_chain, 0x2, rcd->data);
 	}
 	else
 		record->type = PSTORE_TYPE_MAX;
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index e5bca9a004cc..4e63ac8be755 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -51,6 +51,7 @@ static const char * const pstore_type_names[] = {
 	"powerpc-common",
 	"pmsg",
 	"powerpc-opal",
+	"cper-mem",
 };
 
 static int pstore_new_entry;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index ad44b3baf10e..d18ecaacd1b5 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -40,6 +40,9 @@ enum pstore_type_id {
 	PSTORE_TYPE_PMSG	= 7,
 	PSTORE_TYPE_PPC_OPAL	= 8,
 
+	/* APEI section */
+	PSTORE_TYPE_CPER_MEM		= 9,
+
 	/* End of the list */
 	PSTORE_TYPE_MAX
 };
-- 
2.41.0


