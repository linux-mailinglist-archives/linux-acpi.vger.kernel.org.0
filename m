Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E06A1F7339
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jun 2020 06:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgFLExW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jun 2020 00:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgFLExW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jun 2020 00:53:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057D5C03E96F;
        Thu, 11 Jun 2020 21:53:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g12so3255574pll.10;
        Thu, 11 Jun 2020 21:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zCSuxwEDtuJ9zf1mhrD1sDdbW3HCFiaQTMtlkEwhjQg=;
        b=JcsAjc7wbX41+n8F9s6SlcLw2idm+q+x/n8TTJXnZimxnYNQsui0Zo6TV2pZ8jVnT7
         lNNjYw1R42kj45fYrPe2M4Kh/iLbRCpdqFIqQ8wZ07GCiY4vwS/ipCyt/r1BpScjdrXS
         RTCeWhu9tHqjqThXOozO3KFYawMFO9KxdO/xW9Ih+DBb6O0Rast/WtgX/we5T2HDHXCt
         OxrLTdcLDVNl4CuYyLEhTr+vkBcy78wdvnQIKHHhIdUcRJdsIsIr+bsDFOwc3u1r2mEf
         +OQ5O1y+xZJNeE35BVjLnhr9ROfILM0GotEhUy5Xw9wf5dOfjKRzXiwsH7fCgf1b8AxO
         2BGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zCSuxwEDtuJ9zf1mhrD1sDdbW3HCFiaQTMtlkEwhjQg=;
        b=QB4Dn5DVwi7IfHYvK8ltXieVF+MMdSgGkuYZD+jVSPN+z1GaSYfC7OMrVbKykA05jK
         Vn3kaaXq5YqcPvRr8fAG+3z+H0mWw2md4xrk4HGOPpk3opWIiwi9INjh9pV5pMXgzQQk
         TPwTxjxO3GNoJ1sUipXG3YtDt9afiw89ioiso8n9gv4ucc2gkaOPn+h7JhkIaO/KB4UQ
         C0Qxx9UHl6QiP6rXF1knkRFue9BbWzRXvDG0QIjfkp+2CXITHjTq1PykQERthXC1TIr3
         gApG6wQ/LF2Rs4ugGT+9LvZGsZD/gJn941UAQ/v/3kgzLxUpmqsLFG6GDSUbPcCxouDs
         2StA==
X-Gm-Message-State: AOAM531UA6fjysv988VlslnI3qfrOelhWE1/pysKifxp5o928HzAIPrE
        h5wb08jMWHLS+XfBH/l57H0=
X-Google-Smtp-Source: ABdhPJww5vV+JroKn6WK+lcyhxjWEBwGZRdmKGmudYnyrLCVr1n8VtcddT8rciIVS+2HFoKQIb0anA==
X-Received: by 2002:a17:90a:f0d4:: with SMTP id fa20mr11226260pjb.160.1591937600684;
        Thu, 11 Jun 2020 21:53:20 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain ([89.46.114.134])
        by smtp.gmail.com with ESMTPSA id w206sm4735757pfc.28.2020.06.11.21.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 21:53:20 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        yuu ichii <byahu140@heisei.be>
Subject: [PATCH] ACPI: sysfs: Fix pm_profile_attr type
Date:   Thu, 11 Jun 2020 21:51:50 -0700
Message-Id: <20200612045149.1837-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When running a kernel with Clang's Control Flow Integrity implemented,
there is a violation that happens when accessing
/sys/firmware/acpi/pm_profile:

$ cat /sys/firmware/acpi/pm_profile
0

