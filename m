Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C994F22EE
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Apr 2022 08:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiDEGQp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 02:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiDEGQk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 02:16:40 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4B1015A38;
        Mon,  4 Apr 2022 23:14:39 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:37024.1692704233
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.38 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id AEF5A2800A2;
        Tue,  5 Apr 2022 14:14:27 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 9a99a4d8a49d41fc9d9701316cefc90a for keescook@chromium.org;
        Tue, 05 Apr 2022 14:14:37 CST
X-Transaction-ID: 9a99a4d8a49d41fc9d9701316cefc90a
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        robert.moore@intel.com, tony.luck@intel.com, lenb@kernel.org,
        james.morse@arm.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v2] ACPI: APEI: fix missing erst record id
Date:   Tue,  5 Apr 2022 14:14:13 +0800
Message-Id: <1649139253-26656-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

record_id is in the erst_record_id_cache but not in storage,so
erst_read will return -ENOENT, and then goto retry_next,
erst_get_record_id_next skip a record_id. This can result in
printing the records just in the cache.

A reproducer of the problem(retry many times):

[root@localhost erst-inject]# ./erst-inject -c 0xaaaaa00011
[root@localhost erst-inject]# ./erst-inject -p
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00012
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00013
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00014
[root@localhost erst-inject]# ./erst-inject -i 0xaaaaa000006
[root@localhost erst-inject]# ./erst-inject -i 0xaaaaa000007
[root@localhost erst-inject]# ./erst-inject -i 0xaaaaa000008
[root@localhost erst-inject]# ./erst-inject -p
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00012
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00013
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00014
[root@localhost erst-inject]# ./erst-inject -n
total error record count: 6

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 drivers/acpi/apei/erst-dbg.c |  4 +++-
 drivers/acpi/apei/erst.c     | 34 +++++++++++++++++++++++++++++++---
 include/acpi/apei.h          |  1 +
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index c740f0faad39..5b8164280a17 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -113,8 +113,10 @@ static ssize_t erst_dbg_read(struct file *filp, char __user *ubuf,
 retry:
 	rc = len = erst_read(id, erst_dbg_buf, erst_dbg_buf_len);
 	/* The record may be cleared by others, try read next record */
-	if (rc == -ENOENT)
+	if (rc == -ENOENT) {
+		erst_clear_cache(id);
 		goto retry_next;
+	}
 	if (rc < 0)
 		goto out;
 	if (len > ERST_DBG_RECORD_LEN_MAX) {
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 698d67cee052..07d69dc7fd62 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -856,6 +856,31 @@ ssize_t erst_read(u64 record_id, struct cper_record_header *record,
 }
 EXPORT_SYMBOL_GPL(erst_read);
 
+int erst_clear_cache(u64 record_id)
+{
+	int rc, i;
+	u64 *entries;
+
+	if (erst_disable)
+		return -ENODEV;
+
+	rc = mutex_lock_interruptible(&erst_record_id_cache.lock);
+	if (rc)
+		return rc;
+
+	entries = erst_record_id_cache.entries;
+	for (i = 0; i < erst_record_id_cache.len; i++) {
+		if (entries[i] == record_id)
+			entries[i] = APEI_ERST_INVALID_RECORD_ID;
+	}
+	__erst_record_id_cache_compact();
+
+	mutex_unlock(&erst_record_id_cache.lock);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(erst_clear_cache);
+
 int erst_clear(u64 record_id)
 {
 	int rc, i;
@@ -998,14 +1023,17 @@ static ssize_t erst_reader(struct pstore_record *record)
 
 	len = erst_read(record_id, &rcd->hdr, rcd_len);
 	/* The record may be cleared by others, try read next record */
-	if (len == -ENOENT)
+	if (len == -ENOENT) {
+		erst_clear_cache(record_id);
 		goto skip;
-	else if (len < 0 || len < sizeof(*rcd)) {
+	} else if (len < 0 || len < sizeof(*rcd)) {
 		rc = -EIO;
 		goto out;
 	}
-	if (!guid_equal(&rcd->hdr.creator_id, &CPER_CREATOR_PSTORE))
+	if (!guid_equal(&rcd->hdr.creator_id, &CPER_CREATOR_PSTORE)) {
+		erst_clear_cache(record_id);
 		goto skip;
+	}
 
 	record->buf = kmalloc(len, GFP_KERNEL);
 	if (record->buf == NULL) {
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index afaca3a075e8..f8c11ff4115a 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -47,6 +47,7 @@ void erst_get_record_id_end(void);
 ssize_t erst_read(u64 record_id, struct cper_record_header *record,
 		  size_t buflen);
 int erst_clear(u64 record_id);
+int erst_clear_cache(u64 record_id);
 
 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
 void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
-- 
2.23.0

