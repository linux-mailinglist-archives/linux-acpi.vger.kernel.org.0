Return-Path: <linux-acpi+bounces-71-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E83B7AD36B
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 10:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E341C281617
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA76E11CA1
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E710A0F;
	Mon, 25 Sep 2023 07:44:45 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97B9EE;
	Mon, 25 Sep 2023 00:44:42 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vsmvt.C_1695627878;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsmvt.C_1695627878)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:44:39 +0800
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
Subject: [RFC PATCH v2 4/9] ACPI: tables: change section_type of generic error data as guid_t
Date: Mon, 25 Sep 2023 15:44:21 +0800
Message-Id: <20230925074426.97856-5-xueshuai@linux.alibaba.com>
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The section_type of generic error data is now an array of u8. It is a
burden to perform explicit type casting from u8[] to guid_t, and to copy
the guid_t values to u8[] using memcpy.

To alleviate this issue, change the section_type from an array to the
type guid_t, which is also consistent with the cper_section_descriptor.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/acpi_extlog.c  | 2 +-
 drivers/acpi/apei/ghes.c    | 2 +-
 drivers/firmware/efi/cper.c | 2 +-
 include/acpi/actbl1.h       | 5 +++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e120a96e1eae..d46435792d64 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -170,7 +170,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			fru_text = gdata->fru_text;
 		else
 			fru_text = "";
-		sec_type = (guid_t *)gdata->section_type;
+		sec_type = &gdata->section_type;
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ef59d6ea16da..d14e00751161 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -648,7 +648,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
-		sec_type = (guid_t *)gdata->section_type;
+		sec_type = &gdata->section_type;
 		sec_sev = ghes_severity(gdata->error_severity);
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
 			fru_id = (guid_t *)gdata->fru_id;
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..a2ba70aa928f 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -527,7 +527,7 @@ static void
 cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata,
 			   int sec_no)
 {
-	guid_t *sec_type = (guid_t *)gdata->section_type;
+	guid_t *sec_type = &gdata->section_type;
 	__u16 severity;
 	char newpfx[64];
 
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8d5572ad48cb..ab25a8495a43 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -19,6 +19,7 @@
  *
  ******************************************************************************/
 
+#include <linux/uuid.h>
 /*
  * Values for description table header signatures for tables defined in this
  * file. Useful because they make it more difficult to inadvertently type in
@@ -1637,7 +1638,7 @@ struct acpi_hest_generic_status {
 /* Generic Error Data entry */
 
 struct acpi_hest_generic_data {
-	u8 section_type[16];
+	guid_t section_type;
 	u32 error_severity;
 	u16 revision;
 	u8 validation_bits;
@@ -1650,7 +1651,7 @@ struct acpi_hest_generic_data {
 /* Extension for revision 0x0300 */
 
 struct acpi_hest_generic_data_v300 {
-	u8 section_type[16];
+	guid_t section_type;
 	u32 error_severity;
 	u16 revision;
 	u8 validation_bits;
-- 
2.41.0