$ dmesg
...
[   17.352564] ------------[ cut here ]------------
[   17.352568] CFI failure (target: acpi_show_profile+0x0/0x8):
[   17.352572] WARNING: CPU: 3 PID: 497 at kernel/cfi.c:29 __cfi_check_fail+0x33/0x40
[   17.352573] Modules linked in:
[   17.352575] CPU: 3 PID: 497 Comm: cat Tainted: G        W         5.7.0-microsoft-standard+ #1
[   17.352576] RIP: 0010:__cfi_check_fail+0x33/0x40
[   17.352577] Code: 48 c7 c7 50 b3 85 84 48 c7 c6 50 0a 4e 84 e8 a4 d8 60 00 85 c0 75 02 5b c3 48 c7 c7 dc 5e 49 84 48 89 de 31 c0 e8 7d 06 eb ff <0f> 0b 5b c3 00 00 cc cc 00 00 cc cc 00 85 f6 74 25 41 b9 ea ff ff
[   17.352577] RSP: 0018:ffffaa6dc3c53d30 EFLAGS: 00010246
[   17.352578] RAX: 331267e0c06cee00 RBX: ffffffff83d85890 RCX: ffffffff8483a6f8
[   17.352579] RDX: ffff9cceabbb37c0 RSI: 0000000000000082 RDI: ffffffff84bb9e1c
[   17.352579] RBP: ffffffff845b2bc8 R08: 0000000000000001 R09: ffff9cceabbba200
[   17.352579] R10: 000000000000019d R11: 0000000000000000 R12: ffff9cc947766f00
[   17.352580] R13: ffffffff83d6bd50 R14: ffff9ccc6fa80000 R15: ffffffff845bd328
[   17.352582] FS:  00007fdbc8d13580(0000) GS:ffff9cce91ac0000(0000) knlGS:0000000000000000
[   17.352582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.352583] CR2: 00007fdbc858e000 CR3: 00000005174d0000 CR4: 0000000000340ea0
[   17.352584] Call Trace:
[   17.352586]  ? rev_id_show+0x8/0x8
[   17.352587]  ? __cfi_check+0x45bac/0x4b640
[   17.352589]  ? kobj_attr_show+0x73/0x80
[   17.352590]  ? sysfs_kf_seq_show+0xc1/0x140
[   17.352592]  ? ext4_seq_options_show.cfi_jt+0x8/0x8
[   17.352593]  ? seq_read+0x180/0x600
[   17.352595]  ? sysfs_create_file_ns.cfi_jt+0x10/0x10
[   17.352596]  ? tlbflush_read_file+0x8/0x8
[   17.352597]  ? __vfs_read+0x6b/0x220
[   17.352598]  ? handle_mm_fault+0xa23/0x11b0
[   17.352599]  ? vfs_read+0xa2/0x130
[   17.352599]  ? ksys_read+0x6a/0xd0
[   17.352601]  ? __do_sys_getpgrp+0x8/0x8
[   17.352602]  ? do_syscall_64+0x72/0x120
[   17.352603]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   17.352604] ---[ end trace 7b1fa81dc897e419 ]---

When /sys/firmware/acpi/pm_profile is read, sysfs_kf_seq_show is called,
which in turn calls kobj_attr_show, which gets the ->show callback
member by calling container_of on attr (casting it to struct
kobj_attribute) then calls it.

There is a CFI violation because pm_profile_attr is of type
struct device_attribute but kobj_attr_show calls ->show expecting it
to be from struct kobj_attribute. CFI checking ensures that function
pointer types match when doing indirect calls. Fix pm_profile_attr to
be defined in terms of kobj_attribute so there is no violation or
mismatch.

Fixes: 362b646062b2 ("ACPI: Export FADT pm_profile integer value to userspace")
Link: https://github.com/ClangBuiltLinux/linux/issues/1051
Reported-by: yuu ichii <byahu140@heisei.be>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/acpi/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 3a89909b50a6..76c668c05fa0 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -938,13 +938,13 @@ static void __exit interrupt_stats_exit(void)
 }
 
 static ssize_t
-acpi_show_profile(struct device *dev, struct device_attribute *attr,
+acpi_show_profile(struct kobject *kobj, struct kobj_attribute *attr,
 		  char *buf)
 {
 	return sprintf(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
 }
 
-static const struct device_attribute pm_profile_attr =
+static const struct kobj_attribute pm_profile_attr =
 	__ATTR(pm_profile, S_IRUGO, acpi_show_profile, NULL);
 
 static ssize_t hotplug_enabled_show(struct kobject *kobj,

base-commit: b791d1bdf9212d944d749a5c7ff6febdba241771
-- 
2.27.0

