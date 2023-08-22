Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CB6783738
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Aug 2023 03:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjHVBKG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Aug 2023 21:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjHVBKE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2023 21:10:04 -0400
Received: from mail-pl1-x664.google.com (mail-pl1-x664.google.com [IPv6:2607:f8b0:4864:20::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DAD183
        for <linux-acpi@vger.kernel.org>; Mon, 21 Aug 2023 18:10:02 -0700 (PDT)
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-1bf7423ef3eso11029685ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 21 Aug 2023 18:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1692666601; x=1693271401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWqEbU+U7DESXzuQI5TQ4rpqUMVzrWVa2QLuXHSidTE=;
        b=PKxZ8BarogkkIrj8fKWhjSByzLKF2O+SGPHM9hkCLahYbt0q9vVurHFq7vTCI+Rdzy
         veM7ysPnKZDrOmRLmLXopv/yKnipxaWdSg4z4VWN2BXr4ObFw5z73qKoEXqtsQg76XXH
         cjV4QBxxl5sKwToPA6oS3ZjKF3tN0Voe2ud1oL2EFUPn3tBB8TqEJ5GMOupw0g0Rcr6Q
         OvUYLKKmB9iB606obZfaPf5k4r+Mie3WVOqOfN93bKjs+GlYQRaqSvju/+O6IGZJ6e1t
         q9LW0QshAJP67NWUTlS2QT5thfSleanZThxHUpRmb7NMW2zFpQczvq5JgezZLYVdRpNK
         U5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692666601; x=1693271401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWqEbU+U7DESXzuQI5TQ4rpqUMVzrWVa2QLuXHSidTE=;
        b=ecwqUseayf6xnPT2ytNVOH4S5UcuZMIfuWvhXSv42SGhcODViyp7+WqSwjPEC+kzxT
         9ZWY6L+JEDyOEdDLDTBkP5ngdI5sJNlGNuW6/1rrmxIaO4Yzd6xqIcl4I5jssnadonWo
         D2Pw3kKKbLywnin/8jaN5PYVXedzPIxsr2BTiJzh45dh5jbKnZmdfkWdMIDf/Bj6stir
         RfB5EV45FsBPy8CIKW9v8cDU2RLrEV6/nyqa9LG2b/f2ruR9/FJ452XsqB8SCgZz/Osb
         531dAP1tSFxS8I4HPH1g4rLpzsupi4xX4VVJbuGcjIipbBJGsKYJWOur9TPwIsiLu0zl
         WJ5Q==
X-Gm-Message-State: AOJu0YwtZYc7SnAKvhNLNbnjUsBOL8O8jnomJENMw8khS6sciJ81Dshd
        Vj5DJ8MjSYmfsnbIpWvjbydJ2s9CdQLiLeoxA5butvUrTWb7PbREREIpSLBcvvtAaA==
X-Google-Smtp-Source: AGHT+IHW4XOke+1mTx+7ARgRUCumiY4+/dez95t5GtFyLTloyaKSqErMBzfr7QL6pGyIOb0Uklj3yYadJGUY
X-Received: by 2002:a17:902:e888:b0:1bd:edac:af44 with SMTP id w8-20020a170902e88800b001bdedacaf44mr6919811plg.51.1692666601435;
        Mon, 21 Aug 2023 18:10:01 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id g8-20020a170902740800b001bbb8550252sm327321pll.65.2023.08.21.18.10.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2023 18:10:01 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
        by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 7C111220D6;
        Mon, 21 Aug 2023 19:10:00 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
        id 7534AE4332A; Mon, 21 Aug 2023 19:10:00 -0600 (MDT)
From:   Uday Shankar <ushankar@purestorage.com>
To:     Joern Engel <joern@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Huang Ying <ying.huang@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Uday Shankar <ushankar@purestorage.com>,
        linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] Revert "ACPI, APEI, use raw spinlock in ERST"
Date:   Mon, 21 Aug 2023 19:09:34 -0600
Message-Id: <20230822010933.2247671-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit

commit 3b38bb5f7f06356a89bb2cbf92ad346025e95192
Author: Huang Ying <ying.huang@intel.com>
Date:   Thu Dec 2 10:40:53 2010 +0800

    ACPI, APEI, use raw spinlock in ERST

    ERST writing may be used in NMI or Machine Check Exception handler. So
    it need to use raw spinlock instead of normal spinlock.  This patch
    fixes it.

    Signed-off-by: Huang Ying <ying.huang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

turns erst_lock from a regular spinlock into a raw spinlock. This change
does not help address the fundamental problem of locking in NMI handlers
- NMIs can interrupt anything, including the critical section of the
lock the handler wants to acquire. The change does, however, introduce
an illegal lock nesting pattern - while holding the erst_lock, there is
a code path which calls printk, which may acquire a regular spinlock.
This issue was caught by lockdep, and the report follows. Revert
3b38bb5f7f06 to address the issue.

[ BUG: Invalid wait context ]
6.5.0-iopolicies+ #4 Not tainted
-----------------------------
systemd/1 is trying to lock:
ffffffff9ec053b8 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x325/0x440
other info that might help us debug this:
context-{5:5}
7 locks held by systemd/1:
stack backtrace:
CPU: 2 PID: 1 Comm: systemd Not tainted 6.5.0-iopolicies+ #4
Hardware name:  /0JP31P, BIOS 2.7.0 05/23/2018
Call Trace:
<TASK>
dump_stack_lvl+0x63/0xb0
__lock_acquire+0x434/0xd30
lock_acquire+0xcd/0x2b0
? serial8250_console_write+0x325/0x440
? __lock_acquire+0xab0/0xd30
_raw_spin_lock_irqsave+0x39/0x60
? serial8250_console_write+0x325/0x440
serial8250_console_write+0x325/0x440
? console_flush_all+0x1b5/0x590
console_flush_all+0x1ec/0x590
? console_flush_all+0x184/0x590
console_unlock+0x7c/0xd0
vprintk_emit+0x261/0x380
_printk+0x5c/0x80
erst_read+0x1f8/0x210
? erst_get_record_id_next+0x26f/0x340
erst_read_record+0x29/0xa0
erst_reader+0xad/0x2e0
? __pfx_read_tsc+0x10/0x10
? ktime_get_real_fast_ns+0x47/0xa0
? __pfx_pstore_fill_super+0x10/0x10
pstore_get_backend_records+0xc6/0x2d0
? __pfx_pstore_fill_super+0x10/0x10
pstore_get_records+0x2b/0x50
pstore_fill_super+0xb7/0xd0
mount_single+0x90/0xc0
? security_capable+0x3c/0x60
legacy_get_tree+0x34/0x60
vfs_get_tree+0x2c/0xe0
path_mount+0x703/0xa90
do_mount+0x7d/0xa0
__x64_sys_mount+0xdc/0x100
do_syscall_64+0x3e/0x90
entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x7f3fdafa42be
Code: 48 8b 0d cd 4b 38 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9a 4b 38 00 f7 d8 64 89 01 48
RSP: 002b:00007ffdf2b2be08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000055b567f49e78 RCX: 00007f3fdafa42be
RDX: 000055b567d0294a RSI: 000055b567d02942 RDI: 000055b567d0294a
RBP: 0000000000000007 R08: 0000000000000000 R09: 0000000000000002
R10: 000000000000000e R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffdf2b2c050
</TASK>

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Joern Engel <joern@purestorage.com>
---
 drivers/acpi/apei/erst.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 247989060e29..b2c806840a11 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -78,7 +78,7 @@ static struct erst_erange {
  * It is used to provide exclusive accessing for ERST Error Log
  * Address Range too.
  */
-static DEFINE_RAW_SPINLOCK(erst_lock);
+static DEFINE_SPINLOCK(erst_lock);
 
 static inline int erst_errno(int command_status)
 {
@@ -413,9 +413,9 @@ ssize_t erst_get_record_count(void)
 	if (erst_disable)
 		return -ENODEV;
 
-	raw_spin_lock_irqsave(&erst_lock, flags);
+	spin_lock_irqsave(&erst_lock, flags);
 	count = __erst_get_record_count();
-	raw_spin_unlock_irqrestore(&erst_lock, flags);
+	spin_unlock_irqrestore(&erst_lock, flags);
 
 	return count;
 }
@@ -480,9 +480,9 @@ static int __erst_record_id_cache_add_one(void)
 
 	id = prev_id = first_id = APEI_ERST_INVALID_RECORD_ID;
 retry:
-	raw_spin_lock_irqsave(&erst_lock, flags);
+	spin_lock_irqsave(&erst_lock, flags);
 	rc = __erst_get_next_record_id(&id);
-	raw_spin_unlock_irqrestore(&erst_lock, flags);
+	spin_unlock_irqrestore(&erst_lock, flags);
 	if (rc == -ENOENT)
 		return 0;
 	if (rc)
@@ -777,17 +777,17 @@ int erst_write(const struct cper_record_header *record)
 		return -EINVAL;
 
 	if (erst_erange.attr & ERST_RANGE_NVRAM) {
-		if (!raw_spin_trylock_irqsave(&erst_lock, flags))
+		if (!spin_trylock_irqsave(&erst_lock, flags))
 			return -EBUSY;
 		rc = __erst_write_to_nvram(record);
-		raw_spin_unlock_irqrestore(&erst_lock, flags);
+		spin_unlock_irqrestore(&erst_lock, flags);
 		return rc;
 	}
 
 	if (record->record_length > erst_erange.size)
 		return -EINVAL;
 
-	if (!raw_spin_trylock_irqsave(&erst_lock, flags))
+	if (!spin_trylock_irqsave(&erst_lock, flags))
 		return -EBUSY;
 	memcpy(erst_erange.vaddr, record, record->record_length);
 	rcd_erange = erst_erange.vaddr;
@@ -795,7 +795,7 @@ int erst_write(const struct cper_record_header *record)
 	memcpy(&rcd_erange->persistence_information, "ER", 2);
 
 	rc = __erst_write_to_storage(0);
-	raw_spin_unlock_irqrestore(&erst_lock, flags);
+	spin_unlock_irqrestore(&erst_lock, flags);
 
 	return rc;
 }
@@ -849,9 +849,9 @@ ssize_t erst_read(u64 record_id, struct cper_record_header *record,
 	if (erst_disable)
 		return -ENODEV;
 
-	raw_spin_lock_irqsave(&erst_lock, flags);
+	spin_lock_irqsave(&erst_lock, flags);
 	len = __erst_read(record_id, record, buflen);
-	raw_spin_unlock_irqrestore(&erst_lock, flags);
+	spin_unlock_irqrestore(&erst_lock, flags);
 	return len;
 }
 EXPORT_SYMBOL_GPL(erst_read);
@@ -936,12 +936,12 @@ int erst_clear(u64 record_id)
 	rc = mutex_lock_interruptible(&erst_record_id_cache.lock);
 	if (rc)
 		return rc;
-	raw_spin_lock_irqsave(&erst_lock, flags);
+	spin_lock_irqsave(&erst_lock, flags);
 	if (erst_erange.attr & ERST_RANGE_NVRAM)
 		rc = __erst_clear_from_nvram(record_id);
 	else
 		rc = __erst_clear_from_storage(record_id);
-	raw_spin_unlock_irqrestore(&erst_lock, flags);
+	spin_unlock_irqrestore(&erst_lock, flags);
 	if (rc)
 		goto out;
 	entries = erst_record_id_cache.entries;
-- 
2.25.1

