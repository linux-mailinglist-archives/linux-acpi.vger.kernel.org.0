Return-Path: <linux-acpi+bounces-68-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8037AD365
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 70C0C2815AC
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E111C8E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD653BA;
	Mon, 25 Sep 2023 07:44:39 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A87FFB;
	Mon, 25 Sep 2023 00:44:36 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vsmvsxu_1695627872;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsmvsxu_1695627872)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:44:33 +0800
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
Subject: [RFC PATCH v2 1/9] pstore: move pstore creator id, section type and record struct to common header
Date: Mon, 25 Sep 2023 15:44:18 +0800
Message-Id: <20230925074426.97856-2-xueshuai@linux.alibaba.com>
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

Move pstore creator id, section type and record struct to the common
header, so that it can be use by MCE and GHES driver.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 19 -------------------
 include/linux/pstore.h   | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 247989060e29..528ac5eb4871 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -997,25 +997,6 @@ static struct pstore_info erst_info = {
 	.erase		= erst_clearer
 };
 
-#define CPER_CREATOR_PSTORE						\
-	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
-		  0x64, 0x90, 0xb8, 0x9d)
-#define CPER_SECTION_TYPE_DMESG						\
-	GUID_INIT(0xc197e04e, 0xd545, 0x4a70, 0x9c, 0x17, 0xa5, 0x54,	\
-		  0x94, 0x19, 0xeb, 0x12)
-#define CPER_SECTION_TYPE_DMESG_Z					\
-	GUID_INIT(0x4f118707, 0x04dd, 0x4055, 0xb5, 0xdd, 0x95, 0x6d,	\
-		  0x34, 0xdd, 0xfa, 0xc6)
-#define CPER_SECTION_TYPE_MCE						\
-	GUID_INIT(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
-		  0x04, 0x4a, 0x38, 0xfc)
-
-struct cper_pstore_record {
-	struct cper_record_header hdr;
-	struct cper_section_descriptor sec_hdr;
-	char data[];
-} __packed;
-
 static int reader_pos;
 
 static int erst_open_pstore(struct pstore_info *psi)
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 638507a3c8ff..ad44b3baf10e 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -17,6 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/time.h>
 #include <linux/types.h>
+#include <linux/cper.h>
 
 struct module;
 
@@ -210,6 +211,29 @@ struct pstore_info {
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
 
+#define CPER_CREATOR_PSTORE						\
+	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
+		  0x64, 0x90, 0xb8, 0x9d)
+#define CPER_SECTION_TYPE_DMESG						\
+	GUID_INIT(0xc197e04e, 0xd545, 0x4a70, 0x9c, 0x17, 0xa5, 0x54,	\
+		  0x94, 0x19, 0xeb, 0x12)
+#define CPER_SECTION_TYPE_DMESG_Z					\
+	GUID_INIT(0x4f118707, 0x04dd, 0x4055, 0xb5, 0xdd, 0x95, 0x6d,	\
+		  0x34, 0xdd, 0xfa, 0xc6)
+#define CPER_SECTION_TYPE_MCE						\
+	GUID_INIT(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
+		  0x04, 0x4a, 0x38, 0xfc)
+
+/*
+ * CPER specification (in UEFI specification 2.3 appendix N) requires
+ * byte-packed.
+ */
+struct cper_pstore_record {
+	struct cper_record_header hdr;
+	struct cper_section_descriptor sec_hdr;
+	char data[];
+} __packed;
+
 struct pstore_ftrace_record {
 	unsigned long ip;
 	unsigned long parent_ip;
-- 
2.41.0


